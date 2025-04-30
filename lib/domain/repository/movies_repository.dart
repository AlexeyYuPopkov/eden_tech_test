import 'package:eden_tech_test/domain/models/movie.dart';

abstract interface class MoviesRepository {
  Future<Iterable<Movie>> fetchMovies();
}
