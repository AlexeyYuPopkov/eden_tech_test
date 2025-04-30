import 'package:eden_tech_test/app/theme/common_buttons_theme.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:flutter/material.dart';

final class CommonNavBarButton extends StatelessWidget {
  static const buttonSize = 43.0;

  final Widget iconWidget;
  final Color? color;
  final VoidCallback? onTap;
  final Color? bgColor;
  final double btnSize;

  const CommonNavBarButton({
    super.key,
    required this.iconWidget,
    this.color,
    required this.onTap,
    this.bgColor,
    this.btnSize = buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    final style = CommonButtonsTheme.of(context);

    return SizedBox(
      width: btnSize,
      height: btnSize,
      child: Center(
        child: TextButton(
          style: style.appbarButton?.copyWith(
            backgroundColor: WidgetStateProperty.all(bgColor),
          ),
          onPressed: onTap,
          child: iconWidget,
        ),
      ),
    );
  }
}

final class CommonNavBarBack extends StatelessWidget {
  final VoidCallback? onTap;
  const CommonNavBarBack({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: Sizes.indent),
      child: SizedBox(
        width: CommonNavBarButton.buttonSize,
        height: CommonNavBarButton.buttonSize,
        child: CommonNavBarButton(
          bgColor: theme.colorScheme.primaryContainer,
          iconWidget: Icon(
            Icons.arrow_back,
            color: theme.colorScheme.primary,
          ),
          onTap: onTap ?? () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }
}
