import 'package:eden_tech_test/data/mappers/firebase_user_mapper.dart';
import 'package:eden_tech_test/domain/auth/auth_repository.dart';
import 'package:eden_tech_test/domain/error/app_error.dart';
import 'package:eden_tech_test/domain/models/authorized_user.dart';

import 'fb_service.dart';

final class AuthRepositoryImpl implements AuthRepository {
  final FbAuthService _fbAuthService;

  AuthRepositoryImpl({
    required FbAuthService fbAuthService,
  }) : _fbAuthService = fbAuthService;

  @override
  bool get isAuthorized => currentUser != null;

  @override
  AuthorizedUser? get currentUser =>
      FirebaseUserMapper.toDomain(_fbAuthService.currentUser);

  @override
  Stream<AuthorizedUser?> get authorizedUserStream =>
      _fbAuthService.authorizedUserStream.map(FirebaseUserMapper.toDomain);

  @override
  Future<AuthorizedUser?> signInWithGoogle() async {
    try {
      final result = await _fbAuthService.signInWithGoogle().then(
            (user) => FirebaseUserMapper.toDomain(user),
          );

      return result;
    } catch (e) {
      throw AuthError(parentError: e);
    }
  }

  @override
  Future<void> signOut() async => _fbAuthService.signOut();
}

final class AuthError extends AppError {
  const AuthError({super.parentError});
}

final class AuthorizationRequiredError extends AppError {
  const AuthorizationRequiredError({super.parentError});
}
