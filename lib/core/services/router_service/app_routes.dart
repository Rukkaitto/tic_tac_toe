import 'app_route.dart';

class AppRoutes {
  static const AppRoute home = AppRoute(
    path: '/',
    name: 'Home',
  );

  static const AppRoute uikit = AppRoute(
    path: '/uikit',
    name: 'UIKit',
  );

  static const AppRoute myButton = AppRoute(
    path: 'my_button',
    name: 'MyButton',
  );

  static const AppRoute gameLocalVsLocal = AppRoute(
    path: 'local-vs-local',
    name: 'LocalVsLocal',
  );

  static const AppRoute gameLocalVsComputer = AppRoute(
    path: 'local-vs-computer',
    name: 'LocalVsComputer',
  );

  static const AppRoute gameComputerVsComputer = AppRoute(
    path: 'computer-vs-computer',
    name: 'ComputerVsComputer',
  );
}
