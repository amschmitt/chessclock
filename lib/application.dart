import 'package:chessclock/ui/view/clockPage.dart';
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
      home: const ClockPage(),
    );
  }
}
