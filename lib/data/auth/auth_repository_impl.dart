import 'package:eden_tech_test/domain/auth/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

final class AuthRepositoryImpl implements AuthRepository {
  final _isAuthorizedSignal = BehaviorSubject.seeded(false);

  AuthRepositoryImpl();

  @override
  Future<bool> login(String username, String password) async {
    Future.delayed(const Duration(milliseconds: 500));
    _isAuthorizedSignal.sink.add(true);
    return isAuthorized;
  }

  @override
  Stream<bool> get isAuthorizedStream => _isAuthorizedSignal.distinct();

  @override
  bool get isAuthorized => _isAuthorizedSignal.value;
}
