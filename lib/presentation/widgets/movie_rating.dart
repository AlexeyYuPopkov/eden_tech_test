import 'package:flutter/material.dart';
import 'package:eden_tech_test/app/theme/app_colors_theme.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:eden_tech_test/domain/models/movie.dart';

final class MovieRating extends StatelessWidget {
  final Movie movie;
  const MovieRating({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppColorsTheme.of(context);
    final rating = movie.rating;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: Sizes.indentVariant,
      children: [
        Icon(
          Icons.star,
          size: Sizes.iconSmall,
          color: colors.star,
        ),
        Text(
          rating.toString(),
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
