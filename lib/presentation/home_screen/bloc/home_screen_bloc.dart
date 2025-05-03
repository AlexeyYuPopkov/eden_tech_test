import 'dart:async';
import 'package:di_storage/di_storage.dart';
import 'package:eden_tech_test/domain/auth/auth_repository.dart';
import 'package:eden_tech_test/domain/models/get_movies_usecase_sort_policy.dart';
import 'package:eden_tech_test/app/tools/optional_box.dart';
import 'package:eden_tech_test/domain/usecases/favorites_usecase.dart';
import 'package:eden_tech_test/domain/usecases/get_movies_usecase.dart';
import 'package:eden_tech_test/presentation/home_screen/home_screen_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen_data.dart';
import 'home_screen_event.dart';
import 'home_screen_state.dart';

final class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenData get data => state.data;

  final GetMoviesUsecase getMoviesUsecase =
      DiStorage.shared.resolve<GetMoviesUsecase>();

  final FavoritesUsecase favoritesUsecase = DiStorage.shared.resolve();

  final authRepository = DiStorage.shared.resolve<AuthRepository>();

  StreamSubscription? _authSubscription;
  StreamSubscription? _favoritesSubscription;

  HomeScreenBloc()
      : super(
          HomeScreenState.common(
            data: HomeScreenData.initial(),
          ),
        ) {
    _setupHandlers();
    add(const HomeScreenEvent.initial());
    _setupSubscriptions();
  }

  void _setupHandlers() {
    on<InitialEvent>(_onInitialEvent);
    on<ReceiveFavoritesEvent>(_onReceiveFavoritesEvent);
    on<ChangeTabEvent>(_onChangeTabEvent);
    on<ToggleSortPolicyEvent>(_onToggleSortPolicyEvent);
    on<OnAuthEvent>(_onAuthEvent);
    on<DidChangeAuthStateEvent>(_onDidChangeAuthStateEvent);
    on<LogOutEvent>(_onLogOutEvent);
    on<OnLikeEvent>(_onLikeEvent);
    on<OnRefreshEvent>(_onRefreshEvent);
  }

  void _setupSubscriptions() {
    _authSubscription = authRepository.authorizedUserStream.listen((user) {
      add(HomeScreenEvent.didChangeAuthState(user: user));
    });
  }

  void _setupFavoritesSubscription() {
    if (data.isAuthorized) {
      final favoritesStream = favoritesUsecase.getFavoritesStream(
        data.favoritesSortPolicy,
      );
      _favoritesSubscription?.cancel();
      _favoritesSubscription = favoritesStream.listen((movies) {
        add(HomeScreenEvent.receiveFavorites(movies));
      });
    } else {
      _favoritesSubscription?.cancel();
      _favoritesSubscription = null;
      add(const HomeScreenEvent.receiveFavorites([]));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    _favoritesSubscription?.cancel();
    return super.close();
  }

  void _onInitialEvent(
    InitialEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    try {
      emit(HomeScreenState.shimmers(data: data));

      // to show shimmers
      await Future.delayed(const Duration(milliseconds: 200));

      final result = await getMoviesUsecase.execute(
        data.moviesSortPolicy,
      );

      emit(
        HomeScreenState.common(
          data: data.copyWith(movies: result),
        ),
      );
    } catch (e) {
      emit(
        HomeScreenState.error(error: e, data: data),
      );
    }
  }

  void _onReceiveFavoritesEvent(
    ReceiveFavoritesEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    final newData = data.copyWith(
      favorites: event.favorites,
    );
    if (state.hasShimmers && data.tab is MoviesTab) {
      emit(HomeScreenState.shimmers(data: newData));
    } else {
      emit(HomeScreenState.common(data: newData));
    }
  }

  void _onChangeTabEvent(
    ChangeTabEvent event,
    Emitter<HomeScreenState> emit,
  ) {
    emit(
      HomeScreenState.common(
        data: data.copyWith(tab: event.tab),
      ),
    );
  }

  void _onToggleSortPolicyEvent(
    ToggleSortPolicyEvent event,
    Emitter<HomeScreenState> emit,
  ) {
    switch (data.tab) {
      case MoviesTab():
        emit(
          HomeScreenState.common(
            data: data.copyWith(
              moviesSortPolicy: data.moviesSortPolicy.toggle(),
            ),
          ),
        );

        add(const HomeScreenEvent.initial());
        break;
      case FavoritesTab():
        emit(
          HomeScreenState.common(
            data: data.copyWith(
              favoritesSortPolicy: data.favoritesSortPolicy.toggle(),
            ),
          ),
        );

        _setupFavoritesSubscription();
        break;
    }
  }

  void _onAuthEvent(
    OnAuthEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    try {
      await authRepository.signInWithGoogle();
    } catch (e) {
      emit(HomeScreenState.error(error: e, data: data));
    }
  }

  void _onDidChangeAuthStateEvent(
    DidChangeAuthStateEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    final newData = data.copyWith(
      authorizedUser: OptionalBox(event.user),
      favorites: event.user == null ? [] : null,
    );
    if (state.hasShimmers) {
      emit(HomeScreenState.shimmers(data: newData));
    } else {
      emit(HomeScreenState.common(data: newData));
    }

    _setupFavoritesSubscription();
  }

  void _onLogOutEvent(
    LogOutEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    try {
      await authRepository.signOut();
    } catch (e) {
      emit(HomeScreenState.error(error: e, data: data));
    }
  }

  void _onLikeEvent(
    OnLikeEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    try {
      if (!data.isAuthorized) {
        final user = await authRepository.signInWithGoogle();
        if (user != null) {
          add(HomeScreenEvent.onLike(movie: event.movie));
        }
      } else {
        await favoritesUsecase.toggleFavorite(
          movie: event.movie,
        );
      }
    } catch (e) {
      emit(HomeScreenState.error(error: e, data: data));
    }
  }

  void _onRefreshEvent(
    OnRefreshEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(HomeScreenState.shimmers(data: data));
    await Future.delayed(const Duration(milliseconds: 300));
    switch (data.tab) {
      case MoviesTab():
        add(const HomeScreenEvent.initial());
        break;
      case FavoritesTab():
        _setupFavoritesSubscription();
        break;
    }
  }
}

extension on GetMoviesUsecaseSortPolicy {
  GetMoviesUsecaseSortPolicy toggle() {
    switch (this) {
      case GetMoviesUsecaseSortByYear():
        return const GetMoviesUsecaseSortByRating();
      case GetMoviesUsecaseSortByRating():
        return const GetMoviesUsecaseSortByYear();
    }
  }
}
