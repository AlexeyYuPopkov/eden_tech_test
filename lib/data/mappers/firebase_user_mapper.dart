import 'package:eden_tech_test/domain/models/authorized_user.dart';

import 'package:firebase_auth/firebase_auth.dart';

final class FirebaseUserMapper {
  static AuthorizedUser? toDomain(User? src) {
    return src?.toAuthorizedUser();
  }
}

extension on User {
  AuthorizedUser toAuthorizedUser() {
    return AuthorizedUser(
      id: uid,
      displayName: displayName ?? email ?? phoneNumber ?? '',
      photoUrl: photoURL ?? '',
    );
  }
}
