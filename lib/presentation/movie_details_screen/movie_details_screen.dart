import 'package:cached_network_image/cached_network_image.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/presentation/widgets/common_nav_bar_button.dart';
import 'package:eden_tech_test/presentation/widgets/movie_rating.dart';
import 'package:eden_tech_test/presentation/widgets/movie_year_and_duration.dart';
import 'package:flutter/material.dart';

final class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    const buttonSizeHeight = 40.0;

    const imageHeightRatio = 0.35;
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final expandedHeight = screenHeight * imageHeightRatio;

    final maxChildRatio = (screenHeight -
            media.padding.top -
            buttonSizeHeight -
            Sizes.indent2x -
            Sizes.indent) /
        screenHeight;

    final minChildRatio =
        1.0 - imageHeightRatio + Sizes.radiusMedium / screenHeight;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            top: Sizes.zero,
            left: Sizes.zero,
            right: Sizes.zero,
            child: CachedNetworkImage(
              imageUrl: movie.posterUrl,
              height: expandedHeight,
              // width: height,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
            top: Sizes.zero,
            left: Sizes.zero,
            right: Sizes.zero,
            child: SafeArea(
              child: AppBar(
                backgroundColor: Colors.transparent,
                leading: const CommonNavBarBack(),
              ),
            ),
          ),
          _BottomSheet(
            maxChildRatio: maxChildRatio,
            minChildRatio: minChildRatio,
            movie: movie,
          ),
        ],
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final double maxChildRatio;
  final double minChildRatio;
  final Movie movie;

  const _BottomSheet({
    required this.maxChildRatio,
    required this.minChildRatio,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: minChildRatio,
      minChildSize: minChildRatio,
      maxChildSize: maxChildRatio,
      builder: (context, controller) => ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Sizes.radiusMedium),
        ),
        clipBehavior: Clip.hardEdge,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
          ),
          child: CustomScrollView(
            controller: controller,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.indent2x),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: Sizes.indent2x,
                    children: [
                      Text(
                        movie.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      MovieYearAndDuration(movie: movie),
                      MovieRating(movie: movie),
                      Text(
                        movie.storyline,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      for (final actor in movie.actors) ...[
                        Text(
                          actor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
