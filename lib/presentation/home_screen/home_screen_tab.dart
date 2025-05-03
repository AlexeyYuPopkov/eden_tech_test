import 'package:eden_tech_test/app/router/app_router_path.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/l10n/localization.dart';
import 'package:eden_tech_test/presentation/home_screen/bloc/home_screen_event.dart';
import 'package:eden_tech_test/presentation/home_screen/bloc/home_screen_state.dart';
import 'package:eden_tech_test/presentation/home_screen/home_screen_movies_list.dart';
import 'package:eden_tech_test/presentation/widgets/common_toolbar_tabs_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/home_screen_bloc.dart';

sealed class HomeScreenTab extends CommonToolbarTabsWidgetTab {
  const HomeScreenTab();

  static const List<HomeScreenTab> tabs = [
    MoviesTab(),
    FavoritesTab(),
  ];

  Widget build(BuildContext context);
}

final class MoviesTab extends HomeScreenTab {
  const MoviesTab();

  @override
  String getTitle(BuildContext context) => context.l10n.homeScreenTabMovies;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        return HomeScreenMoviesList(
          movies: state.data.movies,
          isLoading: state.isLoading,
          hasShimmers: state.hasShimmers,
          favoritesIds: state.data.favoritesIds,
          onLike: (movie) => _onLike(context, movie),
          onDetails: (movie) => _onDetails(context, movie),
        );
      },
    );
  }

  void _onDetails(BuildContext context, Movie movie) {
    GoRouter.of(context).push(
      AppRouterPath.movieDetails,
      extra: movie.toJson(),
    );
  }

  void _onLike(BuildContext context, Movie movie) {
    context.read<HomeScreenBloc>().add(
          HomeScreenEvent.onLike(movie: movie),
        );
  }
}

final class FavoritesTab extends HomeScreenTab {
  const FavoritesTab();

  @override
  String getTitle(BuildContext context) => context.l10n.homeScreenTabFavorites;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        return HomeScreenMoviesList(
          movies: state.data.favorites,
          isLoading: state.isLoading,
          hasShimmers: state.hasShimmers,
          favoritesIds: state.data.favoritesIds,
          onLike: (movie) => _onLike(context, movie),
          onDetails: (movie) => _onDetails(context, movie),
        );
      },
    );
  }

  void _onDetails(BuildContext context, Movie movie) {
    GoRouter.of(context).push(
      AppRouterPath.movieDetails,
      extra: movie.toJson(),
    );
  }

  void _onLike(BuildContext context, Movie movie) {
    context.read<HomeScreenBloc>().add(
          HomeScreenEvent.onLike(movie: movie),
        );
  }
}
