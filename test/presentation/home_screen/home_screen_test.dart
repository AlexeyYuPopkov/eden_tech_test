import 'package:di_storage/di_storage.dart';

import 'package:eden_tech_test/app/theme/app_theme.dart';
import 'package:eden_tech_test/data/auth/auth_repository_impl.dart';
import 'package:eden_tech_test/data/data_sources/movies_repository_impl.dart';
import 'package:eden_tech_test/data/service/get_movies_api.dart';
import 'package:eden_tech_test/domain/auth/auth_repository.dart';
import 'package:eden_tech_test/domain/repository/movies_repository.dart';
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

final class TestDiScope extends DiScope {
  @override
  void bind(DiStorage di) {
    di.bind<AuthRepository>(
      module: this,
      () => AuthRepositoryImpl(),
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

void main() {
  setUp(() {
    TestDiScope().bind(DiStorage.shared);
  });

  tearDown(() {
    DiStorage.shared.removeAll();
  });

  group('description', () {
    testWidgets('HomeScreen', (WidgetTester tester) async {
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

      final api = DiStorage.shared.resolve<GetMoviesApi>();

      when(
        () => api.getMovies(),
      ).thenAnswer(
        (_) async => HomeScreenTestHelper.apiGetMoviesResponceStr,
      );

      await tester.pumpAndSettle();

      final homeScreenBlocConsumer =
          find.byType(BlocConsumer<HomeScreenBloc, HomeScreenState>);

      expect(homeScreenBlocConsumer, findsOneWidget);

      final listItems = find.byType(MovieItemWidget);

      void chechMoviesCount() {
        expect(listItems, findsNWidgets(5));
      }

      chechMoviesCount();

      void chechMoviesSorting() {
        final moviesIdsList = listItems.evaluate().map((element) {
          final widget = element.widget as MovieItemWidget;
          return widget.movie.id;
        }).toList();

        expect(moviesIdsList, equals(['1', '2', '5', '3', '4']));
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
        final moviesIdsList = listItems.evaluate().map((element) {
          final widget = element.widget as MovieItemWidget;
          return widget.movie.id;
        }).toList();

        expect(moviesIdsList, equals(['1', '5', '4', '2', '3']));
      }

      chechMoviesSortingAgaint();
    });
  });
}
