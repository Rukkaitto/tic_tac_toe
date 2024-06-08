import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/game/presentation/pages/game_page.dart';
import 'app_route.dart';
import 'app_routes.dart';

class RouterService {
  RouterService(this.context, this.router);

  factory RouterService.of(BuildContext context) {
    return RouterService(context, GoRouter.of(context));
  }

  final BuildContext context;
  final GoRouter router;

  static GoRouter createRouter() {
    final GoRouter router = GoRouter(
      initialLocation: AppRoutes.home.path,
      routes: <RouteBase>[
        GoRoute(
          name: AppRoutes.home.name,
          path: AppRoutes.home.path,
          builder: (BuildContext context, GoRouterState state) {
            return const GamePage();
          },
        ),
      ],
    );

    return router;
  }

  void go(
    AppRoute route, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    router.goNamed(
      route.name,
      queryParameters: queryParameters,
    );
  }

  Future<T?> push<T extends Object?>(
    AppRoute route, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    return router.pushNamed<T>(
      route.name,
      queryParameters: queryParameters,
    );
  }

  void pop<T extends Object?>([T? result]) {
    router.pop<T>(result);
  }
}
