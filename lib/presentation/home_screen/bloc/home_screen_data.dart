import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/domain/usecases/get_movies_usecase.dart';
import 'package:equatable/equatable.dart';

final class HomeScreenData extends Equatable {
  final GetMoviesUsecaseSortPolicy sortPolicy;
  final List<Movie> movies;
  const HomeScreenData._({
    required this.movies,
    required this.sortPolicy,
  });

  factory HomeScreenData.initial() {
    return const HomeScreenData._(
      movies: [],
      sortPolicy: GetMoviesUsecaseSortByYear(),
    );
  }

  @override
  List<Object?> get props => [movies, sortPolicy];

  HomeScreenData copyWith({
    List<Movie>? movies,
    GetMoviesUsecaseSortPolicy? sortPolicy,
  }) {
    return HomeScreenData._(
      movies: movies ?? this.movies,
      sortPolicy: sortPolicy ?? this.sortPolicy,
    );
  }
}
