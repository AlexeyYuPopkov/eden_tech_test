import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/presentation/formatters/duration_formatter.dart';
import 'package:flutter/material.dart';

final class MovieYearAndDuration extends StatelessWidget {
  final Movie movie;
  const MovieYearAndDuration({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final durationStr = DurationFormatter.tryFormat(duration: movie.duration);
    return Text.rich(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.bodySmall,
      TextSpan(
        children: [
          TextSpan(
            text: '${movie.year} ',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          if (durationStr.isNotEmpty) ...[
            const TextSpan(text: ' • '),
            TextSpan(
              text: durationStr,
            ),
          ],
        ],
      ),
    );
  }
}
