// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as String,
      title: json['title'] as String,
      year: (json['year'] as num).toInt(),
      posterUrl: json['posterUrl'] as String,
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
      rating: (json['rating'] as num).toDouble(),
      storyline: json['storyline'] as String,
      actors:
          (json['actors'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'year': instance.year,
      'posterUrl': instance.posterUrl,
      'duration': instance.duration?.inMicroseconds,
      'rating': instance.rating,
      'storyline': instance.storyline,
      'actors': instance.actors,
    };
