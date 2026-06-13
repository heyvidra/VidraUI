import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for time pickers.
@immutable
class VTimePickerTokens {
  factory VTimePickerTokens.fromColors(VColors colors) {
    return VTimePickerTokens(
      itemForeground: colors.text,
      selectedForeground: colors.actionPrimary,
    );
  }

  const VTimePickerTokens({
    this.itemForeground = const Color(0xFF111827),
    this.selectedForeground = const Color(0xFF2563EB),
    this.columnWidth = 64,
    this.wheelHeight = 180,
    this.itemHeight = 40,
    this.diameterRatio = 2.5,
  });

  final Color itemForeground;
  final Color selectedForeground;
  final double columnWidth;
  final double wheelHeight;
  final double itemHeight;
  final double diameterRatio;

  static VTimePickerTokens lerp(
    VTimePickerTokens a,
    VTimePickerTokens b,
    double t,
  ) {
    return VTimePickerTokens(
      itemForeground:
          lerpComponentTokenColor(a.itemForeground, b.itemForeground, t),
      selectedForeground: lerpComponentTokenColor(
          a.selectedForeground, b.selectedForeground, t),
      columnWidth: lerpComponentTokenDouble(a.columnWidth, b.columnWidth, t),
      wheelHeight: lerpComponentTokenDouble(a.wheelHeight, b.wheelHeight, t),
      itemHeight: lerpComponentTokenDouble(a.itemHeight, b.itemHeight, t),
      diameterRatio:
          lerpComponentTokenDouble(a.diameterRatio, b.diameterRatio, t),
    );
  }

  VTimePickerTokens copyWith({
    Color? itemForeground,
    Color? selectedForeground,
    double? columnWidth,
    double? wheelHeight,
    double? itemHeight,
    double? diameterRatio,
  }) {
    return VTimePickerTokens(
      itemForeground: itemForeground ?? this.itemForeground,
      selectedForeground: selectedForeground ?? this.selectedForeground,
      columnWidth: columnWidth ?? this.columnWidth,
      wheelHeight: wheelHeight ?? this.wheelHeight,
      itemHeight: itemHeight ?? this.itemHeight,
      diameterRatio: diameterRatio ?? this.diameterRatio,
    );
  }
}
