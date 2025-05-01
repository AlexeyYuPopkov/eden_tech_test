import 'package:eden_tech_test/domain/error/app_error.dart';
import 'package:eden_tech_test/domain/usecases/get_movies_usecase.dart';
import 'package:eden_tech_test/l10n/localization.dart';
import 'package:flutter/material.dart';

abstract interface class AppErrorLocalization {
  String getMessage(BuildContext context, AppError error);
}

final class GetMoviesUsecaseErrorMapper implements AppErrorLocalization {
  const GetMoviesUsecaseErrorMapper();

  @override
  String getMessage(BuildContext context, AppError error) {
    if (error is GetMoviesUsecaseError) {
      return context.l10n.getMoviesUsecaseError;
    }
    return context.l10n.commonUndefinedError;
  }
}
