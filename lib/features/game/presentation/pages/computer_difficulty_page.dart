import 'package:flutter/material.dart';

import '../../../../core/services/router_service/params/query_param_keys.dart';
import '../../../../core/services/router_service/router_service.dart';
import '../../../../core/services/router_service/routes/app_routes.dart';
import '../../../../core/ui_components/my_button/my_button.dart';
import '../../../../core/ui_components/scrolling_background/scrolling_background.dart';
import '../../domain/entities/entities.dart';

class ComputerDifficultyPage extends StatelessWidget {
  const ComputerDifficultyPage({super.key});

  void _goToGamePage(
    BuildContext context,
    ComputerPlayerDifficulty difficulty,
  ) {
    RouterService.of(context).go(
      AppRoutes.gameLocalVsComputer,
      queryParameters: <String, dynamic>{
        QueryParamKeys.difficulty: difficulty.index.toString(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ScrollingBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyButton(
                text: 'Facile',
                onPressed: () {
                  _goToGamePage(context, ComputerPlayerDifficulty.easy);
                },
              ),
              const SizedBox(height: 20),
              MyButton(
                text: 'Moyen',
                onPressed: () {
                  _goToGamePage(context, ComputerPlayerDifficulty.medium);
                },
              ),
              const SizedBox(height: 20),
              MyButton(
                text: 'Difficile',
                onPressed: () {
                  _goToGamePage(context, ComputerPlayerDifficulty.hard);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
