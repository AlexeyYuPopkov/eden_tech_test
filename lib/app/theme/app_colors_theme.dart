import 'package:flutter/material.dart';

import 'app_colors.dart';

final _cache = <Brightness, AppColorsTheme>{};

@immutable
final class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  final Color primaryBody;
  final Color? primaryBodyVariant;
  final Color secondaryBody;
  final Color cardBackground;
  final Color accentPurple;
  final Color appBackground;
  final Color bordersAndSeparators;
  final Color accentPurpleBackground;
  final Color accentPink;
  final Color accentPinkBackground;
  final Color tabMenuUnselected;
  final Color commentsNested;
  final Color selectedPurpleButton;
  final Color updatedItemLight;

  const AppColorsTheme({
    required this.primaryBody,
    required this.primaryBodyVariant,
    required this.secondaryBody,
    required this.cardBackground,
    required this.accentPurple,
    required this.appBackground,
    required this.bordersAndSeparators,
    required this.accentPurpleBackground,
    required this.accentPink,
    required this.accentPinkBackground,
    required this.tabMenuUnselected,
    required this.commentsNested,
    required this.selectedPurpleButton,
    required this.updatedItemLight,
  });

  static AppColorsTheme of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return _cache[brightness] ??= _createWithBrightness(brightness);
  }

  static AppColorsTheme _createWithBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return AppColorsTheme.lightTheme();
      case Brightness.dark:
        return AppColorsTheme.darkTheme();
    }
  }

  factory AppColorsTheme.lightTheme() {
    return const AppColorsTheme(
      primaryBody: AppColors.primaryBodyLight,
      primaryBodyVariant: Color(0xFF202124),
      secondaryBody: AppColors.secondaryBodyLight,
      cardBackground: AppColors.cardBackgroundLight,
      accentPurple: AppColors.accentPurpleLight,
      appBackground: AppColors.appBackgroundLight,
      bordersAndSeparators: AppColors.bordersAndSeparatorsLight,
      accentPurpleBackground: AppColors.accentPurpleBackgroundLight,
      accentPink: AppColors.accentPinkLight,
      accentPinkBackground: AppColors.accentPinkBackgroundLight,
      tabMenuUnselected: AppColors.tabMenuUnselectedLight,
      commentsNested: AppColors.commentsNestedLight,
      selectedPurpleButton: AppColors.selectedPurpleButtonLight,
      updatedItemLight: AppColors.updatedItemLight,
    );
  }

  factory AppColorsTheme.darkTheme() {
    return const AppColorsTheme(
      primaryBody: AppColors.primaryBodyDark,
      primaryBodyVariant: null,
      secondaryBody: AppColors.secondaryBodyDark,
      cardBackground: AppColors.cardBackgroundDark,
      accentPurple: AppColors.accentPurpleDark,
      appBackground: AppColors.appBackgroundDark,
      bordersAndSeparators: AppColors.bordersAndSeparatorsDark,
      accentPurpleBackground: AppColors.accentPurpleBackgroundDark,
      accentPink: AppColors.accentPinkDark,
      accentPinkBackground: AppColors.accentPinkBackgroundDark,
      tabMenuUnselected: AppColors.tabMenuUnselectedDark,
      commentsNested: AppColors.commentsNestedDark,
      selectedPurpleButton: AppColors.selectedPurpleButtonDark,
      updatedItemLight: AppColors.updatedItemDark,
    );
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
      covariant ThemeExtension<AppColorsTheme>? other, double t) {
    if (other is! AppColorsTheme) {
      return this;
    }
    return AppColorsTheme(
      primaryBody: Color.lerp(primaryBody, other.primaryBody, t)!,
      primaryBodyVariant:
          Color.lerp(primaryBodyVariant, other.primaryBodyVariant, t)!,
      secondaryBody: Color.lerp(secondaryBody, other.secondaryBody, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      accentPurple: Color.lerp(accentPurple, other.accentPurple, t)!,
      appBackground: Color.lerp(appBackground, other.appBackground, t)!,
      bordersAndSeparators:
          Color.lerp(bordersAndSeparators, other.bordersAndSeparators, t)!,
      accentPurpleBackground:
          Color.lerp(accentPurpleBackground, other.accentPurpleBackground, t)!,
      accentPink: Color.lerp(accentPink, other.accentPink, t)!,
      accentPinkBackground:
          Color.lerp(accentPinkBackground, other.accentPinkBackground, t)!,
      tabMenuUnselected:
          Color.lerp(tabMenuUnselected, other.tabMenuUnselected, t)!,
      commentsNested: Color.lerp(commentsNested, other.commentsNested, t)!,
      selectedPurpleButton:
          Color.lerp(selectedPurpleButton, other.selectedPurpleButton, t)!,
      updatedItemLight:
          Color.lerp(updatedItemLight, other.updatedItemLight, t)!,
    );
  }

  @override
  AppColorsTheme copyWith({
    Color? primaryBody,
    Color? primaryBodyVariant,
    Color? secondaryBody,
    Color? cardBackground,
    Color? accentPurple,
    Color? appBackground,
    Color? bordersAndSeparators,
    Color? accentPurpleBackground,
    Color? accentPink,
    Color? accentPinkBackground,
    Color? tabMenuUnselected,
    Color? commentsNested,
    Color? selectedPurpleButton,
    Color? updatedItemLight,
    LinearGradient? logoGradient,
  }) {
    return AppColorsTheme(
      primaryBody: primaryBody ?? this.primaryBody,
      primaryBodyVariant: primaryBodyVariant ?? this.primaryBodyVariant,
      secondaryBody: secondaryBody ?? this.secondaryBody,
      cardBackground: cardBackground ?? this.cardBackground,
      accentPurple: accentPurple ?? this.accentPurple,
      appBackground: appBackground ?? this.appBackground,
      bordersAndSeparators: bordersAndSeparators ?? this.bordersAndSeparators,
      accentPurpleBackground:
          accentPurpleBackground ?? this.accentPurpleBackground,
      accentPink: accentPink ?? this.accentPink,
      accentPinkBackground: accentPinkBackground ?? this.accentPinkBackground,
      tabMenuUnselected: tabMenuUnselected ?? this.tabMenuUnselected,
      commentsNested: commentsNested ?? this.commentsNested,
      selectedPurpleButton: selectedPurpleButton ?? this.selectedPurpleButton,
      updatedItemLight: updatedItemLight ?? this.updatedItemLight,
    );
  }
}
