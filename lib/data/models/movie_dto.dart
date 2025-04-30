import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'movie_dto.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class MovieDto {
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'title', defaultValue: '')
  final String title;
  @JsonKey(name: 'year')
  final String year;
  @JsonKey(name: 'posterurl', defaultValue: '')
  final String posterUrl;
  @JsonKey(name: 'releaseDate', fromJson: _releaseDateFromJson)
  final DateTime? releaseDate;

  const MovieDto({
    required this.id,
    required this.title,
    required this.year,
    required this.posterUrl,
    required this.releaseDate,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDtoToJson(this);

  static DateTime? _releaseDateFromJson(String src) {
    if (src.isEmpty) {
      return null;
    }

    final components = src.split('-');
    final length = components.length;
    if (length < 1) {
      return null;
    }
    final year = int.parse(components[0]);
    if (length < 2) {
      return DateTime(year);
    }
    final month = int.parse(components[1]);
    if (length < 3) {
      return DateTime(year, month);
    }
    final day = int.parse(components[2]);
    return DateTime(year, month, day);
  }
}
