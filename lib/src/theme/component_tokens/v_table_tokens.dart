import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for data tables.
@immutable
class VTableTokens {
  factory VTableTokens.fromColors(VColors colors) {
    return VTableTokens(
      headerBackground: colors.surfaceElevated,
      headerHoverBackground: colors.surfaceHover,
      headerFocusOutlineColor: colors.actionPrimary,
      rowBackground: colors.surface,
      alternateRowBackground: colors.surfaceElevated.withValues(alpha: 0.45),
      borderColor: colors.border,
      dividerColor: colors.border,
      headerForeground: colors.text,
      bodyForeground: colors.text,
      sortIndicatorColor: colors.actionPrimary,
      sortIndicatorActiveColor: colors.actionPrimary,
      emptyForeground: colors.textMuted,
    );
  }

  const VTableTokens({
    this.headerBackground = const Color(0xFFF3F4F6),
    this.headerHoverBackground = const Color(0xFFE5E7EB),
    this.headerFocusOutlineColor = const Color(0xFF2563EB),
    this.rowBackground = const Color(0xFFFEFBFF),
    this.alternateRowBackground = const Color(0xFFF9FAFB),
    this.borderColor = const Color(0xFFE5E7EB),
    this.dividerColor = const Color(0xFFE5E7EB),
    this.headerForeground = const Color(0xFF111827),
    this.bodyForeground = const Color(0xFF111827),
    this.sortIndicatorColor = const Color(0xFF2563EB),
    this.sortIndicatorActiveColor = const Color(0xFF2563EB),
    this.emptyForeground = const Color(0xFF6B7280),
    this.headerPaddingHorizontal = 12,
    this.headerPaddingVertical = 8,
    this.cellPaddingHorizontal = 12,
    this.cellPaddingVertical = 0,
    this.headerDividerWidth = 2,
    this.rowDividerWidth = 1,
    this.headerFocusOutlineWidth = 2,
    this.sortIndicatorSize = 10,
    this.sortIndicatorSpacing = 6,
    this.emptyPaddingHorizontal = 16,
    this.emptyPaddingVertical = 24,
    this.emptyTextSize = 14,
  });

  final Color headerBackground;
  final Color headerHoverBackground;
  final Color headerFocusOutlineColor;
  final Color rowBackground;
  final Color alternateRowBackground;
  final Color borderColor;
  final Color dividerColor;
  final Color headerForeground;
  final Color bodyForeground;
  final Color sortIndicatorColor;
  final Color sortIndicatorActiveColor;
  final Color emptyForeground;
  final double headerPaddingHorizontal;
  final double headerPaddingVertical;
  final double cellPaddingHorizontal;
  final double cellPaddingVertical;
  final double headerDividerWidth;
  final double rowDividerWidth;
  final double headerFocusOutlineWidth;
  final double sortIndicatorSize;
  final double sortIndicatorSpacing;
  final double emptyPaddingHorizontal;
  final double emptyPaddingVertical;
  final double emptyTextSize;

  static VTableTokens lerp(VTableTokens a, VTableTokens b, double t) {
    return VTableTokens(
      headerBackground:
          lerpComponentTokenColor(a.headerBackground, b.headerBackground, t),
      headerHoverBackground: lerpComponentTokenColor(
          a.headerHoverBackground, b.headerHoverBackground, t),
      headerFocusOutlineColor: lerpComponentTokenColor(
          a.headerFocusOutlineColor, b.headerFocusOutlineColor, t),
      rowBackground:
          lerpComponentTokenColor(a.rowBackground, b.rowBackground, t),
      alternateRowBackground: lerpComponentTokenColor(
          a.alternateRowBackground, b.alternateRowBackground, t),
      borderColor: lerpComponentTokenColor(a.borderColor, b.borderColor, t),
      dividerColor: lerpComponentTokenColor(a.dividerColor, b.dividerColor, t),
      headerForeground:
          lerpComponentTokenColor(a.headerForeground, b.headerForeground, t),
      bodyForeground:
          lerpComponentTokenColor(a.bodyForeground, b.bodyForeground, t),
      sortIndicatorColor: lerpComponentTokenColor(
          a.sortIndicatorColor, b.sortIndicatorColor, t),
      sortIndicatorActiveColor: lerpComponentTokenColor(
          a.sortIndicatorActiveColor, b.sortIndicatorActiveColor, t),
      emptyForeground:
          lerpComponentTokenColor(a.emptyForeground, b.emptyForeground, t),
      headerPaddingHorizontal: lerpComponentTokenDouble(
          a.headerPaddingHorizontal, b.headerPaddingHorizontal, t),
      headerPaddingVertical: lerpComponentTokenDouble(
          a.headerPaddingVertical, b.headerPaddingVertical, t),
      cellPaddingHorizontal: lerpComponentTokenDouble(
          a.cellPaddingHorizontal, b.cellPaddingHorizontal, t),
      cellPaddingVertical: lerpComponentTokenDouble(
          a.cellPaddingVertical, b.cellPaddingVertical, t),
      headerDividerWidth: lerpComponentTokenDouble(
          a.headerDividerWidth, b.headerDividerWidth, t),
      rowDividerWidth:
          lerpComponentTokenDouble(a.rowDividerWidth, b.rowDividerWidth, t),
      headerFocusOutlineWidth: lerpComponentTokenDouble(
          a.headerFocusOutlineWidth, b.headerFocusOutlineWidth, t),
      sortIndicatorSize:
          lerpComponentTokenDouble(a.sortIndicatorSize, b.sortIndicatorSize, t),
      sortIndicatorSpacing: lerpComponentTokenDouble(
          a.sortIndicatorSpacing, b.sortIndicatorSpacing, t),
      emptyPaddingHorizontal: lerpComponentTokenDouble(
          a.emptyPaddingHorizontal, b.emptyPaddingHorizontal, t),
      emptyPaddingVertical: lerpComponentTokenDouble(
          a.emptyPaddingVertical, b.emptyPaddingVertical, t),
      emptyTextSize:
          lerpComponentTokenDouble(a.emptyTextSize, b.emptyTextSize, t),
    );
  }

