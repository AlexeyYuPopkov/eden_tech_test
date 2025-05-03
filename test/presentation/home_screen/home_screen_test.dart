import 'package:di_storage/di_storage.dart';
import 'package:eden_tech_test/app/theme/app_theme.dart';
import 'package:eden_tech_test/data/auth/firebase_firestore_service.dart';
import 'package:eden_tech_test/data/data_sources/movies_repository_impl.dart';
import 'package:eden_tech_test/data/service/get_movies_api.dart';
import 'package:eden_tech_test/domain/auth/auth_repository.dart';
import 'package:eden_tech_test/domain/repository/movies_repository.dart';
import 'package:eden_tech_test/domain/usecases/favorites_usecase.dart';
import 'package:eden_tech_test/domain/usecases/get_movies_usecase.dart';
import 'package:eden_tech_test/l10n/localization.dart';
import 'package:eden_tech_test/presentation/home_screen/bloc/home_screen_bloc.dart';
import 'package:eden_tech_test/presentation/home_screen/bloc/home_screen_state.dart';
import 'package:eden_tech_test/presentation/home_screen/home_screen.dart';
import 'package:eden_tech_test/presentation/home_screen/widgets/movie_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

import 'home_screen_test_helper.dart';

class MockGetMoviesApi extends Mock implements GetMoviesApi {
  // @override
  // Future<String> getMovies() async {
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   return HomeScreenTestHelper.apiGetMoviesResponceStr;
  // }
}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockFirebaseFirestoreService extends Mock
    implements FirebaseFirestoreService {}

final class TestDiScope extends DiScope {
  @override
  void bind(DiStorage di) {
    di.bind<AuthRepository>(
      module: this,
      () => MockAuthRepository(),
      lifeTime: const LifeTime.single(),
    );

    di.bind<FirebaseFirestoreService>(
      module: this,
      () => MockFirebaseFirestoreService(),
      lifeTime: const LifeTime.single(),
    );

    di.bind<GetMoviesApi>(
      module: this,
      () => MockGetMoviesApi(),
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
      () => GetMoviesUsecase(
        repository: di.resolve(),
      ),
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

void main() {
  setUp(() {
    TestDiScope().bind(DiStorage.shared);
  });

  tearDown(() {
    DiStorage.shared.removeAll();
  });

  group('HomeScreen', () {
    testWidgets('HomeScreen', (WidgetTester tester) async {
      final api = DiStorage.shared.resolve<GetMoviesApi>() as MockGetMoviesApi;
      final authRepo =
          DiStorage.shared.resolve<AuthRepository>() as MockAuthRepository;
      // final firestore = DiStorage.shared.resolve<FirebaseFirestoreService>()
      //     as MockFirebaseFirestoreService;

      when(
        () => authRepo.authorizedUserStream,
      ).thenAnswer(
        (_) => Stream.value(
          null,
          // const AuthorizedUser(
          //   id: 'id',
          //   photoUrl: 'photoUrl',
          // ),
        ),
      );

      when(
        () => api.getMovies(),
      ).thenAnswer(
        (_) async => HomeScreenTestHelper.apiGetMoviesResponceStr,
      );

      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: Localization.localizationsDelegates,
          supportedLocales: Localization.supportedLocales,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          home: const HomeScreen(),
        ),
      );

      when(
        () => api.getMovies(),
      ).thenAnswer(
        (_) async => HomeScreenTestHelper.apiGetMoviesResponceStr,
      );

      await tester.pumpAndSettle();

      final homeScreenBlocConsumer =
          find.byType(BlocConsumer<HomeScreenBloc, HomeScreenState>);

      final bloc =
          tester.element(homeScreenBlocConsumer).read<HomeScreenBloc>();

      expect(homeScreenBlocConsumer, findsOneWidget);

      // expect(find.byType(CurrentUserWidget), findsOneWidget);

      final listItems = find.byType(MovieItemWidget);

      void chechMoviesCount() {
        expect(bloc.data.movies.length, 5);
        expect(listItems, findsAtLeast(4));
      }

      chechMoviesCount();

      void chechMoviesSorting() {
        expect(
          bloc.data.movies.map((e) => e.id).toList(),
          ['1', '2', '5', '3', '4'],
        );

        final moviesIdsList = listItems.evaluate().map((element) {
          final widget = element.widget as MovieItemWidget;
          return widget.movie.id;
        }).toList();

        expect(moviesIdsList, equals(['1', '2', '5', '3']));
      }

      chechMoviesSorting();

      Future<void> changeSorting() async {
        expect(find.text('Sort by rating'), findsOneWidget);
        expect(find.text('Sort by year'), findsNothing);
        await tester.tap(find.text('Sort by rating'));
        await tester.pumpAndSettle();
        expect(find.text('Sort by year'), findsOneWidget);
        expect(find.text('Sort by rating'), findsNothing);
      }

      await changeSorting();

      void chechMoviesSortingAgaint() {
        expect(
          bloc.data.movies.map((e) => e.id).toList(),
          ['1', '5', '4', '2', '3'],
        );
        final moviesIdsList = listItems.evaluate().map((element) {
          final widget = element.widget as MovieItemWidget;
          return widget.movie.id;
        }).toList();

        expect(moviesIdsList, equals(['1', '5', '4', '2']));
      }

      chechMoviesSortingAgaint();
    });
  });
}
