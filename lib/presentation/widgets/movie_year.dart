import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/l10n/localization.dart';
import 'package:flutter/material.dart';

final class MovieYear extends StatelessWidget {
  final Movie movie;
  final double scale;

  const MovieYear({
    super.key,
    required this.movie,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textScaler = TextScaler.linear(scale);

    return Text.rich(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textScaler: textScaler,
      style: theme.textTheme.bodySmall,
      TextSpan(
        children: [
          TextSpan(
            text: context.l10n.homeScreenLabelYearPrefix,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const WidgetSpan(child: SizedBox(width: Sizes.indentVariant)),
          TextSpan(
            text: '${movie.year} ',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
