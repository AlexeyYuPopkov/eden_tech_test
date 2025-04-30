import 'package:flutter/material.dart';
import 'package:eden_tech_test/app/router/app_router.dart';

import 'app/theme/app_theme.dart';
import 'l10n/localization.dart';

final _appRouter = AppRouter();

void main() => runApp(const App());

final class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: Localization.localizationsDelegates,
      supportedLocales: Localization.supportedLocales,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: _appRouter.router,
    );
  }
}
