import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/widget_keys.dart';
import '../../../../core/services/router_service/router_service.dart';
import '../../../../core/services/router_service/routes/app_routes.dart';
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
                text: AppLocalizations.of(context)!.playerVsPlayer,
                onPressed: () {
                  RouterService.of(context).go(AppRoutes.gameLocalVsLocal);
                },
              ),
              const SizedBox(height: 20),
              MyButton(
                text: AppLocalizations.of(context)!.playerVsComputer,
                onPressed: () {
                  RouterService.of(context).go(AppRoutes.computerDifficulty);
                },
              ),
              const SizedBox(height: 20),
              MyButton(
                text: AppLocalizations.of(context)!.computerVsComputer,
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
