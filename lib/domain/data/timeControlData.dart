import 'package:chessclock/domain/data/timeControlSegmentData.dart';
import 'package:hive/hive.dart';

part 'timeControlData.g.dart';

@HiveType(typeId: 0)
class TimeControlData extends HiveObject {
  @HiveField(0)
  bool hasTimeOdds;
  @HiveField(1)
  String timeOddsAgainst;
  @HiveField(2)
  List<TimeControlSegmentData> segments;
  @HiveField(3)
  List<TimeControlSegmentData> altSegments;

  TimeControlData(
    this.hasTimeOdds,
    this.timeOddsAgainst,
    this.segments,
    this.altSegments,
  );
}
