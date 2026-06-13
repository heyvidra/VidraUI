import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for dialogs.
@immutable
class VDialogTokens {
  factory VDialogTokens.fromColors(VColors colors) {
    return VDialogTokens(
      surface: colors.surface,
      barrierColor: const Color(0x99000000),
      defaultWidth: 400,
      defaultMaxHeight: 500,
    );
  }

  const VDialogTokens({
    required this.surface,
    required this.barrierColor,
    required this.defaultWidth,
    required this.defaultMaxHeight,
  });

  final Color surface;
  final Color barrierColor;

  /// Default dialog panel width in logical pixels.
  final double defaultWidth;

  /// Default maximum dialog height in logical pixels before content scrolls.
  final double defaultMaxHeight;

  static VDialogTokens lerp(VDialogTokens a, VDialogTokens b, double t) {
    return VDialogTokens(
      surface: lerpComponentTokenColor(a.surface, b.surface, t),
      barrierColor: lerpComponentTokenColor(a.barrierColor, b.barrierColor, t),
      defaultWidth: lerpComponentTokenDouble(a.defaultWidth, b.defaultWidth, t),
      defaultMaxHeight:
          lerpComponentTokenDouble(a.defaultMaxHeight, b.defaultMaxHeight, t),
    );
  }

  VDialogTokens copyWith({
    Color? surface,
    Color? barrierColor,
    double? defaultWidth,
    double? defaultMaxHeight,
  }) {
    return VDialogTokens(
      surface: surface ?? this.surface,
      barrierColor: barrierColor ?? this.barrierColor,
      defaultWidth: defaultWidth ?? this.defaultWidth,
      defaultMaxHeight: defaultMaxHeight ?? this.defaultMaxHeight,
    );
  }
}