  VTableTokens copyWith({
    Color? headerBackground,
    Color? headerHoverBackground,
    Color? headerFocusOutlineColor,
    Color? rowBackground,
    Color? alternateRowBackground,
    Color? borderColor,
    Color? dividerColor,
    Color? headerForeground,
    Color? bodyForeground,
    Color? sortIndicatorColor,
    Color? sortIndicatorActiveColor,
    Color? emptyForeground,
    double? headerPaddingHorizontal,
    double? headerPaddingVertical,
    double? cellPaddingHorizontal,
    double? cellPaddingVertical,
    double? headerDividerWidth,
    double? rowDividerWidth,
    double? headerFocusOutlineWidth,
    double? sortIndicatorSize,
    double? sortIndicatorSpacing,
    double? emptyPaddingHorizontal,
    double? emptyPaddingVertical,
    double? emptyTextSize,
  }) {
    return VTableTokens(
      headerBackground: headerBackground ?? this.headerBackground,
      headerHoverBackground:
          headerHoverBackground ?? this.headerHoverBackground,
      headerFocusOutlineColor:
          headerFocusOutlineColor ?? this.headerFocusOutlineColor,
      rowBackground: rowBackground ?? this.rowBackground,
      alternateRowBackground:
          alternateRowBackground ?? this.alternateRowBackground,
      borderColor: borderColor ?? this.borderColor,
      dividerColor: dividerColor ?? this.dividerColor,
      headerForeground: headerForeground ?? this.headerForeground,
      bodyForeground: bodyForeground ?? this.bodyForeground,
      sortIndicatorColor: sortIndicatorColor ?? this.sortIndicatorColor,
      sortIndicatorActiveColor:
          sortIndicatorActiveColor ?? this.sortIndicatorActiveColor,
      emptyForeground: emptyForeground ?? this.emptyForeground,
      headerPaddingHorizontal:
          headerPaddingHorizontal ?? this.headerPaddingHorizontal,
      headerPaddingVertical:
          headerPaddingVertical ?? this.headerPaddingVertical,
      cellPaddingHorizontal:
          cellPaddingHorizontal ?? this.cellPaddingHorizontal,
      cellPaddingVertical: cellPaddingVertical ?? this.cellPaddingVertical,
      headerDividerWidth: headerDividerWidth ?? this.headerDividerWidth,
      rowDividerWidth: rowDividerWidth ?? this.rowDividerWidth,
      headerFocusOutlineWidth:
          headerFocusOutlineWidth ?? this.headerFocusOutlineWidth,
      sortIndicatorSize: sortIndicatorSize ?? this.sortIndicatorSize,
      sortIndicatorSpacing: sortIndicatorSpacing ?? this.sortIndicatorSpacing,
      emptyPaddingHorizontal:
          emptyPaddingHorizontal ?? this.emptyPaddingHorizontal,
      emptyPaddingVertical: emptyPaddingVertical ?? this.emptyPaddingVertical,
      emptyTextSize: emptyTextSize ?? this.emptyTextSize,
    );
  }
}
