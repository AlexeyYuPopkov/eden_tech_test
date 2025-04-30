import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:equatable/equatable.dart';

final class HomeScreenData extends Equatable {
  final List<Movie> movies;
  const HomeScreenData._({required this.movies});

  factory HomeScreenData.initial() {
    return const HomeScreenData._(movies: []);
  }

  @override
  List<Object?> get props => [movies];

  HomeScreenData copyWith({
    List<Movie>? movies,
  }) {
    return HomeScreenData._(
      movies: movies ?? this.movies,
    );
  }
}
