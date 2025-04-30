import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'movie.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
final class Movie {
  final String id;
  final String title;
  final int year;
  final String posterUrl;
  final Duration? duration;
  final double rating;
  final String storyline;
  final List<String> actors;

  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.posterUrl,
    required this.duration,
    required this.rating,
    required this.storyline,
    required this.actors,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
