import 'package:eden_tech_test/domain/error/app_error.dart';
import 'package:eden_tech_test/l10n/localization.dart';
import 'package:flutter/widgets.dart';

import 'app_error_localization.dart';

final class ErrorLocalizationMapper implements AppErrorLocalization {
  static const instance = ErrorLocalizationMapper();

  static const mappers = <AppErrorLocalization>[];

  const ErrorLocalizationMapper();

  @override
  String getMessage(BuildContext context, dynamic error) {
    if (error is AppError && error.message.isNotEmpty) {
      if (error.message.isNotEmpty) {
        return error.message;
      }

      for (final mapper in mappers) {
        final message = mapper.getMessage(context, error);
        if (message.isNotEmpty) {
          return message;
        }
      }

      return context.l10n.commonUndefinedError;
    }

    return context.l10n.commonUndefinedError;
  }
}
