import 'package:flutter/widgets.dart';

import '../foundation/motion.dart';
import '../foundation/radii.dart';
import '../foundation/responsive.dart';
import '../foundation/semantic_tokens.dart';
import '../foundation/shadows.dart';
import '../foundation/sizes.dart';
import '../foundation/spacing.dart';
import '../foundation/typography.dart';
import 'component_tokens.dart';
import 'v_theme_data.dart';

export 'v_theme_data.dart' show VComponentTokensOverride, VThemeTokenOverride;

/// Transforms scoped tokens with access to the current theme.
typedef VScopedTokenOverride<T> = T Function(VThemeData theme, T tokens);

/// An [InheritedWidget] that provides [VThemeData] to descendants.
///
/// Access the current theme with:
/// ```dart
/// final theme = VTheme.of(context);
/// ```
class VTheme extends InheritedWidget {
  const VTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Creates a scoped theme by transforming the nearest parent [VThemeData].
  ///
  /// If [colors] is provided and [components] is omitted, component tokens are
  /// regenerated from the resolved colors so semantic color overrides naturally
  /// flow into widgets.
  static Widget override({
    Key? key,
    VThemeTokenOverride<VColors>? colors,
    VThemeTokenOverride<VTypography>? typography,
    VThemeTokenOverride<VSpacing>? spacing,
    VThemeTokenOverride<VRadii>? radii,
    VThemeTokenOverride<VBreakpointValues>? breakpoints,
    VThemeTokenOverride<VSizes>? sizes,
    VThemeTokenOverride<VShadows>? shadows,
    VThemeTokenOverride<VMotion>? motion,
    VComponentTokensOverride? components,
    required Widget child,
  }) {
    return _VThemeOverride(
      key: key,
      colors: colors,
      typography: typography,
      spacing: spacing,
      radii: radii,
      breakpoints: breakpoints,
      sizes: sizes,
      shadows: shadows,
      motion: motion,
      components: components,
      child: child,
    );
  }

  final VThemeData data;

  /// Returns the [VThemeData] for the nearest [VTheme] ancestor.
  ///
  /// Asserts in debug mode if no [VTheme] is found in the widget tree.
  static VThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<VTheme>();
    assert(widget != null, 'No VTheme found in context');
    return widget!.data;
  }

  // InheritedWidget.updateShouldNotify uses a covariant parameter; the
  // analyzer may warn when the class name is used directly. The behavior is correct.
  // ignore: annotate_overrides
  bool updateShouldNotify(VTheme oldWidget) => data != oldWidget.data;
}

class _VThemeOverride extends StatelessWidget {
  const _VThemeOverride({
    super.key,
    this.colors,
    this.typography,
    this.spacing,
    this.radii,
    this.breakpoints,
    this.sizes,
    this.shadows,
    this.motion,
    this.components,
    required this.child,
  });

  final VThemeTokenOverride<VColors>? colors;
  final VThemeTokenOverride<VTypography>? typography;
  final VThemeTokenOverride<VSpacing>? spacing;
  final VThemeTokenOverride<VRadii>? radii;
  final VThemeTokenOverride<VBreakpointValues>? breakpoints;
  final VThemeTokenOverride<VSizes>? sizes;
  final VThemeTokenOverride<VShadows>? shadows;
  final VThemeTokenOverride<VMotion>? motion;
  final VComponentTokensOverride? components;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final parent = VTheme.of(context);
    return VTheme(
      data: parent.applyOverrides(
        colors: colors,
        typography: typography,
        spacing: spacing,
        radii: radii,
        breakpoints: breakpoints,
        sizes: sizes,
        shadows: shadows,
        motion: motion,
        components: components,
      ),
      child: child,
    );
  }
}

// ---------------------------------------------------------------------------
// Scoped theme resolution
// ---------------------------------------------------------------------------

/// Resolves the theme for an overlay, optionally merging scoped component tokens.
///
/// [scopedLookup] is typically a static `.of` method like [VDialogTheme.of].
/// [merge] injects the scoped tokens into the component token set.
///
/// If no scoped tokens are found, returns the base theme unchanged
/// (no redundant copyWith).
VThemeData resolveOverlayTheme<T>(
  BuildContext context,
  T? Function(BuildContext) scopedLookup,
  VComponentTokens Function(VComponentTokens components, T tokens) merge,
) {
  final base = VTheme.of(context);
  final scoped = scopedLookup(context);
  if (scoped == null) return base;
  return base.copyWith(components: merge(base.components, scoped));
}
