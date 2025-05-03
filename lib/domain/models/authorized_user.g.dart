// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorized_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizedUser _$AuthorizedUserFromJson(Map<String, dynamic> json) =>
    AuthorizedUser(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      photoUrl: json['photoUrl'] as String,
    );

Map<String, dynamic> _$AuthorizedUserToJson(AuthorizedUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
    };
