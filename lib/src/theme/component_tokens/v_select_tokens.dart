import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import '../../foundation/state.dart';
import 'component_token_utils.dart';

/// Component-level tokens for select/dropdown.
@immutable
class VSelectTokens {
  factory VSelectTokens.fromColors(VColors colors) {
    return VSelectTokens(
      background: VStateProperty.resolveWith(
        normal: colors.surface,
        hovered: colors.surfaceHover,
        disabled: colors.surfaceElevated,
      ),
      border: VStateProperty.resolveWith(
        normal: colors.border,
        hovered: colors.borderStrong,
        focused: colors.focusRing,
        error: colors.danger,
        disabled: colors.border,
      ),
      text: VStateProperty.resolveWith(
        normal: colors.text,
        disabled: colors.textDisabled,
      ),
      placeholder: colors.textMuted,
      focusRing: colors.focusRing,
      menuBackground: colors.surface,
      menuBorder: colors.border,
      menuHover: colors.surfaceHover,
      menuSelectedBackground: colors.actionPrimary,
      menuSelectedText: colors.actionPrimaryText,
      menuText: colors.text,
      menuDisabledText: colors.textDisabled,
      triggerHeight: 40,
      triggerPaddingHorizontal: 12,
      triggerPaddingVertical: 8,
      triggerRadius: 8,
      triggerBorderWidth: 1,
      menuRadius: 8,
      menuBorderWidth: 1,
      itemHeight: 48,
      itemPaddingHorizontal: 12,
      itemPaddingVertical: 0,
      indicatorSize: 10,
      checkmarkSize: 14,
      checkboxSize: 20,
      checkboxBorderWidth: 2,
      searchFieldHeight: 56,
    );
  }

  const VSelectTokens({
    required this.background,
    required this.border,
    required this.text,
    required this.placeholder,
    required this.focusRing,
    required this.menuBackground,
    required this.menuBorder,
    required this.menuHover,
    this.menuSelectedBackground = const Color(0xFF2563EB),
    this.menuSelectedText = const Color(0xFFFEFBFF),
    this.menuText = const Color(0xFF111827),
    this.menuDisabledText = const Color(0xFF9CA3AF),
    this.triggerHeight = 40,
    this.triggerPaddingHorizontal = 12,
    this.triggerPaddingVertical = 8,
    this.triggerRadius = 8,
    this.triggerBorderWidth = 1,
    this.menuRadius = 8,
    this.menuBorderWidth = 1,
    this.itemHeight = 48,
    this.itemPaddingHorizontal = 12,
    this.itemPaddingVertical = 0,
    this.indicatorSize = 10,
    this.checkmarkSize = 14,
    this.checkboxSize = 20,
    this.checkboxBorderWidth = 2,
    this.searchFieldHeight = 56,
  });

  final WidgetStateProperty<Color> background;
  final WidgetStateProperty<Color> border;
  final WidgetStateProperty<Color> text;
  final Color placeholder;
  final Color focusRing;
  final Color menuBackground;
  final Color menuBorder;
  final Color menuHover;
  final Color menuSelectedBackground;
  final Color menuSelectedText;
  final Color menuText;
  final Color menuDisabledText;
  final double triggerHeight;
  final double triggerPaddingHorizontal;
  final double triggerPaddingVertical;
  final double triggerRadius;
  final double triggerBorderWidth;
  final double menuRadius;
  final double menuBorderWidth;
  final double itemHeight;
  final double itemPaddingHorizontal;
  final double itemPaddingVertical;
  final double indicatorSize;
  final double checkmarkSize;
  final double checkboxSize;
  final double checkboxBorderWidth;
  final double searchFieldHeight;

