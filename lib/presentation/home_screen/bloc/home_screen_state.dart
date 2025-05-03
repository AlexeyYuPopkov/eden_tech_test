import 'package:equatable/equatable.dart';

import 'home_screen_data.dart';

sealed class HomeScreenState extends Equatable {
  final HomeScreenData data;

  const HomeScreenState({required this.data});

  @override
  List<Object?> get props => [data];

  const factory HomeScreenState.common({
    required HomeScreenData data,
  }) = CommonState;

  const factory HomeScreenState.shimmers({
    required HomeScreenData data,
  }) = ShimmersState;

  const factory HomeScreenState.loading({
    required HomeScreenData data,
  }) = LoadingState;

  const factory HomeScreenState.error({
    required HomeScreenData data,
    required Object error,
  }) = ErrorState;

  bool get isLoading => this is LoadingState || hasShimmers;
  bool get hasShimmers => this is ShimmersState;
}

final class CommonState extends HomeScreenState {
  const CommonState({required super.data});
}

final class ShimmersState extends HomeScreenState {
  const ShimmersState({required super.data});
}

final class LoadingState extends HomeScreenState {
  const LoadingState({required super.data});
}

final class ErrorState extends HomeScreenState {
  final Object error;
  const ErrorState({
    required super.data,
    required this.error,
  });
}
