import 'package:di_storage/di_storage.dart';
import 'package:eden_tech_test/app/di/unauth/unauth_di.dart';
import 'package:eden_tech_test/data/auth/fb_service.dart';
import 'package:eden_tech_test/domain/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:eden_tech_test/app/router/app_router.dart';

import 'app/di/auth/auth_di.dart';
import 'app/theme/app_theme.dart';
import 'l10n/localization.dart';

final _appRouter = AppRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FbAuthService.instance.init();
  UnauthDiScope().bind(DiStorage.shared);

  runApp(const App());
}

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
      builder: (context, child) {
        final AuthRepository authRepository = DiStorage.shared.resolve();
        return StreamBuilder<bool>(
          stream: authRepository.isAuthorizedStream.map(
            (e) {
              DiStorage.shared.removeScope<AuthDiScope>();
              AuthDiScope().bind(DiStorage.shared);
              return e;
            },
          ),
          builder: (context, snapshot) {
            return child ?? const SizedBox.shrink();
          },
        );
      },
    );
  }
}
