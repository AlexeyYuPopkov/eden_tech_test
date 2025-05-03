import 'package:eden_tech_test/domain/models/authorized_user.dart';
import 'package:eden_tech_test/domain/models/movie.dart';
import 'package:eden_tech_test/presentation/home_screen/home_screen_tab.dart';
import 'package:equatable/equatable.dart';

sealed class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  const factory HomeScreenEvent.initial() = InitialEvent;

  const factory HomeScreenEvent.receiveFavorites(List<Movie> favorites) =
      ReceiveFavoritesEvent;

  const factory HomeScreenEvent.changeTab(HomeScreenTab tab) = ChangeTabEvent;

  const factory HomeScreenEvent.toggleSortPolicy() = ToggleSortPolicyEvent;

  const factory HomeScreenEvent.onAuth() = OnAuthEvent;

  const factory HomeScreenEvent.didChangeAuthState({
    required AuthorizedUser? user,
  }) = DidChangeAuthStateEvent;

  const factory HomeScreenEvent.logout() = LogOutEvent;

  const factory HomeScreenEvent.onLike({
    required Movie movie,
  }) = OnLikeEvent;

  const factory HomeScreenEvent.onRefresh() = OnRefreshEvent;

  @override
  List<Object?> get props => const [];
}

final class InitialEvent extends HomeScreenEvent {
  const InitialEvent();
}

final class ReceiveFavoritesEvent extends HomeScreenEvent {
  final List<Movie> favorites;
  const ReceiveFavoritesEvent(this.favorites);
}

final class ChangeTabEvent extends HomeScreenEvent {
  final HomeScreenTab tab;
  const ChangeTabEvent(this.tab);
}

final class ToggleSortPolicyEvent extends HomeScreenEvent {
  const ToggleSortPolicyEvent();
}

final class OnAuthEvent extends HomeScreenEvent {
  const OnAuthEvent();
}

final class DidChangeAuthStateEvent extends HomeScreenEvent {
  final AuthorizedUser? user;
  const DidChangeAuthStateEvent({this.user});
}

final class LogOutEvent extends HomeScreenEvent {
  const LogOutEvent();
}

final class OnLikeEvent extends HomeScreenEvent {
  final Movie movie;
  const OnLikeEvent({
    required this.movie,
  });
}

final class OnRefreshEvent extends HomeScreenEvent {
  const OnRefreshEvent();
}
