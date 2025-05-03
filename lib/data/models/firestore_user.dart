import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'firestore_user.g.dart';

@immutable
@JsonSerializable()
final class FirestoreUser {
  @JsonKey(name: 'id', defaultValue: '')
  final String id;

  const FirestoreUser({required this.id});

  factory FirestoreUser.fromJson(Map<String, dynamic> json) =>
      _$FirestoreUserFromJson(json);

  Map<String, dynamic> toJson() => _$FirestoreUserToJson(this);
}
