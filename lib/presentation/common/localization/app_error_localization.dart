import 'package:eden_tech_test/data/auth/auth_repository_impl.dart';
import 'package:eden_tech_test/domain/error/app_error.dart';
import 'package:eden_tech_test/domain/usecases/favorites_usecase.dart';
import 'package:eden_tech_test/domain/usecases/get_movies_usecase.dart';
import 'package:eden_tech_test/l10n/localization.dart';
import 'package:flutter/material.dart';

abstract interface class AppErrorLocalization {
  String getMessage(BuildContext context, AppError error);
}

final class AuthErrorMapper implements AppErrorLocalization {
  const AuthErrorMapper();

  @override
  String getMessage(BuildContext context, AppError error) {
    if (error is AuthError) {
      return context.l10n.authError;
    } else if (error is AuthorizationRequiredError) {
      return context.l10n.authRequiredError;
    }
    return '';
  }
}

final class GetMoviesUsecaseErrorMapper implements AppErrorLocalization {
  const GetMoviesUsecaseErrorMapper();

  @override
  String getMessage(BuildContext context, AppError error) {
    if (error is GetMoviesUsecaseError) {
      return context.l10n.errorGetMoviesUsecase;
    }
    return '';
  }
}

final class FavoritesErrorMapper implements AppErrorLocalization {
  const FavoritesErrorMapper();

  @override
  String getMessage(BuildContext context, AppError error) {
    if (error is GetFavoritesUsecaseError) {
      return context.l10n.errorGetFavoritesUsecaseError;
    } else if (error is ToggleFavoritesUsecaseError) {
      return context.l10n.errorToggleFavoritesUsecaseError;
    }
    return '';
  }
}
