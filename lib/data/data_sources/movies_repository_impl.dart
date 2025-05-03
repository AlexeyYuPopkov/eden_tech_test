import 'dart:convert';
import 'package:eden_tech_test/data/auth/firebase_firestore_service.dart';
import 'package:eden_tech_test/data/mappers/Movie_mapper.dart';
import 'package:eden_tech_test/data/models/movie_dto.dart';
import 'package:eden_tech_test/data/service/get_movies_api.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/domain/repository/movies_repository.dart';

final class MoviesRepositoryImpl implements MoviesRepository {
  final GetMoviesApi _getMoviesApi;
  final FirebaseFirestoreService _favoritesApi;

  MoviesRepositoryImpl({
    required GetMoviesApi getMoviesApi,
    required FirebaseFirestoreService favoritesApi,
  })  : _getMoviesApi = getMoviesApi,
        _favoritesApi = favoritesApi;

  @override
  Future<Iterable<Movie>> fetchMovies() async {
    final moviesStr = await _getMoviesApi.getMovies();
    final moviesJson = jsonDecode(moviesStr) as List<dynamic>;
    return moviesJson.map((e) => MovieMapper.toDomain(MovieDto.fromJson(e)));
  }

  @override
  Future<void> addFavorite({
    required String userId,
    required Movie movie,
  }) async {
    return _favoritesApi.addFavorite(
      userId: userId,
      movie: movie,
    );
  }

  @override
  Future<void> removeFavorite({
    required String userId,
    required Movie movie,
  }) {
    return _favoritesApi.removeFavorite(
      userId: userId,
      movieId: movie.id,
    );
  }

  @override
  Future<bool> isFavorite({
    required String userId,
    required Movie movie,
  }) =>
      _favoritesApi.isFavorite(userId: userId, movieId: movie.id);

  @override
  Stream<Iterable<Movie>> getFavoritesStream(String userId) =>
      _favoritesApi.getFavoritesStream(userId);
}
