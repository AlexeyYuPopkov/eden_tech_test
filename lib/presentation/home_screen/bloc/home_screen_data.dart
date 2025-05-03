import 'package:eden_tech_test/domain/models/authorized_user.dart';
import 'package:eden_tech_test/domain/models/get_movies_usecase_sort_policy.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/app/tools/optional_box.dart';
import 'package:eden_tech_test/presentation/home_screen/home_screen_tab.dart';
import 'package:equatable/equatable.dart';

final class HomeScreenData extends Equatable {
  final HomeScreenTab tab;

  final OptionalBox<AuthorizedUser> authorizedUser;
  final GetMoviesUsecaseSortPolicy moviesSortPolicy;
  final GetMoviesUsecaseSortPolicy favoritesSortPolicy;
  final List<Movie> movies;
  final List<Movie> favorites;
  final Set<String> favoritesIds;

  bool get isAuthorized => authorizedUser.value != null;

  GetMoviesUsecaseSortPolicy get sortPolicy {
    switch (tab) {
      case MoviesTab():
        return moviesSortPolicy;
      case FavoritesTab():
        return favoritesSortPolicy;
    }
  }

  const HomeScreenData._({
    required this.tab,
    required this.authorizedUser,
    required this.movies,
    required this.favorites,
    required this.favoritesIds,
    required this.moviesSortPolicy,
    required this.favoritesSortPolicy,
  });

  factory HomeScreenData.initial() {
    return const HomeScreenData._(
      tab: MoviesTab(),
      authorizedUser: OptionalBox(null),
      movies: [],
      favorites: [],
      favoritesIds: {},
      moviesSortPolicy: GetMoviesUsecaseSortByYear(),
      favoritesSortPolicy: GetMoviesUsecaseSortByYear(),
    );
  }

  @override
  List<Object?> get props => [
        tab,
        authorizedUser,
        movies,
        favorites,
        moviesSortPolicy,
        favoritesSortPolicy,
      ];

  HomeScreenData copyWith({
    HomeScreenTab? tab,
    OptionalBox<AuthorizedUser>? authorizedUser,
    List<Movie>? movies,
    List<Movie>? favorites,
    GetMoviesUsecaseSortPolicy? moviesSortPolicy,
    GetMoviesUsecaseSortPolicy? favoritesSortPolicy,
  }) {
    final favoritesIds = favorites == null
        ? this.favoritesIds
        : favorites.map((e) => e.id).toSet();
    return HomeScreenData._(
      tab: tab ?? this.tab,
      authorizedUser: authorizedUser ?? this.authorizedUser,
      movies: movies ?? this.movies,
      favorites: favorites ?? this.favorites,
      favoritesIds: favoritesIds,
      moviesSortPolicy: moviesSortPolicy ?? this.moviesSortPolicy,
      favoritesSortPolicy: favoritesSortPolicy ?? this.favoritesSortPolicy,
    );
  }
}
