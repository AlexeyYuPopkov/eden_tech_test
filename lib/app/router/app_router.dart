import 'package:di_storage/di_storage.dart';
import 'package:eden_tech_test/app/di/unauth/unauth_di.dart';
import 'package:eden_tech_test/domain/auth/auth_repository.dart';
import 'package:eden_tech_test/presentation/home_screen/home_screen.dart';
import 'package:eden_tech_test/presentation/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_router_path.dart';

final class AppRouter {
  late final AuthRepository authRepository = DiStorage.shared.resolve();

  AppRouter() {
    UnauthDiScope().bind(DiStorage.shared);
  }

  late final _router = GoRouter(
    routes: [
      GoRoute(
        path: AppRouterPath.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRouterPath.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
    ],
    redirect: (context, state) {
      if (authRepository.isAuthorized) {
        return AppRouterPath.home;
      } else {
        return AppRouterPath.login;
      }
    },
  );

  GoRouter get router => _router;
}
