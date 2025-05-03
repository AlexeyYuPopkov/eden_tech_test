import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:flutter/material.dart';

final class CommonPopupMenuItem<T> {
  final Widget title;
  final T payload;

  const CommonPopupMenuItem({
    required this.title,
    required this.payload,
  });
}

final class CommonPopupMenuButton extends StatelessWidget {
  final Widget icon;
  final Offset offset;
  final List<CommonPopupMenuItem> items;
  final Size size;
  final Future<void> Function(CommonPopupMenuItem) onSelected;
  final PopupMenuEntry<CommonPopupMenuItem> Function(
    BuildContext,
    CommonPopupMenuItem,
  ) itemBuilder;

  const CommonPopupMenuButton({
    super.key,
    required this.icon,
    required this.items,
    required this.offset,
    required this.onSelected,
    this.size = const Size(Sizes.icon, Sizes.iconTiny),
    this.itemBuilder = defaultItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        iconButtonTheme: const IconButtonThemeData(),
      ),
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: PopupMenuButton(
          icon: icon,
          padding: EdgeInsets.zero,
          offset: offset,
          onSelected: onSelected,
          borderRadius: const BorderRadius.all(
            Radius.circular(Sizes.radiusVariant),
          ),
          itemBuilder: (context) {
            return [
              for (final item in items) itemBuilder(context, item),
            ];
          },
        ),
      ),
    );
  }

  static PopupMenuEntry<CommonPopupMenuItem> defaultItemBuilder(
    BuildContext context,
    CommonPopupMenuItem item,
  ) {
    const itemHeight = 58.0;
    const itemMaxWidth = 200.0;

    return PopupMenuItem(
      value: item,
      height: itemHeight,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: itemMaxWidth,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.indentVariant2x,
          ),
          child: item.title,
        ),
      ),
    );
  }
}
