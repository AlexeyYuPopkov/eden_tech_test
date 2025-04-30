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
      releaseDate: MovieDto._releaseDateFromJson(json['releaseDate'] as String),
    );

Map<String, dynamic> _$MovieDtoToJson(MovieDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'year': instance.year,
      'posterurl': instance.posterUrl,
      'releaseDate': instance.releaseDate?.toIso8601String(),
    };
