import 'package:eden_tech_test/app/router/app_router_path.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/domain/usecases/get_movies_usecase.dart';
import 'package:eden_tech_test/l10n/localization.dart';
import 'package:eden_tech_test/presentation/common/dialogs/show_dialog_helper.dart';
import 'package:eden_tech_test/presentation/common/localization/error_localization_mapper.dart';
import 'package:eden_tech_test/presentation/home_screen/bloc/home_screen_state.dart';
import 'package:eden_tech_test/presentation/home_screen/widgets/movie_item_widget.dart';
import 'package:eden_tech_test/presentation/widgets/common_shimmer_placeholder.dart';
import 'package:eden_tech_test/presentation/widgets/no_data_placeholder.dart';
import 'package:eden_tech_test/presentation/widgets/sliver_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/home_screen_bloc.dart';
import 'bloc/home_screen_event.dart';

final class HomeScreen extends StatelessWidget with ShowDialogHelper {
  const HomeScreen({super.key});

  void _listener(BuildContext context, HomeScreenState state) {
    switch (state) {
      case LoadingState():
      case CommonState():
        break;
      case ErrorState():
        final error = state.error;

        final message = ErrorLocalizationMapper.instance.getMessage(
          context,
          error,
        );

        if (message.isNotEmpty) {
          showSnackBar(context: context, text: message);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocProvider(
          create: (context) => HomeScreenBloc(),
          child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
            listener: _listener,
            builder: (context, state) {
              final isLoading = state is LoadingState;
              final itemCount = isLoading ? 10 : state.data.movies.length;

              return AbsorbPointer(
                absorbing: isLoading,
                child: RefreshIndicator(
                  edgeOffset: Sizes.indent2x,
                  onRefresh: () => _onRefresh(context),
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        title: Text(context.l10n.homeScreenTitle),
                        centerTitle: false,
                        floating: true,
                        snap: true,
                        actions: const [
                          _SortButton(),
                          SizedBox(width: Sizes.indent2x),
                        ],
                      ),
                      const SliverSizedBox(height: Sizes.indent2x),
                      if (!isLoading && state.data.movies.isEmpty)
                        SliverToBoxAdapter(
                          child: NoDataPlaceholderScrollable(
                            title: context.l10n.commonNoDataPlaceholderText,
                          ),
                        )
                      else
                        SliverList.separated(
                          itemCount: itemCount,
                          itemBuilder: (context, index) {
                            return isLoading
                                ? const _Shimmer()
                                : MovieItemWidget(
                                    movie: state.data.movies[index],
                                    onTap: () => _onDetails(
                                      context,
                                      state.data.movies[index],
                                    ),
                                  );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: Sizes.indent);
                          },
                        ),
                      const SliverToBoxAdapter(
                        child: SafeArea(child: SizedBox()),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<HomeScreenBloc>().add(const HomeScreenEvent.initial());
  }

  void _onDetails(BuildContext context, Movie movie) {
    GoRouter.of(context).push(
      AppRouterPath.movieDetails,
      extra: movie.toJson(),
    );
  }
}

final class _SortButton extends StatelessWidget {
  const _SortButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeScreenBloc, HomeScreenState,
        GetMoviesUsecaseSortPolicy>(
      selector: (state) => state.data.sortPolicy,
      builder: (context, sortPolicy) {
        final theme = Theme.of(context);
        return CupertinoButton(
          child: Text(
            sortPolicy.getPolicyName(context),
            style: theme.appBarTheme.toolbarTextStyle?.copyWith(
              fontSize: TextSizes.smallVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () => _toggleSortPolicy(context),
        );
      },
    );
  }

  void _toggleSortPolicy(BuildContext context) {
    context.read<HomeScreenBloc>().add(
          const HomeScreenEvent.toggleSortPolicy(),
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

extension on GetMoviesUsecaseSortPolicy {
  String getPolicyName(BuildContext context) {
    switch (this) {
      case GetMoviesUsecaseSortByYear():
        return context.l10n.homeScreenButtonSortByRating;
      case GetMoviesUsecaseSortByRating():
        return context.l10n.homeScreenButtonSortByYear;
    }
  }
}
