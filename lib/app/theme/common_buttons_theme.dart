import 'package:eden_tech_test/app/theme/app_colors.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:flutter/material.dart';

final _cache = <Brightness, CommonButtonsTheme>{};

@immutable
final class CommonButtonsTheme extends ThemeExtension<CommonButtonsTheme> {
  final ButtonStyle? tabButton;
  final ButtonStyle? appbarButton;
  final ButtonStyle? tabbarButton;
  final ButtonStyle? primaryButton;

  const CommonButtonsTheme({
    required this.tabButton,
    required this.appbarButton,
    required this.tabbarButton,
    required this.primaryButton,
  });

  static CommonButtonsTheme of(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return _cache[brightness] ??= _createWithBrightness(brightness);
  }

  static CommonButtonsTheme _createWithBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return CommonButtonsTheme.lightTheme();
      case Brightness.dark:
        return CommonButtonsTheme.darkTheme();
    }
  }

  factory CommonButtonsTheme.lightTheme() {
    return CommonButtonsTheme(
      tabButton: _Helper.createTabButton(Brightness.light),
      appbarButton: _Helper.createAppbarButton(Brightness.light),
      tabbarButton: TabbarButtonStyle.create(Brightness.light),
      primaryButton: _Helper.primaryButton(Brightness.light),
    );
  }

  factory CommonButtonsTheme.darkTheme() {
    return CommonButtonsTheme(
      tabButton: _Helper.createTabButton(Brightness.dark),
      appbarButton: _Helper.createAppbarButton(Brightness.dark),
      tabbarButton: TabbarButtonStyle.create(Brightness.dark),
      primaryButton: _Helper.primaryButton(Brightness.dark),
    );
  }

  @override
  CommonButtonsTheme lerp(ThemeExtension<CommonButtonsTheme>? other, double t) {
    if (other is! CommonButtonsTheme) {
      return this;
    }

    return CommonButtonsTheme(
      tabButton: ButtonStyle.lerp(tabButton, other.tabButton, t),
      appbarButton: ButtonStyle.lerp(appbarButton, other.appbarButton, t),
      tabbarButton: ButtonStyle.lerp(tabbarButton, other.tabbarButton, t),
      primaryButton: ButtonStyle.lerp(primaryButton, other.primaryButton, t),
    );
  }

  @override
  CommonButtonsTheme copyWith({
    ButtonStyle? contourStyleButton,
    ButtonStyle? tabButton,
    ButtonStyle? appbarButton,
    ButtonStyle? appbarSelectableButton,
    ButtonStyle? tabbarButton,
    ButtonStyle? kudosButton,
    ButtonStyle? primaryButton,
    ButtonStyle? primaryOutlinedButton,
    ButtonStyle? secondaryOutlinedButton,
    ButtonStyle? secondaryIconButton,
  }) {
    return CommonButtonsTheme(
      tabButton: tabButton ?? this.tabButton,
      appbarButton: appbarButton ?? this.appbarButton,
      tabbarButton: tabbarButton ?? this.tabbarButton,
      primaryButton: primaryButton ?? this.primaryButton,
    );
  }
}

