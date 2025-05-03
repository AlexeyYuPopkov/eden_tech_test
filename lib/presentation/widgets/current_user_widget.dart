import 'package:cached_network_image/cached_network_image.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:eden_tech_test/domain/models/authorized_user.dart';
import 'package:eden_tech_test/l10n/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'common_nav_bar_button.dart';
import 'common_popup_menu_button.dart';

final class CurrentUserWidget extends StatelessWidget {
  final AuthorizedUser? user;
  final VoidCallback? onProfile;
  final VoidCallback? onLogin;
  final VoidCallback? onLogout;

  const CurrentUserWidget({
    super.key,
    required this.user,
    this.onProfile,
    this.onLogin,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = this.user;
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(Sizes.iconBig / 2.0),
      ),
      child: SizedBox(
        height: Sizes.iconBig,
        width: Sizes.iconBig,
        child: CommonPopupMenuButton(
          offset: const Offset(
            Sizes.zero,
            CommonNavBarButton.buttonSize + Sizes.padding,
          ),
          items: [
            if (user != null)
              CommonPopupMenuItem<VoidCallback>(
                title: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.halfIndent,
                  ),
                  child: Text(
                    context.l10n.homeScreenUserProfile,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                payload: () => onProfile?.call(),
              ),
            CommonPopupMenuItem<VoidCallback>(
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.halfIndent,
                ),
                child: Text(
                  _getLoginOutButtonTitle(context),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              payload: _onTap,
            ),
          ],
          size: const Size(
            CommonNavBarButton.buttonSize,
            CommonNavBarButton.buttonSize,
          ),
          onSelected: (p0) async {},
          itemBuilder: (p0, p1) {
            return _PopupItem(
              value: p1 as CommonPopupMenuItem<VoidCallback>,
            );
          },
          icon: AbsorbPointer(
            child: _CurrentUserWidgetContent(user: user),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    if (user == null) {
      onLogin?.call();
    } else {
      onLogout?.call();
    }
  }

  String _getLoginOutButtonTitle(BuildContext context) {
    if (user == null) {
      return context.l10n.commonLoginButtonTitle;
    } else {
      return context.l10n.commonLogoutButtonTitle;
    }
  }
}

final class _CurrentUserWidgetContent extends StatelessWidget {
  final AuthorizedUser? user;
  const _CurrentUserWidgetContent({this.user});

  @override
  Widget build(BuildContext context) {
    final user = this.user;
    return user == null || user.photoUrl.isEmpty
        ? const _NoNameWidget()
        : CachedNetworkImage(
            height: Sizes.iconBig,
            width: Sizes.iconBig,
            imageUrl: user.photoUrl,
            errorWidget: (context, url, error) => const _NoNameWidget(),
          );
  }
}

final class _NoNameWidget extends StatelessWidget {
  const _NoNameWidget();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Icon(
      Icons.account_circle,
      color: theme.colorScheme.primary,
    );
  }
}

final class _PopupItem extends StatefulWidget
    implements PopupMenuEntry<CommonPopupMenuItem<VoidCallback>> {
  final CommonPopupMenuItem<VoidCallback> value;
  const _PopupItem({required this.value});

  @override
  State<_PopupItem> createState() => _PopupItemState();

  @override
  double get height => 28.0;

  @override
  bool represents(CommonPopupMenuItem<VoidCallback>? value) =>
      value == this.value;
}

final class _PopupItemState extends State<_PopupItem> {
  @override
  Widget build(BuildContext context) {
    const minWidth = 146.0;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: minWidth,
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.indent2x),
        minSize: widget.height,
        sizeStyle: CupertinoButtonSize.small,
        alignment: Alignment.centerLeft,
        onPressed: () {
          Navigator.of(context).maybePop();
          widget.value.payload.call();
        },
        child: widget.value.title,
      ),
    );
  }
}
