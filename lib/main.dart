import 'package:chessclock/application.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';

void main() {
  Fimber.plantTree(DebugTree());

  runApp(const ChessClockApp());
}
