import '../../domain/types.dart';

class ClockInfo {
  final List<TimeControlSegment> timeControlSegments;
  final List<TimeControlSegment>? oddsTimeControlSegments;

  final bool hasTimeOdds;
  final Player timeOddsAgainst;

  ClockInfo(this.timeControlSegments, this.oddsTimeControlSegments,
      this.hasTimeOdds, this.timeOddsAgainst);
}

class TimeControlSegment {
  final int baseTimeSeconds;
  final int incrementSeconds;
  final IncrementType incrementType;
  final int triggerAfterNMoves; // name?

  TimeControlSegment(this.baseTimeSeconds, this.incrementSeconds,
      this.incrementType, this.triggerAfterNMoves);
}
