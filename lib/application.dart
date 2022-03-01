import 'package:chessclock/ui/view/addClockPage.dart';
import 'package:chessclock/ui/view/clockPage.dart';
import 'package:chessclock/ui/view/selectClockPage.dart';
import 'package:flutter/material.dart';

class ChessClockApp extends StatelessWidget {
  const ChessClockApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chess Clock',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        // TODO the route names should probably be constant-ized
        routes: {
          '/': (context) => const ClockPage(),
          '/selectClock': (context) => const SelectClockPage(),
          '/addClock': (context) => const AddClockPage(),
        });
  }
}
