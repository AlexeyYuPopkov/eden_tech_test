import 'package:equatable/equatable.dart';

sealed class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  const factory HomeScreenEvent.initial() = InitialEvent;

  const factory HomeScreenEvent.toggleSortPolicy() = ToggleSortPolicyEvent;

  const factory HomeScreenEvent.onAuth() = OnAuthEvent;

  @override
  List<Object?> get props => const [];
}

final class InitialEvent extends HomeScreenEvent {
  const InitialEvent();
}

final class ToggleSortPolicyEvent extends HomeScreenEvent {
  const ToggleSortPolicyEvent();
}

final class OnAuthEvent extends HomeScreenEvent {
  const OnAuthEvent();
}
