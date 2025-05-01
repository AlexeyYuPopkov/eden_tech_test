final class AuthorizedUser {
  final String id;
  final String email;
  final String displayName;
  final String photoUrl;

  const AuthorizedUser({
    required this.id,
    required this.email,
    required this.displayName,
    required this.photoUrl,
  });
}
