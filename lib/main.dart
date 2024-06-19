import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'core/services/dependency_injection_service/dependency_injection_service.dart';
import 'core/services/router_service/router_service.dart';

Future<void> main() async {
  await DependencyInjectionService().inject();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late final GoRouter _router = RouterService.createRouter();

  @override
  Widget build(BuildContext context) {
    // Make app fullscreen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
    );
  }
}
