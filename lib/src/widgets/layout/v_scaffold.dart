import 'package:flutter/widgets.dart';

import '../../foundation/background.dart';
import '../../theme/v_motion_scope.dart';
import '../../theme/v_theme.dart';

/// A basic page shell with header, body, and footer slots.
///
/// This is a simple custom page shell — not Material's shell widget.
/// The body fills available space and the header/footer sit at the top/bottom.
class VScaffold extends StatelessWidget {
  const VScaffold({
    super.key,
    required this.body,
    this.header,
    this.footer,
    this.bottomSheet,
    this.safeArea = false,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.background,
  });

  final Widget? header;
  final Widget body;
  final Widget? footer;
  final Widget? bottomSheet;

  /// Whether scaffold edge slots should avoid system intrusions.
  ///
  /// When enabled, the header avoids the top safe area and the bottom-most
  /// footer or bottom sheet avoids the bottom safe area. The body is not
  /// wrapped so pages can choose their own full-bleed or scroll behavior.
  final bool safeArea;

  /// Whether [header] should avoid the top safe area when [safeArea] is true.
  final bool safeAreaTop;

  /// Whether the bottom-most [footer] or [bottomSheet] should avoid the bottom
  /// safe area when [safeArea] is true.
  final bool safeAreaBottom;

  /// Page-level one-off background override.
  ///
  /// Prefer theme tokens for reusable page styling. This is intended for
  /// local page treatments such as onboarding, auth, marketing, or empty
  /// states.
  final VBackground? background;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final bg = background ?? VBackground.color(theme.colors.background);
    final motion = theme.motion.normal;
    final bottomSheetDuration = VMotionResolver.duration(context, motion);
    final effectiveHeader = _wrapTopSafeArea(header);
    final effectiveFooter =
        bottomSheet == null ? _wrapBottomSafeArea(footer) : footer;
    final effectiveBottomSheet =
        _wrapBottomSafeArea(bottomSheet) ?? const SizedBox.shrink();
    final animatedBottomSheet = bottomSheetDuration == Duration.zero
        ? effectiveBottomSheet
        : AnimatedSize(
            duration: bottomSheetDuration,
            curve: VMotionResolver.curve(context, motion),
            alignment: Alignment.topCenter,
            child: effectiveBottomSheet,
          );

    return Semantics(
      explicitChildNodes: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg.gradient == null ? bg.color : null,
          gradient: bg.gradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (effectiveHeader != null) effectiveHeader,
            Expanded(child: body),
            if (effectiveFooter != null) effectiveFooter,
            animatedBottomSheet,
          ],
        ),
      ),
    );
  }

  Widget? _wrapTopSafeArea(Widget? child) {
    if (child == null) return null;
    if (!safeArea || !safeAreaTop) return child;
    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: child,
    );
  }

  Widget? _wrapBottomSafeArea(Widget? child) {
    if (child == null) return null;
    if (!safeArea || !safeAreaBottom) return child;
    return SafeArea(
      left: false,
      top: false,
      right: false,
      child: child,
    );
  }
}
