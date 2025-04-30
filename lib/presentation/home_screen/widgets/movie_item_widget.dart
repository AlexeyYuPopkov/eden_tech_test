import 'package:eden_tech_test/presentation/widgets/movie_rating.dart';
import 'package:eden_tech_test/presentation/widgets/movie_year_and_duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:eden_tech_test/domain/models/movie.dart';

final class MovieItemWidget extends StatelessWidget {
  static const height = 100.0;
  final Movie movie;
  final VoidCallback? onTap;

  const MovieItemWidget({super.key, required this.movie, this.onTap});

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
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: onTap,
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: movie.posterUrl,
                    height: height,
                    width: height,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
                            spacing: Sizes.halfIndent,
                            children: [
                              Text(
                                movie.title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              MovieYearAndDuration(movie: movie),
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
          ),
        ),
      ),
    );
  }
}
