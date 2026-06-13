import 'package:flutter/widgets.dart';

import '../../foundation/background.dart';
import '../../foundation/shadows.dart';
import '../../theme/v_appearance.dart';
import '../../theme/v_appearance_box.dart';
import '../../theme/v_appearance_scope.dart';
import '../../theme/v_component_themes.g.dart';
import '../../theme/v_screen.dart';
import '../../theme/v_theme.dart';
import '../internal/_dotted_border.dart';

/// Variants for [VSurface].
enum VSurfaceVariant {
  base,
  elevated,
  card,
  panel,
}

/// Border visual style for [VSurface].
enum VBorderStyle { solid, dotted }


class _VSurfaceLocalBackgroundAppearance extends VAppearance {
  const _VSurfaceLocalBackgroundAppearance();
}

/// A themed surface container.
///
/// Reads background, border, and shadow from [VSurfaceTokens] via the
/// current [VTheme]. Use [variant] to select the visual style.
class VSurface extends StatelessWidget {
  const VSurface({
    super.key,
    required this.child,
    this.variant = VSurfaceVariant.base,
    this.elevation,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.background,
    this.borderStyle = VBorderStyle.solid,
    this.dotRadius = 1.5,
    this.dotStep = 5.0,
  });

  final Widget child;
  final VSurfaceVariant variant;
  final VElevation? elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final VBackground? background;

  /// Border visual style. Defaults to [VBorderStyle.solid].
  final VBorderStyle borderStyle;

  /// Dot radius when [borderStyle] is [VBorderStyle.dotted].
  final double dotRadius;

  /// Centre-to-centre dot spacing when [borderStyle] is [VBorderStyle.dotted].
  final double dotStep;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VSurfaceTheme.of(context) ?? theme.components.surface;
    final appearance = VAppearanceScope.of(context);

    final Color tokenBackground;
    final Color border;
    final BoxShadow? shadow;

    if (elevation != null) {
      tokenBackground = theme.surfaceColor(elevation!);
      border = tokens.baseBorder;
      shadow = theme.shadow(elevation!);
    } else {
      switch (variant) {
        case VSurfaceVariant.base:
          tokenBackground = tokens.baseBackground;
          border = tokens.baseBorder;
          shadow = null;
        case VSurfaceVariant.elevated:
          tokenBackground = tokens.elevatedBackground;
          border = tokens.elevatedBorder;
          shadow = theme.shadows.card;
        case VSurfaceVariant.card:
          tokenBackground = tokens.cardBackground;
          border = tokens.cardBorder;
          shadow = theme.shadows.card;
        case VSurfaceVariant.panel:
          tokenBackground = tokens.panelBackground;
          border = tokens.panelBorder;
          shadow = theme.shadows.panel;
      }
    }

    final resolvedTokenBackground =
        appearance?.background(tokenBackground, const {}) ?? tokenBackground;
    final decorationColor = background?.color ?? resolvedTokenBackground;
    final decorationGradient = background?.gradient;

    // Calculate responsive radii
    final double radiusValue = switch (variant) {
      VSurfaceVariant.base || VSurfaceVariant.elevated => theme.radii.md,
      VSurfaceVariant.card => VResponsive.value<double>(
          context,
          xs: theme.radii.md,
          sm: theme.radii.md,
          md: theme.radii.lg,
        ),
      VSurfaceVariant.panel => VResponsive.value<double>(
          context,
          xs: theme.radii.lg,
          sm: theme.radii.lg,
          md: theme.radii.xl,
        ),
    };
    final resolvedRadius = BorderRadius.circular(
      appearance?.radius(radiusValue) ?? radiusValue,
    );

    // Calculate responsive default padding if not explicitly provided
    final EdgeInsetsGeometry effectivePadding = padding ??
        switch (variant) {
          VSurfaceVariant.base || VSurfaceVariant.elevated => EdgeInsets.zero,
          VSurfaceVariant.card => EdgeInsets.all(
              VResponsive.value<double>(
                context,
                xs: theme.spacing.md,
                sm: theme.spacing.md,
                md: theme.spacing.lg,
              ),
            ),
          VSurfaceVariant.panel => EdgeInsets.all(
              VResponsive.value<double>(
                context,
                xs: theme.spacing.md,
                sm: theme.spacing.lg,
                md: theme.spacing.xl,
              ),
            ),
        };

    final isDotted = borderStyle == VBorderStyle.dotted && border.a > 0;

    Widget result = Container(
      width: width,
      height: height,
      padding: effectivePadding,
      margin: margin,
      decoration: BoxDecoration(
        color: decorationGradient == null ? decorationColor : null,
        gradient: decorationGradient,
        borderRadius: resolvedRadius,
        border: !isDotted && border.a > 0 ? Border.all(color: border) : null,
        boxShadow: shadow != null ? [shadow] : null,
      ),
      child: VVisualBox(
        appearance: background == null
            ? null
            : const _VSurfaceLocalBackgroundAppearance(),
        states: const {},
        background: decorationColor,
        borderRadius: resolvedRadius,
        child: child,
      ),
    );

    if (isDotted) {
      result = CustomPaint(
        foregroundPainter: DottedPathPainter(
          borderRadius: resolvedRadius,
          color: border,
          dotRadius: dotRadius,
          step: dotStep,
        ),
        child: result,
      );
    }

    return result;
  }
}