  static VSelectTokens lerp(VSelectTokens a, VSelectTokens b, double t) {
    return VSelectTokens(
      background: lerpComponentTokenStateColor(a.background, b.background, t),
      border: lerpComponentTokenStateColor(a.border, b.border, t),
      text: lerpComponentTokenStateColor(a.text, b.text, t),
      placeholder: lerpComponentTokenColor(a.placeholder, b.placeholder, t),
      focusRing: lerpComponentTokenColor(a.focusRing, b.focusRing, t),
      menuBackground:
          lerpComponentTokenColor(a.menuBackground, b.menuBackground, t),
      menuBorder: lerpComponentTokenColor(a.menuBorder, b.menuBorder, t),
      menuHover: lerpComponentTokenColor(a.menuHover, b.menuHover, t),
      menuSelectedBackground: lerpComponentTokenColor(
          a.menuSelectedBackground, b.menuSelectedBackground, t),
      menuSelectedText:
          lerpComponentTokenColor(a.menuSelectedText, b.menuSelectedText, t),
      menuText: lerpComponentTokenColor(a.menuText, b.menuText, t),
      menuDisabledText:
          lerpComponentTokenColor(a.menuDisabledText, b.menuDisabledText, t),
      triggerHeight:
          lerpComponentTokenDouble(a.triggerHeight, b.triggerHeight, t),
      triggerPaddingHorizontal: lerpComponentTokenDouble(
          a.triggerPaddingHorizontal, b.triggerPaddingHorizontal, t),
      triggerPaddingVertical: lerpComponentTokenDouble(
          a.triggerPaddingVertical, b.triggerPaddingVertical, t),
      triggerRadius:
          lerpComponentTokenDouble(a.triggerRadius, b.triggerRadius, t),
      triggerBorderWidth: lerpComponentTokenDouble(
          a.triggerBorderWidth, b.triggerBorderWidth, t),
      menuRadius: lerpComponentTokenDouble(a.menuRadius, b.menuRadius, t),
      menuBorderWidth:
          lerpComponentTokenDouble(a.menuBorderWidth, b.menuBorderWidth, t),
      itemHeight: lerpComponentTokenDouble(a.itemHeight, b.itemHeight, t),
      itemPaddingHorizontal: lerpComponentTokenDouble(
          a.itemPaddingHorizontal, b.itemPaddingHorizontal, t),
      itemPaddingVertical: lerpComponentTokenDouble(
          a.itemPaddingVertical, b.itemPaddingVertical, t),
      indicatorSize:
          lerpComponentTokenDouble(a.indicatorSize, b.indicatorSize, t),
      checkmarkSize:
          lerpComponentTokenDouble(a.checkmarkSize, b.checkmarkSize, t),
      checkboxSize: lerpComponentTokenDouble(a.checkboxSize, b.checkboxSize, t),
      checkboxBorderWidth: lerpComponentTokenDouble(
          a.checkboxBorderWidth, b.checkboxBorderWidth, t),
      searchFieldHeight: lerpComponentTokenDouble(
          a.searchFieldHeight, b.searchFieldHeight, t),
    );
  }

  VSelectTokens copyWith({
    WidgetStateProperty<Color>? background,
    WidgetStateProperty<Color>? border,
    WidgetStateProperty<Color>? text,
    Color? placeholder,
    Color? focusRing,
    Color? menuBackground,
    Color? menuBorder,
    Color? menuHover,
    Color? menuSelectedBackground,
    Color? menuSelectedText,
    Color? menuText,
    Color? menuDisabledText,
    double? triggerHeight,
    double? triggerPaddingHorizontal,
    double? triggerPaddingVertical,
    double? triggerRadius,
    double? triggerBorderWidth,
    double? menuRadius,
    double? menuBorderWidth,
    double? itemHeight,
    double? itemPaddingHorizontal,
    double? itemPaddingVertical,
    double? indicatorSize,
    double? checkmarkSize,
    double? checkboxSize,
    double? checkboxBorderWidth,
    double? searchFieldHeight,
  }) {
    return VSelectTokens(
      background: background ?? this.background,
      border: border ?? this.border,
      text: text ?? this.text,
      placeholder: placeholder ?? this.placeholder,
      focusRing: focusRing ?? this.focusRing,
      menuBackground: menuBackground ?? this.menuBackground,
      menuBorder: menuBorder ?? this.menuBorder,
      menuHover: menuHover ?? this.menuHover,
      menuSelectedBackground:
          menuSelectedBackground ?? this.menuSelectedBackground,
      menuSelectedText: menuSelectedText ?? this.menuSelectedText,
      menuText: menuText ?? this.menuText,
      menuDisabledText: menuDisabledText ?? this.menuDisabledText,
      triggerHeight: triggerHeight ?? this.triggerHeight,
      triggerPaddingHorizontal:
          triggerPaddingHorizontal ?? this.triggerPaddingHorizontal,
      triggerPaddingVertical:
          triggerPaddingVertical ?? this.triggerPaddingVertical,
      triggerRadius: triggerRadius ?? this.triggerRadius,
      triggerBorderWidth: triggerBorderWidth ?? this.triggerBorderWidth,
      menuRadius: menuRadius ?? this.menuRadius,
      menuBorderWidth: menuBorderWidth ?? this.menuBorderWidth,
      itemHeight: itemHeight ?? this.itemHeight,
      itemPaddingHorizontal:
          itemPaddingHorizontal ?? this.itemPaddingHorizontal,
      itemPaddingVertical: itemPaddingVertical ?? this.itemPaddingVertical,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      checkmarkSize: checkmarkSize ?? this.checkmarkSize,
      checkboxSize: checkboxSize ?? this.checkboxSize,
      checkboxBorderWidth: checkboxBorderWidth ?? this.checkboxBorderWidth,
      searchFieldHeight: searchFieldHeight ?? this.searchFieldHeight,
    );
  }
}
