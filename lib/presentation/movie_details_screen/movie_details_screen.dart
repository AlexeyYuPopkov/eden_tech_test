import 'package:cached_network_image/cached_network_image.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/l10n/localization.dart';
import 'package:eden_tech_test/presentation/widgets/common_nav_bar_button.dart';
import 'package:eden_tech_test/presentation/widgets/expandable_text.dart';
import 'package:eden_tech_test/presentation/widgets/movie_duration.dart';
import 'package:eden_tech_test/presentation/widgets/movie_rating.dart';
import 'package:eden_tech_test/presentation/widgets/movie_year.dart';

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
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.indent2x,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: Sizes.indent2x,
                    children: [
                      const SizedBox(height: Sizes.indent2x),
                      Text(
                        movie.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: Sizes.tinyIndent,
                        children: [
                          MovieYear(movie: movie, scale: 1.2),
                          MovieDuration(movie: movie, scale: 1.2),
                          MovieRating(movie: movie, scale: 1.2),
                        ],
                      ),
                      ExpandableText(
                        text: movie.storyline,
                        maxLines: 2,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: Sizes.tinyIndent),
                    ],
                  ),
                ),
              ),
              if (movie.actors.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.indent2x,
                      vertical: Sizes.indent,
                    ),
                    child: Text(
                      context.l10n.movieDetailsScreenLabelActors,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              if (movie.actors.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.indent2x,
                  ),
                  sliver: SliverList.separated(
                    itemCount: movie.actors.length,
                    itemBuilder: (context, index) {
                      return Text(
                        movie.actors[index],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: Sizes.tinyIndent,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
