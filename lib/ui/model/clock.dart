import 'dart:async';

import 'package:chessclock/ui/model/clockInfo.dart';
import 'package:fimber/fimber.dart';

import '../../domain/types.dart';

enum State { running, paused, suspended, stopped }

class Clock {
  final List<TimeControlSegment> _timeControl;
  final int _internalIncrementMillis;

  final StreamController<int> _clockUpdateController = StreamController();

  int valueMillis;
  State _state = State.stopped;
  Timer? _timer;
  int _activeTimeControlSegment = 0;
  int _numberOfMoves = 0;

  Clock(
    this._timeControl,
    this._internalIncrementMillis,
  ) : valueMillis = _timeControl
                .firstWhere((it) => it.triggerAfterNMoves == 0)
                .baseTimeSeconds *
            1000;

  Stream<int> getValueStream() => _clockUpdateController.stream.map((event) {
        Fimber.i("received event over stream: $event");
        return event;
      });

  void start() {
    Fimber.d("clock started");
    if (_state == State.running) return;

    _state = State.running;
    Fimber.d("running...");

    applyPrePauseDelay();

    _timer = Timer.periodic(Duration(milliseconds: _internalIncrementMillis),
        (timer) {
      Fimber.d("tick...");
      valueMillis -= _internalIncrementMillis;
      _clockUpdateController.add(valueMillis);
    });
  }

  void pause() {
    if (_state == State.running) {
      Fimber.d("clock paused");
      _timer?.cancel();
      _state = State.paused;

      applyPostPauseDelay();
    }
  }

  void suspend() {
    if (_state == State.running || _state == State.paused) {
      Fimber.d("clock suspended");
      _timer?.cancel();
      _state = State.suspended;
    }
  }

  void cancel() {
    Fimber.d("clock cancelled");
    _timer?.cancel();
    _state = State.stopped;
    valueMillis = 0;
  }

  void applyPrePauseDelay() {
    var currentTimeControl = _timeControl[_activeTimeControlSegment];
    switch (currentTimeControl.incrementType) {
      case IncrementType.fischerStart:
        valueMillis += (currentTimeControl.incrementSeconds * 1000);
        break;
      default:
        // do nothing
        break;
    }
  }

  void applyPostPauseDelay() {
    var currentTimeControl = _timeControl[_activeTimeControlSegment];
    bool valueChanged = false;
    switch (currentTimeControl.incrementType) {
      case IncrementType.fischerEnd:
        valueMillis += (currentTimeControl.incrementSeconds * 1000);
        valueChanged = true;
        break;
      case IncrementType.delay:
        // TODO: Handle this case.
        break;
      case IncrementType.bronstein:
        // TODO: Handle this case.
        break;
      default:
        // do nothing
        break;
    }

    if (valueChanged) {
      // update listeners with updated value
      _clockUpdateController.add(valueMillis);
    }
  }

  void progressToNextTimeControl() {}
}
