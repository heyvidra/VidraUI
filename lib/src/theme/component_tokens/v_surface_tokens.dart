import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for surface variants.
@immutable
class VSurfaceTokens {
  factory VSurfaceTokens.fromColors(VColors colors) {
    return VSurfaceTokens(
      baseBackground: colors.background,
      baseBorder: const Color(0x00000000),
      elevatedBackground: colors.surface,
      elevatedBorder: colors.border,
      cardBackground: colors.surface,
      cardBorder: colors.border,
      panelBackground: colors.surfaceElevated,
      panelBorder: colors.border,
    );
  }

  const VSurfaceTokens({
    required this.baseBackground,
    required this.baseBorder,
    required this.elevatedBackground,
    required this.elevatedBorder,
    required this.cardBackground,
    required this.cardBorder,
    required this.panelBackground,
    required this.panelBorder,
  });

  final Color baseBackground;
  final Color baseBorder;

  final Color elevatedBackground;
  final Color elevatedBorder;

  final Color cardBackground;
  final Color cardBorder;

  final Color panelBackground;
  final Color panelBorder;

  static VSurfaceTokens lerp(VSurfaceTokens a, VSurfaceTokens b, double t) {
    return VSurfaceTokens(
      baseBackground:
          lerpComponentTokenColor(a.baseBackground, b.baseBackground, t),
      baseBorder: lerpComponentTokenColor(a.baseBorder, b.baseBorder, t),
      elevatedBackground: lerpComponentTokenColor(
          a.elevatedBackground, b.elevatedBackground, t),
      elevatedBorder:
          lerpComponentTokenColor(a.elevatedBorder, b.elevatedBorder, t),
      cardBackground:
          lerpComponentTokenColor(a.cardBackground, b.cardBackground, t),
      cardBorder: lerpComponentTokenColor(a.cardBorder, b.cardBorder, t),
      panelBackground:
          lerpComponentTokenColor(a.panelBackground, b.panelBackground, t),
      panelBorder: lerpComponentTokenColor(a.panelBorder, b.panelBorder, t),
    );
  }

  VSurfaceTokens copyWith({
    Color? baseBackground,
    Color? baseBorder,
    Color? elevatedBackground,
    Color? elevatedBorder,
    Color? cardBackground,
    Color? cardBorder,
    Color? panelBackground,
    Color? panelBorder,
  }) {
    return VSurfaceTokens(
      baseBackground: baseBackground ?? this.baseBackground,
      baseBorder: baseBorder ?? this.baseBorder,
      elevatedBackground: elevatedBackground ?? this.elevatedBackground,
      elevatedBorder: elevatedBorder ?? this.elevatedBorder,
      cardBackground: cardBackground ?? this.cardBackground,
      cardBorder: cardBorder ?? this.cardBorder,
      panelBackground: panelBackground ?? this.panelBackground,
      panelBorder: panelBorder ?? this.panelBorder,
    );
  }
}
