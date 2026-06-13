import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import '../foundation/motion.dart';
import '../foundation/radii.dart';
import '../foundation/responsive.dart';
import '../foundation/semantic_tokens.dart';
import '../foundation/shadows.dart';
import '../foundation/sizes.dart';
import '../foundation/spacing.dart';
import '../foundation/typography.dart';
import 'component_tokens.dart';

/// Transforms one theme token group into another.
typedef VThemeTokenOverride<T> = T Function(T value);

/// Transforms component tokens with access to the resolved theme.
typedef VComponentTokensOverride = VComponentTokens Function(
  VThemeData theme,
  VComponentTokens components,
);

/// The complete visual configuration for a VidraUI application.
///
/// Obtain the current theme via [VTheme.of].
/// Create light/dark themes via [VThemeData.light] / [VThemeData.dark].
/// Derive a modified theme with [copyWith].
/// Apply structured token overrides with [applyOverrides].
/// Animate between themes with [lerp].
@immutable
class VThemeData with Diagnosticable {
  factory VThemeData.light() {
    final colors = VColors.light();
    final spacing = VSpacing.defaults();
    final sizes = VSizes.defaults();
    final radii = VRadii.defaults();
    return VThemeData(
      colors: colors,
      typography: VTypography.defaults(),
      spacing: spacing,
      radii: radii,
      breakpoints: const VBreakpointValues(),
      sizes: sizes,
      shadows: VShadows.light(colors.scrim),
      motion: VMotion.defaults(),
      components: VComponentTokens.fromTheme(
        colors: colors,
        sizes: sizes,
        radii: radii,
        spacing: spacing,
      ),
    );
  }

  factory VThemeData.dark() {
    final colors = VColors.dark();
    final spacing = VSpacing.defaults();
    final sizes = VSizes.defaults();
    final radii = VRadii.defaults();
    return VThemeData(
      colors: colors,
      typography: VTypography.defaults(),
      spacing: spacing,
      radii: radii,
      breakpoints: const VBreakpointValues(),
      sizes: sizes,
      shadows: VShadows.dark(colors.scrim),
      motion: VMotion.defaults(),
      components: VComponentTokens.fromTheme(
        colors: colors,
        sizes: sizes,
        radii: radii,
        spacing: spacing,
      ),
    );
  }
  const VThemeData({
    required this.colors,
    required this.typography,
    required this.spacing,
    required this.radii,
    required this.breakpoints,
    required this.sizes,
    required this.shadows,
    required this.motion,
    required this.components,
  });

  final VColors colors;
  final VTypography typography;
  final VSpacing spacing;
  final VRadii radii;
  final VBreakpointValues breakpoints;
  final VSizes sizes;
  final VShadows shadows;
  final VMotion motion;
  final VComponentTokens components;

  /// Resolves the surface color for a given [elevation].
  Color surfaceColor(VElevation elevation) => colors.surfaceColor(elevation);

  /// Resolves the shadow for a given [elevation].
  BoxShadow? shadow(VElevation elevation) => shadows.resolve(elevation);

  VThemeData copyWith({
    VColors? colors,
    VTypography? typography,
    VSpacing? spacing,
    VRadii? radii,
    VSizes? sizes,
    VBreakpointValues? breakpoints,
    VShadows? shadows,
    VMotion? motion,
    VComponentTokens? components,
  }) {
    return VThemeData(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      radii: radii ?? this.radii,
      sizes: sizes ?? this.sizes,
      breakpoints: breakpoints ?? this.breakpoints,
      shadows: shadows ?? this.shadows,
      motion: motion ?? this.motion,
      components: components ?? this.components,
    );
  }

  /// Applies theme token overrides in the same order as [VTheme.override].
  ///
  /// If [colors] is provided, component tokens are regenerated from the
  /// resolved colors before [components] is applied.
  VThemeData applyOverrides({
    VThemeTokenOverride<VColors>? colors,
    VThemeTokenOverride<VTypography>? typography,
    VThemeTokenOverride<VSpacing>? spacing,
    VThemeTokenOverride<VRadii>? radii,
    VThemeTokenOverride<VBreakpointValues>? breakpoints,
    VThemeTokenOverride<VSizes>? sizes,
    VThemeTokenOverride<VShadows>? shadows,
    VThemeTokenOverride<VMotion>? motion,
    VComponentTokensOverride? components,
  }) {
    final resolvedColors = colors?.call(this.colors) ?? this.colors;
    final resolvedTypography =
        typography?.call(this.typography) ?? this.typography;
    final resolvedSpacing = spacing?.call(this.spacing) ?? this.spacing;
    final resolvedRadii = radii?.call(this.radii) ?? this.radii;
    final resolvedBreakpoints =
        breakpoints?.call(this.breakpoints) ?? this.breakpoints;
    final resolvedSizes = sizes?.call(this.sizes) ?? this.sizes;
    final resolvedShadows = shadows?.call(this.shadows) ?? this.shadows;
    final resolvedMotion = motion?.call(this.motion) ?? this.motion;

    final baseComponents = colors != null
        ? VComponentTokens.fromColors(resolvedColors)
        : this.components;
    final themeForComponents = copyWith(
      colors: resolvedColors,
      typography: resolvedTypography,
      spacing: resolvedSpacing,
      radii: resolvedRadii,
      breakpoints: resolvedBreakpoints,
      sizes: resolvedSizes,
      shadows: resolvedShadows,
      motion: resolvedMotion,
      components: baseComponents,
    );
    final resolvedComponents =
        components?.call(themeForComponents, baseComponents) ?? baseComponents;

    return themeForComponents.copyWith(components: resolvedComponents);
  }

  static VThemeData lerp(VThemeData a, VThemeData b, double t) {
    return VThemeData(
      colors: VColors.lerp(a.colors, b.colors, t),
      typography: VTypography.lerp(a.typography, b.typography, t),
      spacing: VSpacing.lerp(a.spacing, b.spacing, t),
      radii: VRadii.lerp(a.radii, b.radii, t),
      sizes: VSizes.lerp(a.sizes, b.sizes, t),
      breakpoints: VBreakpointValues.lerp(a.breakpoints, b.breakpoints, t),
      shadows: VShadows.lerp(a.shadows, b.shadows, t),
      motion: VMotion.lerp(a.motion, b.motion, t),
      components: VComponentTokens.lerp(a.components, b.components, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VThemeData &&
        other.colors == colors &&
        other.typography == typography &&
        other.spacing == spacing &&
        other.radii == radii &&
        other.sizes == sizes &&
        other.breakpoints == breakpoints &&
        other.shadows == shadows &&
        other.motion == motion &&
        other.components == components;
  }

  @override
  int get hashCode => Object.hash(colors, typography, spacing, radii, sizes,
      breakpoints, shadows, motion, components);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<VColors>('colors', colors))
      ..add(DiagnosticsProperty<VTypography>('typography', typography))
      ..add(DiagnosticsProperty<VSpacing>('spacing', spacing))
      ..add(DiagnosticsProperty<VRadii>('radii', radii))
      ..add(DiagnosticsProperty<VBreakpointValues>('breakpoints', breakpoints))
      ..add(DiagnosticsProperty<VSizes>('sizes', sizes))
      ..add(DiagnosticsProperty<VShadows>('shadows', shadows))
      ..add(DiagnosticsProperty<VMotion>('motion', motion))
      ..add(DiagnosticsProperty<VComponentTokens>('components', components));
  }
}
