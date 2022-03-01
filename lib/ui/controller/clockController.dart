import 'package:async/async.dart';
import 'package:chessclock/domain/interactor/clockInteractions.dart';
import 'package:chessclock/ui/model/clock.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/data/clockDao.dart';
import '../model/clockData.dart';
import '../view/clockPage.dart' show topClockName, bottomClockName;

class ClockController {
  final Clock _topClock;
  final Clock _bottomClock;
  final ClockInteractions _clockInteractions;

  ClockController._(this._topClock, this._bottomClock, this._clockInteractions);

  factory ClockController() {
    // todo this should not be instantiated here. Implement DI
    var clockInteractions = ClockInteractions(ClockDao());

    clockInteractions.init(addTestData: true);

    var clockInfo = clockInteractions.getAllClockInfo();
    var firstClock = clockInfo.first;

    var topClock = Clock(firstClock.timeControlSegments, 1000);
    var bottomClock = Clock(firstClock.timeControlSegments, 1000);

    return ClockController._(topClock, bottomClock, clockInteractions);
  }

  Stream<ClockData> clockDataStream() {
    var _top = _topClock
        .getValueStream()
        .map((event) => ClockData(topClockName, event));
    var _bottom = _bottomClock
        .getValueStream()
        .map((event) => ClockData(bottomClockName, event));
    return StreamGroup.merge([_top, _bottom]);
  }

  int getTopClockValue() => _topClock.valueMillis;

  int getBottomClockValue() => _bottomClock.valueMillis;

  void topClockTapped() {
    Fimber.d("top clock tapped");
    _topClock.pause();
    _bottomClock.start();
  }

  void bottomClockTapped() {
    Fimber.d("bottom clock tapped");
    _bottomClock.pause();
    _topClock.start();
  }

  void addTapped(BuildContext context) {
    Navigator.pushNamed(context, '/addClock');
  }

  void selectTapped(BuildContext context) {
    Navigator.pushNamed(context, '/selectClock');
  }

  void settingsTapped() {}

  void pauseTapped() {
    _topClock.suspend();
    _bottomClock.suspend();
  }
}
