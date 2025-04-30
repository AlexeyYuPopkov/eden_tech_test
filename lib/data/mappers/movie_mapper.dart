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
      duration: src.duration,
      rating: _calculateRating(src.ratings),
      storyline: src.storyline,
      actors: src.actors,
    );
  }

  static double _calculateRating(List<int> rating) {
    if (rating.isEmpty) {
      return 0.0;
    }
    final result = rating.reduce((a, b) => a + b) / rating.length;
    return (result * 10.0).roundToDouble() / 10.0;
  }
}
