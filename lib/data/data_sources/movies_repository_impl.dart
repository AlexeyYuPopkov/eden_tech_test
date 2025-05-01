import 'dart:convert';

import 'package:eden_tech_test/data/mappers/Movie_mapper.dart';
import 'package:eden_tech_test/data/models/movie_dto.dart';
import 'package:eden_tech_test/data/service/get_movies_api.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/domain/repository/movies_repository.dart';

final class MoviesRepositoryImpl implements MoviesRepository {
  final GetMoviesApi _getMoviesApi;

  const MoviesRepositoryImpl({required GetMoviesApi getMoviesApi})
      : _getMoviesApi = getMoviesApi;

  @override
  Future<Iterable<Movie>> fetchMovies() async {
    final moviesStr = await _getMoviesApi.getMovies();
    final moviesJson = jsonDecode(moviesStr) as List<dynamic>;

    return moviesJson.map((e) => MovieMapper.toDomain(MovieDto.fromJson(e)));
  }
}
