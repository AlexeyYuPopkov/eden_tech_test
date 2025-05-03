import 'package:eden_tech_test/app/theme/common_buttons_theme.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CommonToolbarTabsWidgetTab extends Equatable {
  const CommonToolbarTabsWidgetTab();
  String getTitle(BuildContext context);

  @override
  List<Object?> get props => [runtimeType];
}

final class CommonToolbarTabsWidget extends StatelessWidget {
  static const height = Sizes.indent4x;

  final CommonToolbarTabsWidgetTab currentTab;
  final List<CommonToolbarTabsWidgetTab> tabs;
  final EdgeInsets padding;

  final void Function(
    BuildContext,
    int,
    CommonToolbarTabsWidgetTab,
  ) onChangeTab;

  const CommonToolbarTabsWidget({
    super.key,
    required this.currentTab,
    required this.tabs,
    required this.onChangeTab,
    this.padding = const EdgeInsets.symmetric(horizontal: Sizes.indent2x),
  });

  @override
  Widget build(BuildContext context) {
    final buttons = CommonButtonsTheme.of(context);
    return SingleChildScrollView(
      padding: padding,
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: Sizes.indent,
        children: [
          for (final (index, tab) in tabs.indexed)
            IconButton(
              isSelected: tab == currentTab,
              onPressed: () => onChangeTab(context, index, tab),
              icon: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.indent2x,
                ),
                child: Text(tab.getTitle(context)),
              ),
              style: buttons.tabButton,
            ),
        ],
      ),
    );
  }
}
