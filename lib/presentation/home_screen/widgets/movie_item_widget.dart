import 'package:eden_tech_test/app/tools/exclude_from_tests.dart';
import 'package:eden_tech_test/presentation/widgets/movie_duration.dart';
import 'package:eden_tech_test/presentation/widgets/movie_rating.dart';
import 'package:eden_tech_test/presentation/widgets/movie_year.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:eden_tech_test/domain/models/movie.dart';

final class MovieItemWidget extends StatelessWidget {
  static const height = 120.0;
  final Movie movie;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onLike;

  const MovieItemWidget({
    super.key,
    required this.movie,
    required this.isFavorite,
    this.onTap,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes.radius),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.indent2x),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.radius),
            child: Stack(
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: onTap,
                  child: Row(
                    children: [
                      ExcludeFromTests(
                        placeholder: const SizedBox(
                          height: height,
                          width: height,
                        ),
                        child: movie.posterUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: movie.posterUrl,
                                height: height,
                                width: height,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : const SizedBox(
                                height: height,
                                width: height,
                                child: Icon(Icons.error),
                              ),
                      ),
                      Expanded(
                        child: ColoredBox(
                          color: theme.colorScheme.primaryContainer,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: Padding(
                              padding: const EdgeInsets.all(Sizes.indent2x),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: Sizes.tinyIndent,
                                children: [
                                  Text(
                                    movie.title,
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: Sizes.halfIndent),
                                  MovieYear(movie: movie),
                                  MovieDuration(movie: movie),
                                  MovieRating(movie: movie),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: Sizes.indent2x,
                  bottom: Sizes.indent2x,
                  child: _Like(
                    isFavorite: isFavorite,
                    onPressed: onLike,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _Like extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onPressed;
  const _Like({
    required this.isFavorite,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: Sizes.zero,
      onPressed: onPressed,
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        size: Sizes.iconSmall,
        color: isFavorite
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
