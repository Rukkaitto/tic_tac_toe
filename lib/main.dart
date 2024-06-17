import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/services/dependency_injection_service/dependency_injection_service.dart';
import 'core/services/router_service/router_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjectionService().inject();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late final GoRouter _router = RouterService.createRouter();

  ThemeData _buildTheme() {
    final ThemeData baseTheme = ThemeData(brightness: Brightness.light);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.baiJamjureeTextTheme(baseTheme.textTheme),
    );
  }

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
      theme: _buildTheme(),
    );
  }
}
