import 'package:flutter/material.dart';
import 'app_color_schemes.dart';
import 'app_colors.dart';
import 'app_colors_theme.dart';
import 'app_text_theme.dart';
import 'sizes.dart';

final class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: 'Roboto',
    dividerColor: AppColors.bordersAndSeparatorsLight,
    dividerTheme: const DividerThemeData(
      color: AppColors.bordersAndSeparatorsLight,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.accentPinkLight,
    ),
    textTheme: AppTextTheme.createTextTheme(Brightness.light),
    colorScheme: AppColorSchemes.light,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: AppColors.primaryBodyLight,
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        letterSpacing: 0,
        height: 1.0,
      ),
      toolbarTextStyle: TextStyle(
        color: AppColors.accentPurpleLight,
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        letterSpacing: 0,
        height: 1.0,
      ),
      scrolledUnderElevation: 0.0,
    ),
    scaffoldBackgroundColor: AppColors.appBackgroundLight,
    popupMenuTheme: const PopupMenuThemeData(
      shadowColor: AppColors.secondaryBodyLight,
      color: AppColors.appBackgroundLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.radiusMedium),
        ),
      ),
    ),
    extensions: [
      AppColorsTheme.lightTheme(),
    ],
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: 'Roboto',
    fontFamilyFallback: const ['Roboto'],
    textTheme: AppTextTheme.createTextTheme(Brightness.dark),
    colorScheme: AppColorSchemes.dark,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.accentPinkDark,
    ),
    dividerColor: AppColors.bordersAndSeparatorsDark,
    dividerTheme: const DividerThemeData(
      color: AppColors.bordersAndSeparatorsDark,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: AppColors.primaryBodyDark,
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        letterSpacing: 0,
        height: 1.0,
      ),
      toolbarTextStyle: TextStyle(
        color: AppColors.accentPurpleDark,
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        letterSpacing: 0,
        height: 1.0,
      ),
      scrolledUnderElevation: 0.0,
    ),
    scaffoldBackgroundColor: AppColors.appBackgroundDark,
    popupMenuTheme: const PopupMenuThemeData(
      shadowColor: AppColors.secondaryBodyDark,
      color: AppColors.appBackgroundDark,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.radiusMedium),
        ),
      ),
    ),
    extensions: [
      AppColorsTheme.darkTheme(),
    ],
  );

  static ThemeData of(BuildContext context) {
    return withBrightness(Theme.of(context).brightness);
  }

  static ThemeData withBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return AppTheme.light;
      case Brightness.dark:
        return AppTheme.dark;
    }
  }
}
