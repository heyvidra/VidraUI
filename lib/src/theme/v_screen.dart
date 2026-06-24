import 'package:flutter/widgets.dart';

import '../foundation/responsive.dart';
import 'v_theme.dart';

/// Responsive screen helpers for [BuildContext].
extension VScreenContext on BuildContext {
  /// Screen size from [MediaQuery].
  Size get vScreenSize => MediaQuery.sizeOf(this);

  /// Screen width in logical pixels.
  double get vScreenWidth => vScreenSize.width;

  /// Screen height in logical pixels.
  double get vScreenHeight => vScreenSize.height;

  /// Media padding (e.g. system bars).
  EdgeInsets get vPadding => MediaQuery.paddingOf(this);

  /// View insets (keyboard, system bars overlapping the app).
  EdgeInsets get vViewInsets => MediaQuery.viewInsetsOf(this);

  /// Bottom keyboard inset height.
  double get vKeyboardInset => vViewInsets.bottom;

  /// Whether the keyboard is currently visible.
  bool get vKeyboardVisible => vKeyboardInset > 0;

  /// Screen orientation.
  Orientation get vOrientation => MediaQuery.orientationOf(this);

  bool get vIsPortrait => vOrientation == Orientation.portrait;

  /// Resolved breakpoint from theme.
  VBreakpoint get vBreakpoint =>
      VTheme.of(this).breakpoints.resolve(vScreenWidth);

  bool get vIsMdUp => vBreakpoint.index >= VBreakpoint.md.index;

  bool get vIsCompact => vScreenWidth < VTheme.of(this).breakpoints.md;
  bool get vIsMedium =>
      vScreenWidth >= VTheme.of(this).breakpoints.md &&
      vScreenWidth < VTheme.of(this).breakpoints.lg;
  bool get vIsExpanded => vScreenWidth >= VTheme.of(this).breakpoints.lg;
}

/// Picks a value based on the current screen breakpoint.
///
/// Values cascade downward: if [xl] is not provided, [lg] is used,
/// and so on down to [xs].
class VResponsive {
  const VResponsive._();

  static T value<T>(
    BuildContext context, {
    required T xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
  }) {
    final bp = context.vBreakpoint;
    return switch (bp) {
      VBreakpoint.xxl => xxl ?? xl ?? lg ?? md ?? sm ?? xs,
      VBreakpoint.xl => xl ?? lg ?? md ?? sm ?? xs,
      VBreakpoint.lg => lg ?? md ?? sm ?? xs,
      VBreakpoint.md => md ?? sm ?? xs,
      VBreakpoint.sm => sm ?? xs,
      VBreakpoint.xs => xs,
    };
  }
}
