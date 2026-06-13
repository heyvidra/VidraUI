import 'package:flutter/widgets.dart';

import '../../theme/v_icon_theme.dart';
import '../../theme/v_icon_theme_data.dart';
import '../../theme/v_theme.dart';

/// A theme-aware icon widget.
///
/// Resolution priority for size/color/opacity:
/// 1. Explicit widget property
/// 2. [VIconTheme.maybeOf]
/// 3. [VTheme] fallback (color only)
/// 4. Hard fallback: size 20.0, opacity 1.0
class VIcon extends StatelessWidget {
  const VIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.opacity,
    this.semanticLabel,
    this.textDirection,
  });

  /// The icon to display. Uses Flutter's [IconData].
  final IconData icon;

  /// Override for icon size.
  final double? size;

  /// Override for icon color.
  final Color? color;

  /// Override for icon opacity.
  final double? opacity;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Text direction override (for bidirectional icons).
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final iconTheme = VIconTheme.maybeOf(context);

    final effectiveSize = size ?? iconTheme?.size ?? VIconThemeData.defaultSize;

    final effectiveColor = color ?? iconTheme?.color ?? theme.colors.text;

    final effectiveOpacity =
        opacity ?? iconTheme?.opacity ?? VIconThemeData.defaultOpacity;

    Widget iconWidget = Icon(
      icon,
      size: effectiveSize,
      color: effectiveColor,
      textDirection: textDirection,
    );

    if (effectiveOpacity < 1.0) {
      iconWidget = Opacity(
        opacity: effectiveOpacity,
        child: iconWidget,
      );
    }

    if (semanticLabel != null) {
      iconWidget = Semantics(
        label: semanticLabel,
        child: ExcludeSemantics(child: iconWidget),
      );
    }

    return iconWidget;
  }
}
