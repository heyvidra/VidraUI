import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../theme/component_tokens.dart';
import '../../theme/v_component_themes.g.dart';
import '../../theme/v_icon_theme.dart';
import '../../theme/v_icon_theme_data.dart';
import '../../theme/v_theme.dart';

part 'v_app_bar_parts.dart';

/// Visual style for an app bar.
enum VAppBarVariant { flat, elevated, transparent }

/// Callback for flexible space content, receiving collapse progress.
typedef VSliverAppBarFlexibleBuilder = Widget Function(
  BuildContext context,
  double collapseT,
);

// ---------------------------------------------------------------------------
// VAppBar
// ---------------------------------------------------------------------------

/// A normal box app bar suitable for [VScaffold.header].
class VAppBar extends StatelessWidget {
  const VAppBar({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.actions = const <Widget>[],
    this.bottom,
    this.height,
    this.centerTitle,
    this.variant = VAppBarVariant.flat,
    this.safeArea = true,
    this.backgroundColor,
    this.foregroundColor,
    this.semanticLabel,
  });

  /// Convenience entrypoint that returns a [VSliverAppBar].
  static Widget sliver({
    Key? key,
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    List<Widget> actions = const <Widget>[],
    Widget? bottom,
    Widget? flexibleSpace,
    VSliverAppBarFlexibleBuilder? flexibleBuilder,
    double? collapsedHeight,
    double? expandedHeight,
    bool pinned = true,
    VAppBarVariant variant = VAppBarVariant.flat,
    bool? centerTitle,
    bool safeArea = true,
    Color? backgroundColor,
    Color? foregroundColor,
    String? semanticLabel,
  }) {
    return VSliverAppBar(
      key: key,
      leading: leading,
      title: title,
      subtitle: subtitle,
      actions: actions,
      bottom: bottom,
      flexibleSpace: flexibleSpace,
      flexibleBuilder: flexibleBuilder,
      collapsedHeight: collapsedHeight,
      expandedHeight: expandedHeight,
      pinned: pinned,
      variant: variant,
      centerTitle: centerTitle,
      safeArea: safeArea,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      semanticLabel: semanticLabel,
    );
  }

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final List<Widget> actions;
  final Widget? bottom;
  final double? height;
  final bool? centerTitle;
  final VAppBarVariant variant;
  final bool safeArea;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VAppBarTheme.of(context) ?? theme.components.appBar;
    final effectiveHeight = height ?? tokens.height;
    final bg = backgroundColor ??
        switch (variant) {
          VAppBarVariant.transparent => const Color(0x00000000),
          VAppBarVariant.flat || VAppBarVariant.elevated => tokens.background,
        };
    final fg = foregroundColor ?? tokens.foreground;
    final shadow = switch (variant) {
      VAppBarVariant.elevated => tokens.elevatedShadow,
      VAppBarVariant.flat => tokens.shadow,
      VAppBarVariant.transparent => null,
    };

    Widget content = Container(
      height: effectiveHeight,
      padding: EdgeInsets.symmetric(horizontal: tokens.horizontalPadding),
      decoration: BoxDecoration(
        color: bg,
        border: variant != VAppBarVariant.transparent
            ? Border(bottom: BorderSide(color: tokens.border))
            : null,
        boxShadow: shadow != null ? [shadow] : null,
      ),
      child: _VAppBarContent(
        leading: leading,
        title: title,
        subtitle: subtitle,
        actions: actions,
        bottom: bottom,
        centerTitle: centerTitle ?? false,
        foregroundColor: fg,
        tokens: tokens,
      ),
    );

    if (safeArea) {
      content = SafeArea(top: true, child: content);
    }

    return Semantics(
      container: true,
      label: semanticLabel,
      child: content,
    );
  }
}

// ---------------------------------------------------------------------------
// VSliverAppBar
// ---------------------------------------------------------------------------

/// A sliver app bar for use in [CustomScrollView.slivers].
///
/// Use [VAppBar.sliver] for a convenient factory, or construct directly.
class VSliverAppBar extends StatelessWidget {
  const VSliverAppBar({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.actions = const <Widget>[],
    this.bottom,
    this.flexibleSpace,
    this.flexibleBuilder,
    this.collapsedHeight,
    this.expandedHeight,
    this.pinned = true,
    this.variant = VAppBarVariant.flat,
    this.centerTitle,
    this.safeArea = true,
    this.backgroundColor,
    this.foregroundColor,
    this.semanticLabel,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final List<Widget> actions;
  final Widget? bottom;
  final Widget? flexibleSpace;
  final VSliverAppBarFlexibleBuilder? flexibleBuilder;
  final double? collapsedHeight;
  final double? expandedHeight;
  final bool pinned;
  final VAppBarVariant variant;
  final bool? centerTitle;
  final bool safeArea;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VAppBarTheme.of(context) ?? theme.components.appBar;
    final topSafe = safeArea ? MediaQuery.paddingOf(context).top : 0.0;
    final minH = (collapsedHeight ?? tokens.height) + topSafe;
    final maxH = (expandedHeight ?? tokens.expandedHeight) + topSafe;
    final effectiveMaxH = math.max(maxH, minH);
    final bg = backgroundColor ?? tokens.background;
    final fg = foregroundColor ?? tokens.foreground;

    return SliverPersistentHeader(
      pinned: pinned,
      delegate: _VSliverAppBarDelegate(
        minExtent: minH,
        maxExtent: effectiveMaxH,
        variant: variant,
        backgroundColor: bg,
        foregroundColor: fg,
        tokens: tokens,
        leading: leading,
        title: title,
        subtitle: subtitle,
        actions: actions,
        bottom: bottom,
        flexibleSpace: flexibleSpace,
        flexibleBuilder: flexibleBuilder,
        centerTitle: centerTitle ?? false,
        semanticLabel: semanticLabel,
      ),
    );
  }
}
