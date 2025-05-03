import 'movie.dart';

sealed class GetMoviesUsecaseSortPolicy {
  const GetMoviesUsecaseSortPolicy();

  int compare(Movie a, Movie b);
}

final class GetMoviesUsecaseSortByYear extends GetMoviesUsecaseSortPolicy {
  const GetMoviesUsecaseSortByYear();

  @override
  int compare(Movie a, Movie b) => b.year.compareTo(a.year);
}

final class GetMoviesUsecaseSortByRating extends GetMoviesUsecaseSortPolicy {
  const GetMoviesUsecaseSortByRating();

  @override
  int compare(Movie a, Movie b) => b.rating.compareTo(a.rating);
}
