import 'package:eden_tech_test/l10n/localization.dart';
import 'package:flutter/material.dart';
import 'package:eden_tech_test/app/theme/app_colors_theme.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:eden_tech_test/domain/models/movie.dart';

final class MovieRating extends StatelessWidget {
  final Movie movie;
  final double scale;

  const MovieRating({
    super.key,
    required this.movie,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppColorsTheme.of(context);
    final rating = movie.rating;

    final textScaler = TextScaler.linear(scale);

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: Sizes.indentVariant,
      children: [
        Text(
          context.l10n.homeScreenLabelRatingPrefix,
          textScaler: textScaler,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Icon(
          Icons.star,
          size: Sizes.iconSmall * scale,
          color: colors.star,
        ),
        Text(
          rating.toString(),
          textScaler: textScaler,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// "homeScreenLabelRatingPrefix": "Rating",
// "homeScreenLabelYearPrefix": "Year",
// "homeScreenLabelDurationPrefix": "Duration"
