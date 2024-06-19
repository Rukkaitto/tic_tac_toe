import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../features/game/domain/entities/entities.dart';
import '../../../features/game/presentation/pages/computer_difficulty_page.dart';
import '../../../features/game/presentation/pages/game_page.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/uikit/presentation/pages/uikit_page.dart';
import '../../ui_components/my_button/demo_page.dart';
import '../../ui_components/my_transition_page/my_transition_page.dart';
import 'params/query_param_keys.dart';
import 'params/query_params.dart';
import 'routes/app_route.dart';
import 'routes/app_routes.dart';

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
            return const HomePage();
          },
          routes: <RouteBase>[
            GoRoute(
              name: AppRoutes.gameLocalVsLocal.name,
              path: AppRoutes.gameLocalVsLocal.path,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return MyTransitionPage<dynamic>(
                  child: GamePage(
                    player1: LocalPlayer(
                      name: AppLocalizations.of(context)!.playerNameNumber(1),
                      cellValue: GameGridCellValue.cross,
                      completer: Completer<Move>(),
                    ),
                    player2: LocalPlayer(
                      name: AppLocalizations.of(context)!.playerNameNumber(2),
                      cellValue: GameGridCellValue.circle,
                      completer: Completer<Move>(),
                    ),
                  ),
                );
              },
            ),
            GoRoute(
              name: AppRoutes.computerDifficulty.name,
              path: AppRoutes.computerDifficulty.path,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return MyTransitionPage<dynamic>(
                  child: const ComputerDifficultyPage(),
                );
              },
              routes: <GoRoute>[
                GoRoute(
                  name: AppRoutes.gameLocalVsComputer.name,
                  path: AppRoutes.gameLocalVsComputer.path,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    final QueryParams queryParams =
                        QueryParams(state.uri.queryParameters);

                    return MyTransitionPage<dynamic>(
                      child: GamePage(
                        player1: LocalPlayer(
                          name: AppLocalizations.of(context)!.playerName,
                          cellValue: GameGridCellValue.cross,
                          completer: Completer<Move>(),
                        ),
                        player2: ComputerPlayer(
                          name: AppLocalizations.of(context)!.computerName,
                          cellValue: GameGridCellValue.circle,
                          difficulty: queryParams.getComputerPlayerDifficulty(
                            QueryParamKeys.difficulty,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              name: AppRoutes.gameComputerVsComputer.name,
              path: AppRoutes.gameComputerVsComputer.path,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return MyTransitionPage<dynamic>(
                  child: GamePage(
                    player1: ComputerPlayer(
                      name: AppLocalizations.of(context)!.computerNameNumber(1),
                      cellValue: GameGridCellValue.cross,
                      difficulty: ComputerPlayerDifficulty.hard,
                    ),
                    player2: ComputerPlayer(
                      name: AppLocalizations.of(context)!.computerNameNumber(2),
                      cellValue: GameGridCellValue.circle,
                      difficulty: ComputerPlayerDifficulty.hard,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        GoRoute(
          name: AppRoutes.uikit.name,
          path: AppRoutes.uikit.path,
          builder: (BuildContext context, GoRouterState state) {
            return const UIKitPage();
          },
          routes: <GoRoute>[
            GoRoute(
              name: AppRoutes.myButton.name,
              path: AppRoutes.myButton.path,
              builder: (BuildContext context, GoRouterState state) {
                return const MyButtonDemoPage();
              },
            ),
          ],
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
