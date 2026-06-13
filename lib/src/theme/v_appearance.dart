import 'package:flutter/widgets.dart';

/// An appearance modifies how components render without changing their
/// underlying semantics or layout.
///
/// Subclasses override hooks to produce visual styles. All hooks are
/// additive — the base class returns sensible defaults (no-op/identity).
@immutable
abstract class VAppearance {
  const VAppearance();

  // -- Paint-level hooks --

  double radius(double base) => base;
  List<BoxShadow> shadows(List<BoxShadow> base) => base;
  Color background(Color base, Set<WidgetState> states) => base;

  /// Override the foreground (text/icon) color.
  Color foreground(Color base, Set<WidgetState> states, [Color? semantic]) =>
      base;

  Color borderColor(Color base, Set<WidgetState> states) => base;
  double? borderWidth(double? base) => base;

  /// Inner shadows applied after the background. Empty by default.
  /// [background] is the resolved solid background color (useful for
  /// computing inner shadow contrast).
  List<BoxShadow> innerShadows(
    Set<WidgetState> states, {
    required Color background,
  }) =>
      const <BoxShadow>[];

  /// Optional gradient background. When non-null, replaces the solid
  /// [background] color.
  Gradient? gradient(Color base, Set<WidgetState> states) => null;

  // -- Widget-level hook --

  /// Wraps the component's visual subtree. Default: identity.
  ///
  /// Implementations may inject [BackdropFilter], [ShaderMask],
  /// [ClipRRect], [Opacity], or any other wrapper widget.
  /// [borderRadius] is the already-resolved border radius so wrappers
  /// can match the component's shape.
  Widget wrap(
    BuildContext context,
    Widget child, {
    required BorderRadiusGeometry borderRadius,
    required Set<WidgetState> states,
  }) {
    return child;
  }

  /// Clip behavior for the visual box. Override to [Clip.hardEdge] when
  /// using [BackdropFilter] to prevent blur bleeding.
  Clip get clipBehavior => Clip.antiAlias;
}

// ---------------------------------------------------------------------------
// Concrete appearances
// ---------------------------------------------------------------------------

/// Flat appearance — no shadows, minimal borders, subtle backgrounds.
class VFlatAppearance extends VAppearance {
  const VFlatAppearance();

  @override
  List<BoxShadow> shadows(List<BoxShadow> base) => const [];

  @override
  Color background(Color base, Set<WidgetState> states) {
    if (states.contains(WidgetState.hovered)) {
      return base.withValues(alpha: 0.85);
    }
    if (states.contains(WidgetState.pressed)) {
      return base.withValues(alpha: 0.7);
    }
    return base;
  }

  @override
  Color borderColor(Color base, Set<WidgetState> states) {
    if (states.contains(WidgetState.hovered)) {
      return base.withValues(alpha: 0.5);
    }
    return base.withValues(alpha: 0.3);
  }
}

/// Soft appearance — extra rounded corners, softer shadows.
class VSoftAppearance extends VAppearance {
  const VSoftAppearance();

  @override
  double radius(double base) => base * 1.5;

  @override
  List<BoxShadow> shadows(List<BoxShadow> base) {
    if (base.isEmpty) {
      return const [
        BoxShadow(
            color: Color(0x0A000000), blurRadius: 6, offset: Offset(0, 2)),
      ];
    }
    return base
        .map((s) => BoxShadow(
              color: s.color.withValues(alpha: (s.color.a * 0.6).clamp(0, 1.0)),
              blurRadius: s.blurRadius * 1.5,
              offset: s.offset * 1.5,
              spreadRadius: s.spreadRadius,
            ))
        .toList();
  }

  @override
  Color background(Color base, Set<WidgetState> states) {
    if (states.contains(WidgetState.hovered)) {
      return Color.alphaBlend(const Color(0x0A000000), base);
    }
    if (states.contains(WidgetState.pressed)) {
      return Color.alphaBlend(const Color(0x1A000000), base);
    }
    return base;
  }
}

/// Outlined appearance — transparent backgrounds, prominent borders.
class VOutlinedAppearance extends VAppearance {
  const VOutlinedAppearance();

  @override
  Color foreground(Color base, Set<WidgetState> states, [Color? semantic]) {
    // On transparent bg, use the variant's semantic color as text.
    return semantic ?? base;
  }

  @override
  List<BoxShadow> shadows(List<BoxShadow> base) => const [];

  @override
  Color background(Color base, Set<WidgetState> states) {
    if (states.contains(WidgetState.hovered)) {
      return base.withValues(alpha: 0.08);
    }
    if (states.contains(WidgetState.pressed)) {
      return base.withValues(alpha: 0.15);
    }
    return const Color(0x00000000);
  }

  @override
  Color borderColor(Color base, Set<WidgetState> states) {
    if (states.contains(WidgetState.focused)) return base;
    if (states.contains(WidgetState.hovered)) return base;
    return base.withValues(alpha: 0.5);
  }

  @override
  double? borderWidth(double? base) => (base ?? 1.0) * 1.5;
}
