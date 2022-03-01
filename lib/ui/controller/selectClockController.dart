import 'package:chessclock/domain/interactor/clockInteractions.dart';
import 'package:chessclock/ui/model/clockInfo.dart';

import '../../domain/data/clockDao.dart';

class SelectClockController {
  final Iterable<ClockInfo> clocks;

  SelectClockController._(this.clocks);

  factory SelectClockController() {
    // TODO bad to have two instances of DAO? probably. DI DI DI
    ClockInteractions clockInteractions = ClockInteractions(ClockDao());

    clockInteractions.init(addTestData: false);

    return SelectClockController._(clockInteractions.getAllClockInfo());
  }
}
