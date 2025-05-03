import 'package:collection/collection.dart';
import 'package:eden_tech_test/data/auth/auth_repository_impl.dart';
import 'package:eden_tech_test/domain/auth/auth_repository.dart';
import 'package:eden_tech_test/domain/error/app_error.dart';

import 'package:eden_tech_test/domain/models/get_movies_usecase_sort_policy.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/domain/repository/movies_repository.dart';

final class FavoritesUsecase {
  final MoviesRepository _repository;
  final AuthRepository _authRepository;

  const FavoritesUsecase({
    required MoviesRepository repository,
    required AuthRepository authRepository,
  })  : _repository = repository,
        _authRepository = authRepository;

  Stream<List<Movie>> getFavoritesStream([
    GetMoviesUsecaseSortPolicy sortPolicy = const GetMoviesUsecaseSortByYear(),
  ]) {
    final user = _authRepository.currentUser;
    if (user == null) {
      return const Stream.empty();
    }
    return _repository.getFavoritesStream(user.id).map((e) {
      final result = e.sorted(sortPolicy.compare);
      return result;
    });
  }

  Future<void> toggleFavorite({
    required Movie movie,
  }) async {
    try {
      final user = _authRepository.currentUser;
      if (user == null) {
        throw const AuthorizationRequiredError();
      }

      final isFavorite = await _repository.isFavorite(
        userId: user.id,
        movie: movie,
      );

      if (isFavorite) {
        await _repository.removeFavorite(userId: user.id, movie: movie);
      } else {
        await _repository.addFavorite(userId: user.id, movie: movie);
      }
    } catch (e) {
      throw ToggleFavoritesUsecaseError(parentError: e);
    }
  }
}

final class GetFavoritesUsecaseError extends AppError {
  const GetFavoritesUsecaseError({super.parentError});
}

final class ToggleFavoritesUsecaseError extends AppError {
  const ToggleFavoritesUsecaseError({super.parentError});
}
