import 'package:eden_tech_test/domain/models/authorized_user.dart';

abstract interface class AuthRepository {
  bool get isAuthorized;
  Stream<AuthorizedUser?> get authorizedUserStream;
  AuthorizedUser? get currentUser;
  Future<AuthorizedUser?> signInWithGoogle();
  Future<void> signOut();
}
