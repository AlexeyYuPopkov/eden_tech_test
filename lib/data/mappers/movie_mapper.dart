import 'package:eden_tech_test/data/models/movie_dto.dart';
import 'package:eden_tech_test/domain/models/movie.dart';

final class MovieMapper {
  const MovieMapper();

  static Movie toDomain(MovieDto src) {
    return Movie(
      id: src.id,
      title: src.title,
      year: int.parse(src.year),
      posterUrl: src.posterUrl,
    );
  }
}
