import 'package:equatable/equatable.dart';

import 'login_screen_data.dart';

sealed class LoginScreenState extends Equatable {
  final LoginScreenData data;

  const LoginScreenState({required this.data});

  @override
  List<Object?> get props => [data];

  const factory LoginScreenState.common({
    required LoginScreenData data,
  }) = LoginScreenCommonState;

  const factory LoginScreenState.loading({
    required LoginScreenData data,
  }) = LoginScreenLoadingState;

  const factory LoginScreenState.error({
    required LoginScreenData data,
    required Object error,
  }) = LoginScreenErrorState;

  const factory LoginScreenState.didLoading({
    required LoginScreenData data,
  }) = DidLoadingState;
}

final class LoginScreenCommonState extends LoginScreenState {
  const LoginScreenCommonState({required super.data});
}

final class LoginScreenLoadingState extends LoginScreenState {
  const LoginScreenLoadingState({required super.data});
}

final class LoginScreenErrorState extends LoginScreenState {
  final Object error;
  const LoginScreenErrorState({
    required super.data,
    required this.error,
  });
}

final class DidLoadingState extends LoginScreenState {
  const DidLoadingState({required super.data});
}
