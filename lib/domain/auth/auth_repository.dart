abstract interface class AuthRepository {
  bool get isAuthorized;
  Stream<bool> get isAuthorizedStream;
  Future<bool> login(String username, String password);
}
