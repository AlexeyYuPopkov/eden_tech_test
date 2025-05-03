import 'package:cached_network_image/cached_network_image.dart';
import 'package:eden_tech_test/app/theme/sizes.dart';
import 'package:eden_tech_test/presentation/widgets/common_nav_bar_button.dart';
import 'package:flutter/material.dart';
import 'package:eden_tech_test/domain/models/authorized_user.dart';
import 'package:eden_tech_test/presentation/common/dialogs/show_dialog_helper.dart';

const _dummyText =
    'Lorem Ipsum is simply dummy text of the printing and typesetting '
    'industry. Lorem Ipsum has been the industry\'s standard dummy text ever '
    'since the 1500s, when an unknown printer took a galley of type and '
    'scrambled it to make a type specimen book. It has survived not only five '
    'centuries, but also the leap into electronic typesetting, remaining '
    'essentially unchanged. It was popularised in the 1960s with the release of '
    'Letraset sheets containing Lorem Ipsum passages, and more recently with '
    'desktop publishing software like Aldus PageMaker including versions of '
    'Lorem Ipsum.\n'
    'Lorem Ipsum is simply dummy text of the printing and typesetting '
    'industry. Lorem Ipsum has been the industry\'s standard dummy text ever '
    'since the 1500s, when an unknown printer took a galley of type and '
    'scrambled it to make a type specimen book. It has survived not only five '
    'centuries, but also the leap into electronic typesetting, remaining '
    'essentially unchanged. It was popularised in the 1960s with the release of '
    'Letraset sheets containing Lorem Ipsum passages, and more recently with '
    'desktop publishing software like Aldus PageMaker including versions of '
    'Lorem Ipsum.\n'
    'Lorem Ipsum is simply dummy text of the printing and typesetting '
    'industry. Lorem Ipsum has been the industry\'s standard dummy text ever '
    'since the 1500s, when an unknown printer took a galley of type and '
    'scrambled it to make a type specimen book. It has survived not only five '
    'centuries, but also the leap into electronic typesetting, remaining '
    'essentially unchanged. It was popularised in the 1960s with the release of '
    'Letraset sheets containing Lorem Ipsum passages, and more recently with '
    'desktop publishing software like Aldus PageMaker including versions of '
    'Lorem Ipsum.\n';

final class UserProfileScreen extends StatefulWidget with ShowDialogHelper {
  static const maxFlexibleSpaceHeight = 250.0;
  final AuthorizedUser user;

  const UserProfileScreen({super.key, required this.user});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

final class _UserProfileScreenState extends State<UserProfileScreen> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: Sizes.padding,
            collapsedHeight: CommonNavBarButton.buttonSize,
            expandedHeight: UserProfileScreen.maxFlexibleSpaceHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.secondaryContainer,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: kToolbarHeight,
                      bottom: Sizes.indent2x,
                    ),
                    child: Center(
                      child: _CurrentUserWidgetContent(
                        user: widget.user,
                      ),
                    ),
                  ),
                  const Positioned(
                    top: kToolbarHeight,
                    left: Sizes.indent,
                    child: CommonNavBarBack(),
                  )
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(Sizes.indent4x),
              child: _AppBarBottomContent(
                user: widget.user,
                scrollController: scrollController,
              ),
            ),
          ),
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(Sizes.indent2x),
              child: Text(
                _dummyText,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SafeArea(
              child: SizedBox(height: Sizes.indent),
            ),
          ),
        ],
      ),
    );
  }
}

final class _AppBarBottomContent extends StatefulWidget {
  final AuthorizedUser user;

  final ScrollController scrollController;

  const _AppBarBottomContent({
    required this.user,
    required this.scrollController,
  });

  @override
  State<_AppBarBottomContent> createState() => _AppBarBottomContentState();
}

final class _AppBarBottomContentState extends State<_AppBarBottomContent> {
  static const animationDuration = Duration(milliseconds: 200);
  static const _endTreshold = UserProfileScreen.maxFlexibleSpaceHeight -
      kToolbarHeight -
      Sizes.indent4x;
  late final scrollController = widget.scrollController;

  double _clumpedExtent = UserProfileScreen.maxFlexibleSpaceHeight;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final currentExtent =
        UserProfileScreen.maxFlexibleSpaceHeight - scrollController.offset;
    final clampedExtent = currentExtent.clamp(
      kToolbarHeight,
      UserProfileScreen.maxFlexibleSpaceHeight,
    );

    setState(() {
      if (clampedExtent != _clumpedExtent) {
        _clumpedExtent = clampedExtent;
      }
    });
  }

  double get _titleOpacity {
    if (_clumpedExtent > kToolbarHeight && _clumpedExtent < _endTreshold) {
      return 0.0;
    } else {
      return 1.0;
    }
  }

  double get _backButtonOpacity {
    if (_clumpedExtent >= 0.0 && _clumpedExtent <= kToolbarHeight) {
      return 1.0;
    } else {
      return 0.0;
    }
  }

  Color _getForegroundColor(ThemeData theme) {
    if (_clumpedExtent >= 0.0 && _clumpedExtent <= kToolbarHeight) {
      return theme.colorScheme.onSurface;
    } else if (_clumpedExtent > kToolbarHeight &&
        _clumpedExtent <= _endTreshold) {
      return Colors.grey;
    } else {
      return theme.colorScheme.surface;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: Sizes.indent,
        right: Sizes.indent,
        bottom: Sizes.indent2x,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedOpacity(
            opacity: _backButtonOpacity,
            duration: animationDuration,
            child: const CommonNavBarBack(),
          ),
          AnimatedOpacity(
            opacity: _titleOpacity,
            duration: animationDuration,
            child: Text(
              widget.user.displayName,
              style: theme.textTheme.titleLarge?.copyWith(
                color: _getForegroundColor(theme),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: CommonNavBarButton.buttonSize,
          ),
        ],
      ),
    );
  }
}

final class _CurrentUserWidgetContent extends StatelessWidget {
  final AuthorizedUser? user;
  const _CurrentUserWidgetContent({this.user});

  @override
  Widget build(BuildContext context) {
    const marRadius = 150.0;
    final user = this.user;
    return ClipRRect(
      borderRadius: BorderRadius.circular(marRadius),
      clipBehavior: Clip.hardEdge,
      child: user == null || user.photoUrl.isEmpty
          ? const _NoNameWidget()
          : CachedNetworkImage(
              imageUrl: user.photoUrl,
              errorWidget: (context, url, error) => const _NoNameWidget(),
            ),
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
