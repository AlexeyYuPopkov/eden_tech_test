import 'package:flutter/material.dart';

import 'app_colors.dart';

final class AppColorSchemes {
  static const light = ColorScheme(
    brightness: Brightness.light,

    /// Main accent purple
    primary: AppColors.accentPurpleLight,

    /// Text/icons on primary (white text on purple assumed)
    onPrimary: AppColors.primaryBodyLight,

    /// Main accent pink
    secondary: AppColors.accentPinkLight,

    /// Text/icons on pink
    onSecondary: AppColors.primaryBodyLight,

    /// Card background
    surface: AppColors.cardBackgroundLight,

    /// Text/icons on cards
    onSurface: AppColors.primaryBodyLight,

    /// Error color
    error: AppColors.accentPinkLight,

    /// Text/icons on error color
    onError: AppColors.primaryBodyLight,

    /// Purple background
    primaryContainer: AppColors.accentPurpleBackgroundLight,

    /// Text/icons on purple container
    onPrimaryContainer: AppColors.accentPurpleLight,

    /// Pink background
    secondaryContainer: AppColors.accentPinkBackgroundLight,

    /// Text/icons on pink container
    onSecondaryContainer: AppColors.accentPinkLight,

    /// Borders and separators
    outline: AppColors.bordersAndSeparatorsLight,

    /// Text on surface variants
    onSurfaceVariant: AppColors.secondaryBodyLight,

    /// Nested comments
    tertiary: AppColors.commentsNestedLight,

    /// Text/icons on tertiary
    onTertiary: AppColors.primaryBodyLight,
  );

  static const dark = ColorScheme(
    brightness: Brightness.dark,

    /// Main accent purple for dark mode
    primary: AppColors.accentPurpleDark, // Main accent purple for dark mode
    /// Text/icons on purple
    onPrimary: AppColors.primaryBodyDark, // Text/icons on purple
    /// Main accent pink
    secondary: AppColors.accentPinkDark, // Main accent pink
    /// Text/icons on pink
    onSecondary: AppColors.primaryBodyDark, // Text/icons on pink
    /// Card background
    surface: AppColors.cardBackgroundDark, // Card background
    /// Text/icons on cards
    onSurface: AppColors.primaryBodyDark, // Text/icons on cards
    /// Error color
    error: AppColors.accentPinkDark, // Error color
    /// Text/icons on error color
    onError: AppColors.primaryBodyDark, // Text/icons on error color
    /// Purple background
    primaryContainer: AppColors.accentPurpleBackgroundDark, // Purple background
    /// Text/icons on purple container
    onPrimaryContainer:
        AppColors.accentPurpleDark, // Text/icons on purple container
    /// Pink background
    secondaryContainer: AppColors.accentPinkBackgroundDark, // Pink background
    /// Text/icons on pink container
    onSecondaryContainer:
        AppColors.accentPinkDark, // Text/icons on pink container
    /// Borders and separators
    outline: AppColors.bordersAndSeparatorsDark, // Borders and separators
    /// Text on surface variants
    onSurfaceVariant: AppColors.secondaryBodyDark, // Text on surface variants

    /// Nested comments
    tertiary: AppColors.commentsNestedDark,

    /// Text/icons on tertiary
    onTertiary: AppColors.primaryBodyDark,
  );
}
