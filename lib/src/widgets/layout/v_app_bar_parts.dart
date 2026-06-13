part of 'v_app_bar.dart';

class _VSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _VSliverAppBarDelegate({
    required this.minExtent,
    required this.maxExtent,
    required this.variant,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.tokens,
    this.leading,
    this.title,
    this.subtitle,
    this.actions = const [],
    this.bottom,
    this.flexibleSpace,
    this.flexibleBuilder,
    this.centerTitle = false,
    this.semanticLabel,
  });

  @override
  final double minExtent;

  @override
  final double maxExtent;
  final VAppBarVariant variant;
  final Color backgroundColor;
  final Color foregroundColor;
  final VAppBarTokens tokens;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final List<Widget> actions;
  final Widget? bottom;
  final Widget? flexibleSpace;
  final VSliverAppBarFlexibleBuilder? flexibleBuilder;
  final bool centerTitle;
  final String? semanticLabel;

  @override
  bool shouldRebuild(covariant _VSliverAppBarDelegate old) => true;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final range = maxExtent - minExtent;
    final collapseT = range <= 0 ? 1.0 : (shrinkOffset / range).clamp(0.0, 1.0);
    final effectiveOpacity = (1.0 - collapseT).clamp(0.0, 1.0);
    final shadow = variant == VAppBarVariant.elevated
        ? tokens.elevatedShadow
        : variant == VAppBarVariant.flat
            ? tokens.shadow
            : null;

    return Semantics(
      container: true,
      label: semanticLabel,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: variant != VAppBarVariant.transparent
              ? Border(bottom: BorderSide(color: tokens.border))
              : null,
          boxShadow: shadow != null ? [shadow] : null,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (flexibleBuilder != null || flexibleSpace != null)
              Positioned.fill(
                child: Opacity(
                  opacity: effectiveOpacity,
                  child: flexibleBuilder?.call(context, collapseT) ??
                      flexibleSpace!,
                ),
              ),
            Positioned(
              left: tokens.horizontalPadding,
              right: tokens.horizontalPadding,
              top: 0,
              child: SizedBox(
                height: minExtent,
                child: _VAppBarContent(
                  leading: leading,
                  title: title,
                  subtitle: subtitle,
                  actions: actions,
                  bottom: bottom,
                  centerTitle: centerTitle,
                  foregroundColor: foregroundColor,
                  tokens: tokens,
                  showBottom: collapseT < 0.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VAppBarContent extends StatelessWidget {
  const _VAppBarContent({
    this.leading,
    this.title,
    this.subtitle,
    this.actions = const [],
    this.bottom,
    this.centerTitle = false,
    this.showBottom = true,
    required this.foregroundColor,
    required this.tokens,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final List<Widget> actions;
  final Widget? bottom;
  final bool centerTitle;
  final bool showBottom;
  final Color foregroundColor;
  final VAppBarTokens tokens;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    Widget toolbar() {
      return VIconTheme(
        data: VIconThemeData(color: foregroundColor),
        child: DefaultTextStyle(
          style: theme.typography.title.copyWith(color: foregroundColor),
          child: Row(
            children: [
              if (leading != null)
                SizedBox(
                  width: tokens.leadingWidth,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: leading!,
                  ),
                ),
              if (centerTitle && actions.isNotEmpty) const Spacer(),
              if (title != null || subtitle != null)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: centerTitle
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      if (title != null) title!,
                      if (subtitle != null) subtitle!,
                    ],
                  ),
                ),
              if (actions.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions,
                ),
            ],
          ),
        ),
      );
    }

    if (bottom == null || !showBottom) {
      return SizedBox.expand(child: toolbar());
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: toolbar()),
        SizedBox(height: tokens.bottomSpacing),
        Flexible(
          fit: FlexFit.loose,
          child: bottom!,
        ),
      ],
    );
  }
}
