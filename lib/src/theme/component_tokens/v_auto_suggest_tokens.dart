import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for auto-suggest dropdowns.
///
/// These are intentionally separate from [VInputTokens] so the suggestion
/// panel and rows can evolve independently from the input.
@immutable
class VAutoSuggestTokens {
  factory VAutoSuggestTokens.fromColors(VColors colors) {
    return VAutoSuggestTokens(
      panelBackground: colors.surface,
      panelBorder: colors.border,
      panelRadius: 8,
      itemHeight: 40,
      itemSubtitleHeight: 56,
      itemPaddingHorizontal: 12,
      itemPaddingVertical: 6,
      itemHover: colors.surfaceHover,
      itemSelected: colors.actionPrimary,
      itemText: colors.text,
      itemSelectedText: colors.actionPrimaryText,
      itemDisabledText: colors.textDisabled,
      matchHighlight: colors.actionPrimary,
    );
  }

  const VAutoSuggestTokens({
    this.panelBackground = const Color(0xFFFEFBFF),
    this.panelBorder = const Color(0xFFE5E7EB),
    this.panelRadius = 8,
    this.itemHeight = 40,
    this.itemSubtitleHeight = 56,
    this.itemPaddingHorizontal = 12,
    this.itemPaddingVertical = 6,
    this.itemHover = const Color(0xFFF3F4F6),
    this.itemSelected = const Color(0xFF3B82F6),
    this.itemText = const Color(0xFF111827),
    this.itemSelectedText = const Color(0xFFFEFBFF),
    this.itemDisabledText = const Color(0xFF9CA3AF),
    this.matchHighlight = const Color(0xFF3B82F6),
  });

  /// Background of the suggestion dropdown panel.
  final Color panelBackground;

  /// Border color of the suggestion dropdown panel.
  final Color panelBorder;

  /// Corner radius of the dropdown panel in logical pixels.
  final double panelRadius;

  /// Fixed item row height in the suggestion list.
  final double itemHeight;

  /// Height for suggestion items that contain a subtitle.
  final double itemSubtitleHeight;

  /// Horizontal padding inside each suggestion item row.
  final double itemPaddingHorizontal;

  /// Vertical padding inside each suggestion item row.
  final double itemPaddingVertical;

  /// Hover / keyboard-highlight background color for items.
  final Color itemHover;

  /// Background color for the selected (checkmarked) item.
  final Color itemSelected;

  /// Default text color for suggestion items.
  final Color itemText;

  /// Text color for the selected item.
  final Color itemSelectedText;

  /// Text color for disabled suggestion items.
  final Color itemDisabledText;

  /// Color used to tint matched substring fragments in item labels.
  final Color matchHighlight;

  static VAutoSuggestTokens lerp(
    VAutoSuggestTokens a,
    VAutoSuggestTokens b,
    double t,
  ) {
    return VAutoSuggestTokens(
      panelBackground:
          lerpComponentTokenColor(a.panelBackground, b.panelBackground, t),
      panelBorder: lerpComponentTokenColor(a.panelBorder, b.panelBorder, t),
      panelRadius: lerpComponentTokenDouble(a.panelRadius, b.panelRadius, t),
      itemHeight: lerpComponentTokenDouble(a.itemHeight, b.itemHeight, t),
      itemSubtitleHeight: lerpComponentTokenDouble(a.itemSubtitleHeight, b.itemSubtitleHeight, t),
      itemPaddingHorizontal: lerpComponentTokenDouble(
          a.itemPaddingHorizontal, b.itemPaddingHorizontal, t),
      itemPaddingVertical: lerpComponentTokenDouble(
          a.itemPaddingVertical, b.itemPaddingVertical, t),
      itemHover: lerpComponentTokenColor(a.itemHover, b.itemHover, t),
      itemSelected: lerpComponentTokenColor(a.itemSelected, b.itemSelected, t),
      itemText: lerpComponentTokenColor(a.itemText, b.itemText, t),
      itemSelectedText:
          lerpComponentTokenColor(a.itemSelectedText, b.itemSelectedText, t),
      itemDisabledText:
          lerpComponentTokenColor(a.itemDisabledText, b.itemDisabledText, t),
      matchHighlight:
          lerpComponentTokenColor(a.matchHighlight, b.matchHighlight, t),
    );
  }

  VAutoSuggestTokens copyWith({
    Color? panelBackground,
    Color? panelBorder,
    double? panelRadius,
    double? itemHeight,
    double? itemSubtitleHeight,
    double? itemPaddingHorizontal,
    double? itemPaddingVertical,
    Color? itemHover,
    Color? itemSelected,
    Color? itemText,
    Color? itemSelectedText,
    Color? itemDisabledText,
    Color? matchHighlight,
  }) {
    return VAutoSuggestTokens(
      panelBackground: panelBackground ?? this.panelBackground,
      panelBorder: panelBorder ?? this.panelBorder,
      panelRadius: panelRadius ?? this.panelRadius,
      itemHeight: itemHeight ?? this.itemHeight,
      itemSubtitleHeight: itemSubtitleHeight ?? this.itemSubtitleHeight,
      itemPaddingHorizontal:
          itemPaddingHorizontal ?? this.itemPaddingHorizontal,
      itemPaddingVertical: itemPaddingVertical ?? this.itemPaddingVertical,
      itemHover: itemHover ?? this.itemHover,
      itemSelected: itemSelected ?? this.itemSelected,
      itemText: itemText ?? this.itemText,
      itemSelectedText: itemSelectedText ?? this.itemSelectedText,
      itemDisabledText: itemDisabledText ?? this.itemDisabledText,
      matchHighlight: matchHighlight ?? this.matchHighlight,
    );
  }
}
