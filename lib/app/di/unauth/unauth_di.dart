import 'package:di_storage/di_storage.dart';
import 'package:dio/dio.dart';
import 'package:eden_tech_test/data/auth/auth_repository_impl.dart';
import 'package:eden_tech_test/data/data_sources/movies_repository_impl.dart';
import 'package:eden_tech_test/data/service/get_movies_api.dart';
import 'package:eden_tech_test/domain/auth/auth_repository.dart';
import 'package:eden_tech_test/domain/repository/movies_repository.dart';
import 'package:eden_tech_test/domain/usecases/get_movies_usecase.dart';

final class UnauthDiScope extends DiScope {
  @override
  void bind(DiStorage di) {
    di.bind<AuthRepository>(
      module: this,
      () => AuthRepositoryImpl(),
      lifeTime: const LifeTime.single(),
    );

    di.bind<GetMoviesApi>(
      module: this,
      () => GetMoviesApi(
        Dio(),
      ),
      lifeTime: const LifeTime.single(),
    );

    di.bind<MoviesRepository>(
      module: this,
      () => MoviesRepositoryImpl(
        getMoviesApi: di.resolve(),
      ),
      lifeTime: const LifeTime.single(),
    );

    di.bind<GetMoviesUsecase>(
      module: this,
      () => GetMoviesUsecase(
        repository: di.resolve(),
      ),
      lifeTime: const LifeTime.single(),
    );
  }
}
