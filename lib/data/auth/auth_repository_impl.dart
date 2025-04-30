import 'package:eden_tech_test/domain/auth/auth_repository.dart';

final class AuthRepositoryImpl implements AuthRepository {
  bool _isAuthorized = false;

  AuthRepositoryImpl();

  @override
  Future<bool> login(String username, String password) async {
    Future.delayed(const Duration(milliseconds: 500));
    _isAuthorized = true;
    return _isAuthorized;
  }

  @override
  bool get isAuthorized => _isAuthorized;
}
