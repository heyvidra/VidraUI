import 'package:flutter/widgets.dart';

import '../../theme/v_appearance_box.dart';
import '../../theme/v_appearance_scope.dart';
import '../../theme/v_theme.dart';

/// A token-aware layout container.
class VBox extends StatelessWidget {
  const VBox({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.radius,
    this.border,
    this.width,
    this.height,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? radius;
  final BoxBorder? border;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final appearance = VAppearanceScope.of(context);
    // When no explicit [color] is provided, defaults to the theme surface
    // color so VBox renders as a themed container. To get a transparent
    // background, pass `color: const Color(0x00000000)`.
    final baseColor = color ?? theme.colors.surface;
    final baseRadius = radius ?? theme.radii.md;
    final resolvedBg = appearance?.background(baseColor, const {}) ?? baseColor;
    final resolvedRadius = appearance?.radius(baseRadius) ?? baseRadius;

    return VVisualBox(
      appearance: appearance,
      states: const {},
      background: resolvedBg,
      borderRadius: BorderRadius.circular(resolvedRadius),
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: resolvedBg,
          borderRadius: BorderRadius.circular(resolvedRadius),
          border: border,
        ),
        child: child,
      ),
    );
  }
}
