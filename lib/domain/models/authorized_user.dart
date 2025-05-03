import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'authorized_user.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
final class AuthorizedUser {
  final String id;
  final String displayName;
  final String photoUrl;

  const AuthorizedUser({
    required this.id,
    required this.displayName,
    required this.photoUrl,
  });

  factory AuthorizedUser.fromJson(Map<String, dynamic> json) =>
      _$AuthorizedUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizedUserToJson(this);
}
