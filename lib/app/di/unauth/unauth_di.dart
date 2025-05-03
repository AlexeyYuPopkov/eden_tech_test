import 'package:di_storage/di_storage.dart';
import 'package:dio/dio.dart';
import 'package:eden_tech_test/data/auth/auth_repository_impl.dart';
import 'package:eden_tech_test/data/auth/fb_service.dart';
import 'package:eden_tech_test/data/auth/firebase_firestore_service.dart';
import 'package:eden_tech_test/data/data_sources/movies_repository_impl.dart';
import 'package:eden_tech_test/data/service/get_movies_api.dart';
import 'package:eden_tech_test/domain/auth/auth_repository.dart';
import 'package:eden_tech_test/domain/repository/movies_repository.dart';
import 'package:eden_tech_test/domain/usecases/favorites_usecase.dart';
import 'package:eden_tech_test/domain/usecases/get_movies_usecase.dart';

final class UnauthDiScope extends DiScope {
  @override
  void bind(DiStorage di) {
    di.bind<AuthRepository>(
      module: this,
      () => AuthRepositoryImpl(
        fbAuthService: FbAuthService.instance,
      ),
      lifeTime: const LifeTime.single(),
    );

    di.bind<GetMoviesApi>(
      module: this,
      () => GetMoviesApi(
        Dio(),
      ),
      lifeTime: const LifeTime.single(),
    );

    di.bind<FirebaseFirestoreService>(
      module: this,
      () => FirebaseFirestoreService(),
      lifeTime: const LifeTime.single(),
    );

    di.bind<MoviesRepository>(
      module: this,
      () => MoviesRepositoryImpl(
        getMoviesApi: di.resolve(),
        favoritesApi: di.resolve(),
      ),
      lifeTime: const LifeTime.single(),
    );

    di.bind<GetMoviesUsecase>(
      module: this,
      () => GetMoviesUsecase(repository: di.resolve()),
      lifeTime: const LifeTime.single(),
    );

    di.bind<FavoritesUsecase>(
      module: this,
      () => FavoritesUsecase(
        repository: di.resolve(),
        authRepository: di.resolve(),
      ),
      lifeTime: const LifeTime.single(),
    );
  }
}
