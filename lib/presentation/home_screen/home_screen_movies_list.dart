import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/l10n/localization.dart';
import 'package:eden_tech_test/presentation/widgets/common_shimmer_placeholder.dart';
import 'package:eden_tech_test/presentation/widgets/no_data_placeholder.dart';
import 'package:eden_tech_test/presentation/widgets/sliver_sized_box.dart';
import 'package:flutter/widgets.dart';

import 'widgets/movie_item_widget.dart';

final class HomeScreenMoviesList extends StatelessWidget {
  final List<Movie> movies;
  final bool isLoading;
  final bool hasShimmers;
  final Set<String> favoritesIds;
  final ValueChanged<Movie> onLike;
  final ValueChanged<Movie> onDetails;

  const HomeScreenMoviesList({
    super.key,
    required this.movies,
    required this.isLoading,
    required this.hasShimmers,
    required this.favoritesIds,
    required this.onLike,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = hasShimmers ? 10 : movies.length;
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        const SliverSizedBox(height: Sizes.indent2x),
        if (!isLoading && movies.isEmpty)
          SliverToBoxAdapter(
            child: NoDataPlaceholderScrollable(
              title: context.l10n.commonNoDataPlaceholderText,
            ),
          )
        else
          SliverList.separated(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return hasShimmers
                  ? const _Shimmer()
                  : Builder(builder: (context) {
                      final movie = movies[index];
                      return MovieItemWidget(
                        movie: movie,
                        isFavorite: favoritesIds.contains(movie.id),
                        onLike: () => onLike(movie),
                        onTap: () => onDetails(movie),
                      );
                    });
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: Sizes.indent);
            },
          ),
        const SliverToBoxAdapter(
          child: SafeArea(child: SizedBox()),
        ),
      ],
    );
  }
}

class _Shimmer extends StatelessWidget {
  const _Shimmer();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.indent2x,
      ),
      child: CommonShimmerPlaceholder(
        size: Size.fromHeight(MovieItemWidget.height),
      ),
    );
  }
}
