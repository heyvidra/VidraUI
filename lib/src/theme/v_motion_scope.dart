import 'package:flutter/widgets.dart';

import '../foundation/motion.dart';
import 'v_theme.dart';
import 'v_token_theme.dart';

/// Provides a local motion override for a subtree.
class VMotionScope extends StatelessWidget {
  const VMotionScope({
    super.key,
    required this.motion,
    required this.child,
  });

  /// Creates a scoped motion override by transforming the nearest motion tokens.
  static Widget override({
    Key? key,
    required VScopedTokenOverride<VMotion> motion,
    required Widget child,
  }) {
    return VTokenTheme.override<VMotion>(
      key: key,
      data: motion,
      fallback: (theme) => theme.motion,
      child: child,
    );
  }

  /// Motion tokens used by descendants.
  final VMotion motion;
  final Widget child;

  /// Returns the nearest scoped motion override, if one exists.
  static VMotion? maybeOf(BuildContext context) {
    return VTokenTheme.maybeOf<VMotion>(context);
  }

  /// Returns scoped motion, falling back to the active [VTheme].
  static VMotion of(BuildContext context) {
    return maybeOf(context) ?? VTheme.of(context).motion;
  }

  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return VTokenTheme<VMotion>(data: motion, child: child);
  }
}

/// Resolves motion specs for the current context.
class VMotionResolver {
  const VMotionResolver._();

  /// Forward duration for [spec], respecting reduced motion.
  static Duration duration(BuildContext context, VMotionSpec spec) {
    return VMotionScope.of(context).reducedMotion
        ? Duration.zero
        : spec.duration;
  }

  /// Reverse duration for [spec], respecting reduced motion.
  static Duration reverseDuration(BuildContext context, VMotionSpec spec) {
    return VMotionScope.of(context).reducedMotion
        ? Duration.zero
        : spec.effectiveReverseDuration;
  }

  /// Forward curve for [spec], respecting reduced motion.
  static Curve curve(BuildContext context, VMotionSpec spec) {
    return VMotionScope.of(context).reducedMotion ? Curves.linear : spec.curve;
  }

  /// Reverse curve for [spec], respecting reduced motion.
  static Curve reverseCurve(BuildContext context, VMotionSpec spec) {
    return VMotionScope.of(context).reducedMotion
        ? Curves.linear
        : spec.effectiveReverseCurve;
  }
}
