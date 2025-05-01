import 'package:di_storage/di_storage.dart';

final class AuthDiScope extends DiScope {
  @override
  void bind(DiStorage di) {
    // di.bind<AuthRepository>(
    //   module: this,
    //   () => AuthRepositoryImpl(),
    //   lifeTime: const LifeTime.single(),
    // );
  }
}
