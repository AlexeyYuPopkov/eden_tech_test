import 'package:eden_tech_test/domain/models/authorized_user.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/presentation/home_screen/home_screen.dart';
import 'package:eden_tech_test/presentation/login_screen/user_profile_screen.dart';
import 'package:eden_tech_test/presentation/movie_details_screen/movie_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_router_path.dart';

final class AppRouter {
  AppRouter();

  late final _router = GoRouter(
    routes: [
      GoRoute(
        path: AppRouterPath.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            path: AppRouterPath.movieDetails,
            builder: (BuildContext context, GoRouterState state) {
              return MovieDetailsScreen(
                movie: Movie.fromJson(state.extra as Map<String, dynamic>),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRouterPath.userProfile,
        builder: (BuildContext context, GoRouterState state) {
          return UserProfileScreen(
            user: AuthorizedUser.fromJson(state.extra as Map<String, dynamic>),
          );
        },
      ),
    ],
    // redirect: (context, state) {
    //   if (authRepository.isAuthorized) {
    //   } else {
    //   }
    // },
  );

  GoRouter get router => _router;
}
