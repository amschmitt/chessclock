import 'package:chessclock/domain/types.dart';
import 'package:chessclock/ui/controller/selectClockController.dart';
import 'package:flutter/material.dart';

import '../model/clockInfo.dart';

class SelectClockPage extends StatefulWidget {
  const SelectClockPage({Key? key}) : super(key: key);

  @override
  _SelectClockPageState createState() => _SelectClockPageState();
}

class _SelectClockPageState extends State<SelectClockPage> {
  SelectClockController controller = SelectClockController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a Time Control"),
      ),
      body: Column(
        children:
            controller.clocks.map((clockInfo) => clockCard(clockInfo)).toList(),
      ),
    );
  }

  Widget clockCard(ClockInfo info) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          child: Column(
              children: info.timeControlSegments
                  .map((segment) {
                    List<Widget> result = [];
                    if (segment.triggerAfterNMoves != 0) {
                      result.add(nextThresholdRow(segment.triggerAfterNMoves));
                    }
                    result.add(timeControlRow(segment.baseTimeSeconds,
                        segment.incrementSeconds, segment.incrementType));
                    return result;
                  })
                  .expand((it) => it)
                  .toList())));

  Widget timeControlRow(int baseTimeSeconds, int incrementSeconds,
          IncrementType incrementType) =>
      Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Text(formatClockSeconds(baseTimeSeconds), style: emphasized()),
              Text(
                " | ",
                style: emphasized(),
              ),
              Text(
                "$incrementSeconds",
                style: emphasized(),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    incrementType.name,
                    style: muted(),
                  ))
            ],
          ));

  Widget nextThresholdRow(int nextThresholdValue) => Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("after $nextThresholdValue moves"),
          const Icon(
            Icons.arrow_right,
            size: 24,
          )
        ],
      ));

  TextStyle emphasized() => const TextStyle(
        fontSize: 24,
      );

  TextStyle muted() => const TextStyle(fontSize: 20, color: Colors.grey);

  // TODO refactor to utils class
  String formatClockSeconds(int rawSeconds) {
    String seconds = (rawSeconds % 60).toString().padLeft(2, '0');
    String minutes = ((rawSeconds ~/ 60) % 60).toString().padLeft(2, '0');
    String hours = (rawSeconds ~/ 3600).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }
}
