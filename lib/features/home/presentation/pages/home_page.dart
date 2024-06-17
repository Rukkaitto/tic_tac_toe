import 'package:flutter/material.dart';

import '../../../../core/constants/widget_keys.dart';
import '../../../../core/services/router_service/app_routes.dart';
import '../../../../core/services/router_service/router_service.dart';
import '../../../../core/ui_components/my_button/my_button.dart';
import '../../../../core/ui_components/scrolling_background/scrolling_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollingBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyButton(
                key: WidgetKeys.playerVsPlayerButton,
                text: 'Joueur vs. Joueur',
                onPressed: () {
                  RouterService.of(context).go(AppRoutes.gameLocalVsLocal);
                },
              ),
              const SizedBox(height: 20),
              MyButton(
                text: 'Joueur vs. Ordi',
                onPressed: () {
                  RouterService.of(context).go(AppRoutes.gameLocalVsComputer);
                },
              ),
              const SizedBox(height: 20),
              MyButton(
                text: 'Ordi vs. Ordi',
                onPressed: () {
                  RouterService.of(context)
                      .go(AppRoutes.gameComputerVsComputer);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
