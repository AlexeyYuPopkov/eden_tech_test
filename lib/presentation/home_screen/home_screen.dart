import 'package:eden_tech_test/app/router/app_router_path.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:eden_tech_test/domain/models/authorized_user.dart';
import 'package:eden_tech_test/domain/models/get_movies_usecase_sort_policy.dart';
import 'package:eden_tech_test/l10n/localization.dart';
import 'package:eden_tech_test/presentation/common/dialogs/show_dialog_helper.dart';
import 'package:eden_tech_test/presentation/common/localization/error_localization_mapper.dart';
import 'package:eden_tech_test/presentation/home_screen/bloc/home_screen_state.dart';
import 'package:eden_tech_test/presentation/home_screen/home_screen_tab.dart';
import 'package:eden_tech_test/presentation/widgets/common_toolbar_tabs_widget.dart';
import 'package:eden_tech_test/presentation/widgets/current_user_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/home_screen_bloc.dart';
import 'bloc/home_screen_event.dart';

final class HomeScreen extends StatelessWidget with ShowDialogHelper {
  const HomeScreen({super.key});

  void _listener(BuildContext context, HomeScreenState state) {
    switch (state) {
      case LoadingState():
      case ShimmersState():
      case CommonState():
        break;
      case ErrorState():
        final error = state.error;

        final message = ErrorLocalizationMapper.instance.getMessage(
          context,
          error,
        );

        if (message.isNotEmpty) {
          showSnackBar(context: context, text: message);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: BlocProvider(
          create: (context) => HomeScreenBloc(),
          child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
            listener: _listener,
            builder: (context, state) {
              final user = state.data.authorizedUser.value;
              return AbsorbPointer(
                absorbing: state.isLoading,
                child: RefreshIndicator(
                  edgeOffset: Sizes.indent2x,
                  onRefresh: () => _onRefresh(context),
                  child: DefaultTabController(
                    length: HomeScreenTab.tabs.length,
                    child: NestedScrollView(
                      headerSliverBuilder: (context, bool innerBoxIsScrolled) =>
                          [
                        SliverOverlapAbsorber(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context,
                          ),
                          sliver: SliverAppBar(
                            title: Text(
                              context.l10n.homeScreenTitle,
                            ),
                            centerTitle: false,
                            floating: true,
                            actions: [
                              const _SortButton(),
                              CurrentUserWidget(
                                user: user,
                                onProfile: user == null
                                    ? null
                                    : () => _onUserProfile(context, user),
                                onLogin: () => _onLogIn(context),
                                onLogout: () => _onLogOut(context),
                              ),
                              const SizedBox(width: Sizes.indent2x),
                            ],
                            bottom: const _AppBarBottom(),
                          ),
                        ),
                      ],
                      body: BlocListener<HomeScreenBloc, HomeScreenState>(
                        listenWhen: (a, b) => a.data.tab != b.data.tab,
                        listener: (context, state) =>
                            DefaultTabController.of(context).animateTo(
                          HomeScreenTab.tabs.indexOf(state.data.tab),
                        ),
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            for (final tab in HomeScreenTab.tabs)
                              RefreshIndicator(
                                edgeOffset: Sizes.indent2x,
                                onRefresh: () => _onRefresh(context),
                                child: tab.build(context),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<HomeScreenBloc>().add(const HomeScreenEvent.onRefresh());
  }

  void _onLogOut(BuildContext context) {
    context.read<HomeScreenBloc>().add(const HomeScreenEvent.logout());
  }

  void _onLogIn(BuildContext context) {
    context.read<HomeScreenBloc>().add(const HomeScreenEvent.onAuth());
  }

  void _onUserProfile(BuildContext context, AuthorizedUser user) {
    GoRouter.of(context).push(
      AppRouterPath.userProfile,
      extra: user.toJson(),
    );
  }
}

final class _AppBarBottom extends StatelessWidget
    implements PreferredSizeWidget {
  static const tabbarHeight = Sizes.indent4x + Sizes.indent;
  const _AppBarBottom();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: BlocSelector<HomeScreenBloc, HomeScreenState, HomeScreenTab>(
        selector: (state) => state.data.tab,
        builder: (context, tab) {
          return CommonToolbarTabsWidget(
            currentTab: tab,
            tabs: HomeScreenTab.tabs,
            onChangeTab: _onChangeTab,
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(tabbarHeight);

  void _onChangeTab(
    BuildContext context,
    int index,
    CommonToolbarTabsWidgetTab tab,
  ) {
    context.read<HomeScreenBloc>().add(
          HomeScreenEvent.changeTab(tab as HomeScreenTab),
        );
  }
}

final class _SortButton extends StatelessWidget {
  const _SortButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeScreenBloc, HomeScreenState,
        GetMoviesUsecaseSortPolicy>(
      selector: (state) => state.data.sortPolicy,
      builder: (context, sortPolicy) {
        final theme = Theme.of(context);
        return CupertinoButton(
          child: Text(
            sortPolicy.getPolicyName(context),
            style: theme.appBarTheme.toolbarTextStyle?.copyWith(
              fontSize: TextSizes.smallVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () => _toggleSortPolicy(context),
        );
      },
    );
  }

  void _toggleSortPolicy(BuildContext context) {
    context.read<HomeScreenBloc>().add(
          const HomeScreenEvent.toggleSortPolicy(),
        );
  }
}

extension on GetMoviesUsecaseSortPolicy {
  String getPolicyName(BuildContext context) {
    switch (this) {
      case GetMoviesUsecaseSortByYear():
        return context.l10n.homeScreenButtonSortByRating;
      case GetMoviesUsecaseSortByRating():
        return context.l10n.homeScreenButtonSortByYear;
    }
  }
}
