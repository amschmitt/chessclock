import 'package:async/async.dart';
import 'package:chessclock/ui/model/clock.dart';
import 'package:fimber/fimber.dart';

import '../model/clockData.dart';
import '../view/clockPage.dart' show topClockName, bottomClockName;

class ClockController {
  final Clock _topClock = Clock(3600, 1000);
  final Clock _bottomClock = Clock(3600, 1000);

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

  void addTapped() {}

  void settingsTapped() {}

  void pauseTapped() {
    _topClock.pause();
    _bottomClock.pause();
  }
}
