import 'package:hive/hive.dart';

part 'timeControlSegmentData.g.dart';

@HiveType(typeId: 1)
class TimeControlSegmentData extends HiveObject {
  @HiveField(0)
  int baseTimeSeconds;
  @HiveField(1)
  int incrementSeconds;
  @HiveField(2)
  int incrementType;
  @HiveField(3)
  int triggerAfterNMoves;

  TimeControlSegmentData(
    this.baseTimeSeconds,
    this.incrementSeconds,
    this.incrementType,
    this.triggerAfterNMoves,
  );
}