final class _Helper {
  static ButtonStyle? createTabButton(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return ButtonStyle(
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          splashFactory: NoSplash.splashFactory,
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100.0)),
            ),
          ),
          side: WidgetStateProperty.all(
            const BorderSide(color: Color(0xffF1F3F4), width: Sizes.thickness),
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => WidgetStateHelper.isHighlighted(states)
                ? AppColors.accentPurpleLight
                : const Color(0xff66686C),
          ),
          minimumSize: const WidgetStatePropertyAll(Size(47.0, 32.0)),
          maximumSize: const WidgetStatePropertyAll(Size.fromHeight(32.0)),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => WidgetStateHelper.isHighlighted(states)
                ? AppColors.accentPurpleBackgroundLight
                : AppColors.cardBackgroundLight,
          ),
        );
      case Brightness.dark:
        return ButtonStyle(
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          splashFactory: NoSplash.splashFactory,
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(86.0)),
            ),
          ),
          side: WidgetStateProperty.all(
            const BorderSide(
              color: AppColors.primaryBodyDark,
              width: Sizes.thickness,
            ),
          ),
          foregroundColor: WidgetStateProperty.all(AppColors.primaryBodyDark),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => WidgetStateHelper.isHighlighted(states)
                ? AppColors.accentPurpleBackgroundDark
                : AppColors.cardBackgroundDark,
          ),
        );
    }
  }

  static ButtonStyle createAppbarButton(
    Brightness brightness, {
    bool isSelectable = false,
  }) {
    switch (brightness) {
      case Brightness.light:
        final foregroundColor = WidgetStateProperty.resolveWith<Color>(
          (states) => WidgetStateHelper.isHighlighted(states)
              ? AppColors.accentPurpleLight
              : const Color(0xff66686C),
        );

        return ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(43.0, 43.0)),
          splashFactory: NoSplash.splashFactory,
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(22.0),
              ),
            ),
          ),
          side: const WidgetStatePropertyAll(BorderSide.none),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          iconColor: foregroundColor,
          foregroundColor: foregroundColor,
          backgroundColor: isSelectable
              ? WidgetStateProperty.all(AppColors.accentPurpleBackgroundLight)
              : WidgetStateProperty.resolveWith<Color>(
                  (states) => WidgetStateHelper.isHighlighted(states)
                      ? AppColors.selectedPurpleButtonLight
                      : AppColors.accentPurpleBackgroundLight,
                ),
        );
      case Brightness.dark:
        return createAppbarButton(Brightness.light, isSelectable: isSelectable);
    }
  }

  static ButtonStyle? primaryButton(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return ButtonStyle(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: Sizes.indent2x),
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          splashFactory: NoSplash.splashFactory,
          side: const WidgetStatePropertyAll(
            BorderSide(style: BorderStyle.none),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => WidgetStateHelper.isHighlighted(states)
                ? const Color(0xff66686C)
                : AppColors.accentPinkLight,
          ),
          minimumSize: const WidgetStatePropertyAll(Size(40.0, 40.0)),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => WidgetStateHelper.isHighlighted(states)
                ? AppColors.bordersAndSeparatorsLight
                : const Color(0xffFBEBF1),
          ),
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        );
      case Brightness.dark:
        return ButtonStyle(
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          splashFactory: NoSplash.splashFactory,
          side: const WidgetStatePropertyAll(
            BorderSide(style: BorderStyle.none),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => WidgetStateHelper.isHighlighted(states)
                ? const Color(0xff66686C)
                : AppColors.accentPinkDark,
          ),
          minimumSize: const WidgetStatePropertyAll(Size(40.0, 40.0)),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => WidgetStateHelper.isHighlighted(states)
                ? AppColors.bordersAndSeparatorsDark
                : const Color(0xffFBEBF1),
          ),
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        );
    }
  }
}

abstract class TabbarButtonStyle {
  static const _height = 56.0;

  static ButtonStyle create(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return TabbarButtonStyle._createLight();
      case Brightness.dark:
        return TabbarButtonStyle._createDark();
    }
  }

  static ButtonStyle _createLight() => ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: Sizes.indentVariant),
        ),
        minimumSize: const WidgetStatePropertyAll(Size(_height, 28.0)),
        textStyle: WidgetStateProperty.resolveWith((states) {
          return TextStyle(
            fontSize: 11.0,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w500,
          );
        }),
        splashFactory: NoSplash.splashFactory,
        side: const WidgetStatePropertyAll(BorderSide.none),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(_height / 2.0),
            ),
          ),
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) {
            return states.contains(WidgetState.selected)
                ? AppColors.accentPurpleBackgroundLight
                : Colors.transparent;
          },
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            return states.contains(WidgetState.selected)
                ? AppColors.accentPurpleBackgroundLight
                : Colors.transparent;
          },
        ),
      );

  static _createDark() => _createLight().copyWith(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            return states.contains(WidgetState.selected)
                ? AppColors.accentPurpleBackgroundDark
                : Colors.transparent;
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) {
            return states.contains(WidgetState.selected)
                ? AppColors.accentPurpleBackgroundDark
                : Colors.transparent;
          },
        ),
      );
}

mixin WidgetStateHelper {
  static bool isHighlighted(Set<WidgetState> states) {
    const highlightedStates = {
      WidgetState.disabled,
      WidgetState.pressed,
      WidgetState.selected,
      WidgetState.focused,
    };
    return states.intersection(highlightedStates).isNotEmpty;
  }
}
