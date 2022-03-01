import 'package:chessclock/application.dart';
import 'package:chessclock/domain/data/timeControlData.dart';
import 'package:chessclock/domain/data/timeControlSegmentData.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  Fimber.plantTree(DebugTree());

  Hive.registerAdapter(TimeControlDataAdapter());
  Hive.registerAdapter(TimeControlSegmentDataAdapter());

  await Hive.initFlutter();
  await Hive.openBox<TimeControlData>('clocks');

  runApp(const ChessClockApp());
}
