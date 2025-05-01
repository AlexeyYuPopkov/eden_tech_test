import 'package:eden_tech_test/app/theme/app_colors_theme.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

final class CommonShimmerPlaceholder extends StatelessWidget {
  final Size size;
  final double? borderRadiusValue;

  const CommonShimmerPlaceholder({
    super.key,
    required this.size,
    this.borderRadiusValue,
  });

  @override
  Widget build(BuildContext context) => CommonShimmer(
        borderRadiusValue: borderRadiusValue,
        child: SizedBox(
          width: size.width,
          height: size.height,
        ),
      );
}

final class CommonShimmer extends StatelessWidget {
  final Widget child;
  final bool isActive;
  final double? borderRadiusValue;

  const CommonShimmer({
    super.key,
    required this.child,
    this.isActive = true,
    this.borderRadiusValue,
  });

  @override
  Widget build(BuildContext context) {
    final shimmerColors = AppColorsTheme.of(context).shimmerColors();
    return isActive
        ? ClipRRect(
            borderRadius:
                BorderRadius.circular(borderRadiusValue ?? Sizes.radius),
            child: Shimmer.fromColors(
              baseColor: shimmerColors.baseColor,
              highlightColor: shimmerColors.highlightColor,
              child: ColoredBox(
                color: shimmerColors.decorationColor,
                child: child,
              ),
            ),
          )
        : child;
  }
}
