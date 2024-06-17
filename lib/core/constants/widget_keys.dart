import 'package:flutter/material.dart';

class WidgetKeys {
  static const Key playerVsPlayerButton = Key('playerVsPlayerButton');
  static const Key winnerDialog = Key('winnerDialog');
  static const Key tieDialog = Key('tieDialog');
  static Key gridCell(int index) => Key('gridCell$index');
  static Key gridCellValue(int index) => Key('gridCellValue$index');
}
