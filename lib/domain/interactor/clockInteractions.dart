import 'package:chessclock/domain/types.dart';

import '../../ui/model/clockInfo.dart';
import '../data/clockDao.dart';

class ClockInteractions {
  final ClockDao _dao;

  ClockInteractions(this._dao);

  void init({bool addTestData = false}) {
    _dao.init(addTestData: addTestData);
  }

  Iterable<ClockInfo> getAllClockInfo() {
    return _dao.getStoredClocks().map((clockData) => ClockInfo(
          clockData.segments.map((data) {
            return TimeControlSegment(
              data.baseTimeSeconds,
              data.incrementSeconds,
              IncrementType.values[data.incrementType],
              data.triggerAfterNMoves,
            );
          }).toList(),
          clockData.altSegments.map((data) {
            return TimeControlSegment(
              data.baseTimeSeconds,
              data.incrementSeconds,
              IncrementType.values[data.incrementType],
              data.triggerAfterNMoves,
            );
          }).toList(),
          clockData.hasTimeOdds,
          Player.values.firstWhere(
              (element) => element.name == clockData.timeOddsAgainst),
        ));
  }
}
