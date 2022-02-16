import 'dart:async';

import 'package:fimber/fimber.dart';

enum State { RUNNING, PAUSED, STOPPED }

class Clock {
  final int _initialSeconds;
  final int _incrementMillis;

  final StreamController<int> _clockUpdateController = StreamController();

  int valueMillis;
  State _state = State.STOPPED;
  Timer? _timer;

  Clock(this._initialSeconds, this._incrementMillis)
      : valueMillis = _initialSeconds * 1000;

  Stream<int> getValueStream() => _clockUpdateController.stream.map((event) {
        Fimber.i("received event over stream: $event");
        return event;
      });

  void start() {
    Fimber.d("clock started");
    if (_state == State.RUNNING) return;
    if (_state != State.PAUSED) valueMillis = _initialSeconds * 1000;

    _state = State.RUNNING;

    Fimber.d("running...");
    _timer = Timer.periodic(Duration(milliseconds: _incrementMillis), (timer) {
      Fimber.d("tick...");
      valueMillis -= _incrementMillis;
      _clockUpdateController.add(valueMillis);
    });
  }

  void pause() {
    if (_state == State.RUNNING) {
      Fimber.d("clock paused");
      _timer?.cancel();
      _state = State.PAUSED;
    }
  }

  void cancel() {
    Fimber.d("clock cancelled");
    _timer?.cancel();
    _state = State.STOPPED;
    valueMillis = 0;
  }
}
