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
  // @JsonKey(name: 'releaseDate', fromJson: _releaseDateFromJson)
  // final DateTime? releaseDate;
  @JsonKey(name: 'duration', fromJson: _DurationParser.parseISODuration)
  final Duration? duration;
  @JsonKey(name: 'ratings', defaultValue: [])
  final List<int> ratings;
  @JsonKey(name: 'storyline', defaultValue: '')
  final String storyline;
  @JsonKey(name: 'actors', defaultValue: [])
  final List<String> actors;

  const MovieDto({
    required this.id,
    required this.title,
    required this.year,
    required this.posterUrl,
    required this.duration,
    required this.ratings,
    required this.storyline,
    required this.actors,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDtoToJson(this);
}

final class _DurationParser {
  static Duration? parseISODuration(String isoDuration) {
    if (!isoDuration.startsWith('PT')) {
      return null;
    }

    final String timePart = isoDuration.substring(2);
    final RegExp regExp = RegExp(r'(\d+H)?(\d+M)?(\d+S)?');
    final Match? match = regExp.firstMatch(timePart);

    if (match == null) {
      return null;
    }

    final String? hoursStr = match.group(1);
    final String? minutesStr = match.group(2);
    final String? secondsStr = match.group(3);

    // Парсим числа (если компонент присутствует)
    final int hours = hoursStr != null
        ? int.parse(hoursStr.substring(0, hoursStr.length - 1))
        : 0;
    final int minutes = minutesStr != null
        ? int.parse(minutesStr.substring(0, minutesStr.length - 1))
        : 0;
    final int seconds = secondsStr != null
        ? int.parse(secondsStr.substring(0, secondsStr.length - 1))
        : 0;

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
}
