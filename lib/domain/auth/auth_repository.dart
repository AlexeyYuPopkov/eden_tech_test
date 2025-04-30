abstract interface class AuthRepository {
  bool get isAuthorized;
  Future<bool> login(String username, String password);
}
