import 'package:collection/collection.dart';
import 'package:eden_tech_test/domain/error/app_error.dart';
import 'package:eden_tech_test/domain/models/get_movies_usecase_sort_policy.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/domain/repository/movies_repository.dart';

final class GetMoviesUsecase {
  final MoviesRepository _repository;

  const GetMoviesUsecase({required MoviesRepository repository})
      : _repository = repository;

  Future<List<Movie>> execute([
    GetMoviesUsecaseSortPolicy sortPolicy = const GetMoviesUsecaseSortByYear(),
  ]) async {
    try {
      final movies = await _repository.fetchMovies();
      return movies.sorted(sortPolicy.compare);
    } catch (e) {
      throw GetMoviesUsecaseError(parentError: e);
    }
  }
}

final class GetMoviesUsecaseError extends AppError {
  const GetMoviesUsecaseError({super.parentError});
}
