import 'package:flutter/material.dart';

import 'app_colors.dart'; // Add this line

final class AppTextTheme {
  static TextTheme createTextTheme(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _createTextThemeWithTextColor(AppColors.primaryBodyLight);
      case Brightness.dark:
        return _createTextThemeWithTextColor(AppColors.primaryBodyDark);
    }
  }

  static TextTheme _createTextThemeWithTextColor(Color textColor) {
    return const TextTheme().apply(
      bodyColor: textColor,
    );
  }
}
