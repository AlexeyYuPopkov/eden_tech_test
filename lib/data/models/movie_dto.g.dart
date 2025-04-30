// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDto _$MovieDtoFromJson(Map<String, dynamic> json) => MovieDto(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      year: json['year'] as String,
      posterUrl: json['posterurl'] as String? ?? '',
      duration: _DurationParser.parseISODuration(json['duration'] as String),
      ratings: (json['ratings'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      storyline: json['storyline'] as String? ?? '',
      actors: (json['actors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$MovieDtoToJson(MovieDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'year': instance.year,
      'posterurl': instance.posterUrl,
      'duration': instance.duration?.inMicroseconds,
      'ratings': instance.ratings,
      'storyline': instance.storyline,
      'actors': instance.actors,
    };
