import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:vidraui/vidraui.dart';

/// Example-only appearance presets — NOT part of VidraUI core.
/// Use as patterns for building your own appearances outside the core package.

// ---------------------------------------------------------------------------
// Glassmorphism
// ---------------------------------------------------------------------------

class ExampleGlassmorphismAppearance extends VAppearance {
  const ExampleGlassmorphismAppearance({
    this.blurSigma = 18.0,
    this.surfaceOpacity = 0.18,
    this.borderOpacity = 0.28,
    this.shadowOpacity = 0.10,
  });

  final double blurSigma;
  final double surfaceOpacity;
  final double borderOpacity;
  final double shadowOpacity;

  @override
  double radius(double base) => base * 1.15;

  @override
  Color background(Color base, Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) return base.withValues(alpha: 0.06);
    if (states.contains(WidgetState.pressed)) return base.withValues(alpha: surfaceOpacity * 1.8);
    if (states.contains(WidgetState.hovered)) return base.withValues(alpha: surfaceOpacity * 1.3);
    return base.withValues(alpha: surfaceOpacity);
  }

  @override
  Color foreground(Color base, Set<WidgetState> states, [Color? semantic]) {
    if (base.computeLuminance() > 0.7) return const Color(0xFF111827);
    return base;
  }

  @override
  Color borderColor(Color base, Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) return base.withValues(alpha: 0.08);
    if (states.contains(WidgetState.hovered)) return base.withValues(alpha: borderOpacity * 1.6);
    if (states.contains(WidgetState.focused)) return base;
    return base.withValues(alpha: borderOpacity);
  }

  @override
  double? borderWidth(double? base) => 1;

  @override
  List<BoxShadow> shadows(List<BoxShadow> base) => [
        BoxShadow(color: const Color(0xFF000000).withValues(alpha: shadowOpacity),
            blurRadius: 12, offset: const Offset(0, 4)),
      ];

  @override
  Widget wrap(BuildContext context, Widget child,
      {required BorderRadiusGeometry borderRadius,
      required Set<WidgetState> states}) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: child,
      ),
    );
  }

  @override
  Clip get clipBehavior => Clip.hardEdge;
}

// ---------------------------------------------------------------------------
// Neumorphism
// ---------------------------------------------------------------------------

class ExampleNeumorphismAppearance extends VAppearance {
  const ExampleNeumorphismAppearance({
    this.depth = 8,
    this.intensity = 0.18,
    this.lightIntensity = 0.72,
  });

  final double depth;
  final double intensity;
  final double lightIntensity;

  @override
  double radius(double base) => base * 1.4;

  @override
  Color background(Color base, Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) return base.withValues(alpha: 0.5);
    if (states.contains(WidgetState.pressed)) return Color.alphaBlend(const Color(0x0D000000), base);
    return base;
  }

  @override
  Color foreground(Color base, Set<WidgetState> states, [Color? semantic]) => base;

  @override
  List<BoxShadow> shadows(List<BoxShadow> base) {
    final d = depth;
    return [
      BoxShadow(color: const Color(0xFFFFFFFF).withValues(alpha: lightIntensity * 0.1),
          blurRadius: d * 1.2, offset: Offset(-d * 0.4, -d * 0.4)),
      BoxShadow(color: const Color(0xFF000000).withValues(alpha: intensity),
          blurRadius: d * 1.5, offset: Offset(d * 0.5, d * 0.5)),
    ];
  }

  @override
  Color borderColor(Color base, Set<WidgetState> states) {
    if (states.contains(WidgetState.focused)) return base;
    return base.withValues(alpha: 0.10);
  }

  @override
  double? borderWidth(double? base) => 1;

  @override
  List<BoxShadow> innerShadows(Set<WidgetState> states, {required Color background}) {
    if (states.contains(WidgetState.pressed)) {
      return [
        BoxShadow(color: const Color(0xFF000000).withValues(alpha: intensity * 0.6),
            blurRadius: depth * 0.8, offset: Offset(depth * 0.15, depth * 0.15)),
      ];
    }
    return const [];
  }
}
