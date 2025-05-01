import 'package:eden_tech_test/app/theme/app_images.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final class NoDataPlaceholderScrollable extends StatelessWidget {
  static const size = 122.0;
  static const minHeight = 280.0;
  final String title;

  final double? height;
  final Widget? child;

  const NoDataPlaceholderScrollable({
    super.key,
    this.height,
    this.title = '',
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(top: screenSize.height * 0.2),
      child: Center(
        child: SingleChildScrollView(
          physics: height != null
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: height,
            child: Center(
              child: NoDataPlaceholder(
                title: title,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class NoDataPlaceholder extends StatelessWidget {
  static const size = 122.0;
  final String title;

  final Widget? child;

  const NoDataPlaceholder({
    super.key,
    this.title = '',
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: Sizes.indent2x),
          SvgPicture.asset(
            AppImages.noDataPlaceholder,
            width: size,
            height: size,
          ),
          if (title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: Sizes.indent4x),
              child: Text(
                title,
                style: theme.textTheme.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
