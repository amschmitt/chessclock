import 'package:chessclock/ui/controller/clockController.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';

import '../model/clockData.dart';

const String topClockName = "TOP_CLOCK";
const String bottomClockName = "BOTTOM_CLOCK";

class ClockPage extends StatefulWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  ClockController controller = ClockController();
  String _topClockText = "00:00:00";
  String _bottomClockText = "00:00:00";

  @override
  Widget build(BuildContext context) {
    _topClockText = formatClockMillis(controller.getTopClockValue());
    _bottomClockText = formatClockMillis(controller.getBottomClockValue());

    return Scaffold(
        body: StreamBuilder<ClockData>(
            stream: controller.clockDataStream(),
            builder: (context, state) {
              var data = state.data;
              Fimber.i(
                  "received data over stream: ${data?.clockName}:${data?.clockTimeMillis}");
              var newDataClockName = data?.clockName;
              var newDataClockValue = data?.clockTimeMillis;
              if (newDataClockValue != null && newDataClockName != null) {
                if (newDataClockName == topClockName) {
                  _topClockText = formatClockMillis(newDataClockValue);
                } else if (newDataClockName == bottomClockName) {
                  _bottomClockText = formatClockMillis(newDataClockValue);
                }
              }

              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  clockCard(true),
                  Expanded(child: controlPanel()),
                  clockCard(false)
                ],
              ));
            }));
  }

  Widget clockCard(bool rotated) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          child: InkWell(
              onTap: () {
                rotated
                    ? controller.topClockTapped()
                    : controller.bottomClockTapped();
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 160.0),
                      child: RotatedBox(
                        quarterTurns: rotated ? 2 : 0,
                        child: Text(
                          rotated ? _topClockText : _bottomClockText,
                          style: const TextStyle(fontSize: 48),
                        ),
                      ))))));

  Widget controlPanel() => Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              child: Icon(Icons.settings, size: 40.0),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              child: Icon(Icons.add, size: 40.0),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: IconButton(
                  icon: const Icon(Icons.pause, size: 40.0),
                  onPressed: () => controller.pauseTapped(),
                )),
          ],
        ),
      );

  String formatClockMillis(int millis) {
    int rawSeconds = millis ~/ 1000;
    String seconds = (rawSeconds % 60).toString().padLeft(2, '0');
    String minutes = ((rawSeconds ~/ 60) % 60).toString().padLeft(2, '0');
    String hours = (rawSeconds ~/ 3600).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }
}
