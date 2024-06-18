import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/core/constants/widget_keys.dart';

import 'robot.dart';

class GameRobot extends Robot {
  GameRobot(super.tester);

  Future<void> tapPlayerVsPlayerButton() async {
    final Finder playerVsPlayerButton =
        find.byKey(WidgetKeys.playerVsPlayerButton);
    expect(playerVsPlayerButton, findsOneWidget);

    await tester.tap(playerVsPlayerButton);
    await tester.pumpAndSettle();
  }

  Future<void> tapGridCell(int index) async {
    final Finder gridCell = find.byKey(WidgetKeys.gridCell(index));
    expect(gridCell, findsOneWidget);

    await tester.tap(gridCell);
    await tester.pumpAndSettle();
    expect(find.byKey(WidgetKeys.gridCellValue(index)), findsOneWidget);
  }

  void verifyWinnerDialog() {
    expect(find.byKey(WidgetKeys.winnerDialog), findsOneWidget);
  }

  void verifyTieDialog() {
    expect(find.byKey(WidgetKeys.tieDialog), findsOneWidget);
  }
}
