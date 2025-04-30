import 'package:di_storage/di_storage.dart';
import 'package:eden_tech_test/domain/usecases/get_movies_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen_data.dart';
import 'home_screen_event.dart';
import 'home_screen_state.dart';

final class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenData get data => state.data;

  late final GetMoviesUsecase getMoviesUsecase =
      DiStorage.shared.resolve<GetMoviesUsecase>();

  HomeScreenBloc()
      : super(
          HomeScreenState.common(
            data: HomeScreenData.initial(),
          ),
        ) {
    _setupHandlers();

    add(const HomeScreenEvent.initial());
  }

  void _setupHandlers() {
    on<InitialEvent>(_onInitialEvent);
  }

  void _onInitialEvent(
    InitialEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    try {
      emit(HomeScreenState.loading(data: data));

      final result = await getMoviesUsecase.execute();

      emit(
        HomeScreenState.common(
          data: data.copyWith(movies: result),
        ),
      );
    } catch (e) {
      emit(HomeScreenState.error(error: e, data: data));
    }
  }
}
