import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../internal/_dotted_border.dart';

/// Divider visual style.
enum VDividerStyle { solid, dotted }

/// A thin horizontal or vertical separator line.
///
/// When [label] is provided and [axis] is [Axis.horizontal], the label is
/// rendered centered between two line segments:
/// ```txt
/// ──────  Label  ──────
/// ```
class VDivider extends StatelessWidget {
  const VDivider({
    super.key,
    this.axis = Axis.horizontal,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.style = VDividerStyle.solid,
    this.dotRadius,
    this.dotStep,
    this.label,
  });

  final Axis axis;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  /// Border style. Defaults to [VDividerStyle.solid].
  final VDividerStyle style;

  /// Dot radius when [style] is [VDividerStyle.dotted].
  final double? dotRadius;

  /// Centre-to-centre dot spacing when [style] is [VDividerStyle.dotted].
  final double? dotStep;

  /// Optional label displayed in the centre of the divider.
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VDividerTheme.of(context) ?? theme.components.divider;

    final effectiveColor = color ?? tokens.color;
    final effectiveThickness = thickness ?? tokens.thickness;
    final effectiveDotRadius = dotRadius ?? tokens.dotRadius;
    final effectiveDotStep = dotStep ?? tokens.dotStep;

    final margin = axis == Axis.horizontal
        ? EdgeInsetsDirectional.only(start: indent ?? 0, end: endIndent ?? 0)
        : EdgeInsetsDirectional.only(top: indent ?? 0, bottom: endIndent ?? 0);

    if (style == VDividerStyle.dotted) {
      final dotDiameter = effectiveDotRadius * 2;
      return Container(
        margin: margin,
        height: axis == Axis.horizontal ? dotDiameter : null,
        width: axis == Axis.vertical ? dotDiameter : null,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w =
                constraints.maxWidth.isFinite ? constraints.maxWidth : 0.0;
            final h =
                constraints.maxHeight.isFinite ? constraints.maxHeight : 0.0;
            return CustomPaint(
              painter: DottedPathPainter(
                path: axis == Axis.horizontal
                    ? (Path()..moveTo(0, h / 2)..lineTo(w, h / 2))
                    : (Path()..moveTo(w / 2, 0)..lineTo(w / 2, h)),
                color: effectiveColor,
                dotRadius: effectiveDotRadius,
                step: effectiveDotStep,
              ),
            );
          },
        ),
      );
    }

    // Label mode — supports both horizontal and vertical dividers.
    if (label != null) {
      if (axis == Axis.horizontal) {
        return Container(
          margin: margin,
          child: Row(
            children: [
              Expanded(
                child: Container(height: effectiveThickness, color: effectiveColor),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DefaultTextStyle.merge(
                  style: theme.typography.caption.copyWith(color: effectiveColor),
                  child: label!,
                ),
              ),
              Expanded(
                child: Container(height: effectiveThickness, color: effectiveColor),
              ),
            ],
          ),
        );
      } else { // Axis.vertical
        return Container(
          margin: margin,
          child: Column(
            children: [
              Expanded(
                child: Container(width: effectiveThickness, color: effectiveColor),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: DefaultTextStyle.merge(
                  style: theme.typography.caption.copyWith(color: effectiveColor),
                  child: label!,
                ),
              ),
              Expanded(
                child: Container(width: effectiveThickness, color: effectiveColor),
              ),
            ],
          ),
        );
      }
    }

    if (axis == Axis.horizontal) {
      return Container(
        height: effectiveThickness,
        margin: margin,
        color: effectiveColor,
      );
    }
    return Container(
      width: effectiveThickness,
      margin: margin,
      color: effectiveColor,
    );
  }
}
