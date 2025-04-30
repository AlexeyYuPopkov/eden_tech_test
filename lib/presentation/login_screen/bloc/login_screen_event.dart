import 'package:equatable/equatable.dart';

sealed class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();

  const factory LoginScreenEvent.login({
    required String username,
    required String password,
  }) = OnLoginEvent;

  @override
  List<Object?> get props => const [];
}

final class OnLoginEvent extends LoginScreenEvent {
  final String username;
  final String password;

  const OnLoginEvent({
    required this.username,
    required this.password,
  });
}
