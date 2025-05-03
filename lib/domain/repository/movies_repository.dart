import 'package:eden_tech_test/domain/models/movie.dart';

abstract interface class MoviesRepository {
  Future<Iterable<Movie>> fetchMovies();

  Future<void> addFavorite({
    required String userId,
    required Movie movie,
  });

  Future<void> removeFavorite({
    required String userId,
    required Movie movie,
  });

  Future<bool> isFavorite({
    required String userId,
    required Movie movie,
  });

  Stream<Iterable<Movie>> getFavoritesStream(String userId);
}
