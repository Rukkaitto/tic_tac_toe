import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tic_tac_toe/core/services/dependency_injection_service/dependency_injection_service.dart';
import 'package:tic_tac_toe/core/services/enviromnent_service/environment_service.dart';
import 'package:tic_tac_toe/main.dart' as app;

import 'robots/game_robot.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await app.main();
  sl<EnvironmentService>().isUITest = true;

  group('end-to-end test', () {
    testWidgets('play a full game ending in a tie',
        (WidgetTester tester) async {
      await tester.pumpWidget(app.MyApp());

      final GameRobot gameRobot = GameRobot(tester);

      await gameRobot.tapPlayerVsPlayerButton();
      await gameRobot.tapGridCell(1);
      await gameRobot.tapGridCell(0);
      await gameRobot.tapGridCell(4);
      await gameRobot.tapGridCell(7);
      await gameRobot.tapGridCell(3);
      await gameRobot.tapGridCell(5);
      await gameRobot.tapGridCell(2);
      await gameRobot.tapGridCell(6);
      await gameRobot.tapGridCell(8);
      gameRobot.verifyTieDialog();
    });

    testWidgets('play a full game ending in a win',
        (WidgetTester tester) async {
      await tester.pumpWidget(app.MyApp());

      final GameRobot gameRobot = GameRobot(tester);

      await gameRobot.tapPlayerVsPlayerButton();
      await gameRobot.tapGridCell(0);
      await gameRobot.tapGridCell(1);
      await gameRobot.tapGridCell(3);
      await gameRobot.tapGridCell(4);
      await gameRobot.tapGridCell(6);
      gameRobot.verifyWinnerDialog();
    });
  });
}
