import 'package:chessclock/domain/data/timeControlData.dart';
import 'package:chessclock/domain/data/timeControlSegmentData.dart';
import 'package:chessclock/domain/types.dart';
import 'package:hive/hive.dart';

class ClockDao {
  late Box<TimeControlData> clocksBox;

  void init({bool addTestData = false}) {
    clocksBox = Hive.box('clocks');

    // remove, just for testing (standard 5|2 clock)
    clocksBox.add(TimeControlData(false, "black", [
      TimeControlSegmentData(300, 2, IncrementType.fischerEnd.index, 0),
      TimeControlSegmentData(60, 1, IncrementType.fischerEnd.index, 20),
    ], []));
  }

  Iterable<TimeControlData> getStoredClocks() {
    return clocksBox.values;
  }

  Future<int> addClockData(TimeControlData dataToAdd) async {
    return await clocksBox.add(dataToAdd);
  }
}
