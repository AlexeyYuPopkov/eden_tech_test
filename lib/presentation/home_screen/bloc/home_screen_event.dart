import 'package:equatable/equatable.dart';

sealed class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  const factory HomeScreenEvent.initial() = InitialEvent;

  const factory HomeScreenEvent.toggleSortPolicy() = ToggleSortPolicyEvent;

  @override
  List<Object?> get props => const [];
}

final class InitialEvent extends HomeScreenEvent {
  const InitialEvent();
}

final class ToggleSortPolicyEvent extends HomeScreenEvent {
  const ToggleSortPolicyEvent();
}
