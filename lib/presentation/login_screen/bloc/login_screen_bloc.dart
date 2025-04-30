import 'package:di_storage/di_storage.dart';
import 'package:eden_tech_test/domain/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen_data.dart';
import 'login_screen_event.dart';
import 'login_screen_state.dart';

final class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  late final AuthRepository authRepository = DiStorage.shared.resolve();
  LoginScreenData get data => state.data;

  LoginScreenBloc()
      : super(
          LoginScreenState.common(
            data: LoginScreenData.initial(),
          ),
        ) {
    _setupHandlers();

    // add(const LoginScreenEvent.initial());
  }

  void _setupHandlers() {
    on<OnLoginEvent>(_onOnLogin);
  }

  void _onOnLogin(
    OnLoginEvent event,
    Emitter<LoginScreenState> emit,
  ) async {
    try {
      emit(LoginScreenState.loading(data: data));

      final result = await authRepository.login(
        event.username,
        event.password,
      );

      if (result) {
        emit(LoginScreenState.didLoading(data: data));
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      emit(LoginScreenState.error(error: e, data: data));
    }
  }
}
