import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'get_movies_api.g.dart';

@RestApi(baseUrl: 'https://raw.githubusercontent.com/')
abstract class GetMoviesApi {
  factory GetMoviesApi(Dio dio, {String baseUrl}) = _GetMoviesApi;

  @GET('FEND16/movie-json-data/master/json/movies-coming-soon.json')
  Future<String> getMovies();
}
