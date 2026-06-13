import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for anchored menus.
@immutable
class VMenuTokens {
  factory VMenuTokens.fromColors(VColors colors) {
    return VMenuTokens(
      background: colors.surface,
      border: colors.border,
      hoverBackground: colors.surfaceHover,
      selectedBackground: colors.actionPrimary,
      selectedText: colors.actionPrimaryText,
      text: colors.text,
      disabledText: colors.textDisabled,
      destructiveText: colors.danger,
      focusRing: colors.focusRing,
      separatorColor: colors.border,
      backdropColor: colors.scrim,
      liftShadowColor: colors.scrim,
      radius: 8,
      borderWidth: 1,
      itemHeight: 44,
      itemPaddingHorizontal: 12,
      itemPaddingVertical: 0,
      iconGap: 10,
      iconSize: 18,
      checkmarkSize: 14,
      separatorThickness: 1,
      width: 220,
      minHeight: 80,
      maxHeight: 400,
      screenMargin: 16,
      previewWidth: 320,
      backdropBlurSigma: 12,
      backdropOpacity: 0.45,
      liftScaleDelta: 0.04,
      liftShadowOpacity: 0.25,
      liftShadowBlur: 16,
      liftShadowOffsetY: 8,
      menuScaleBegin: 0.9,
      modernPressedOverlayOpacity: 0.75,
      iosPressedOverlayOpacity: 0.12,
      iosHoverOverlayOpacity: 0.06,
    );
  }

  const VMenuTokens({
    required this.background,
    required this.border,
    required this.hoverBackground,
    required this.selectedBackground,
    required this.selectedText,
    required this.text,
    required this.disabledText,
    required this.destructiveText,
    required this.focusRing,
    required this.separatorColor,
    required this.backdropColor,
    required this.liftShadowColor,
    this.radius = 8,
    this.borderWidth = 1,
    this.itemHeight = 44,
    this.itemPaddingHorizontal = 12,
    this.itemPaddingVertical = 0,
    this.iconGap = 2,
    this.iconSize = 18,
    this.checkmarkSize = 14,
    this.separatorThickness = 1,
    this.width = 220,
    this.minHeight = 80,
    this.maxHeight = 400,
    this.screenMargin = 16,
    this.previewWidth = 320,
    this.backdropBlurSigma = 12,
    this.backdropOpacity = 0.45,
    this.liftScaleDelta = 0.04,
    this.liftShadowOpacity = 0.25,
    this.liftShadowBlur = 16,
    this.liftShadowOffsetY = 8,
    this.menuScaleBegin = 0.9,
    this.modernPressedOverlayOpacity = 0.75,
    this.iosPressedOverlayOpacity = 0.12,
    this.iosHoverOverlayOpacity = 0.06,
  });

  final Color background;
  final Color border;
  final Color hoverBackground;
  final Color selectedBackground;
  final Color selectedText;
  final Color text;
  final Color disabledText;
  final Color destructiveText;
  final Color focusRing;
  final Color separatorColor;
  final Color backdropColor;
  final Color liftShadowColor;
  final double radius;
  final double borderWidth;
  final double itemHeight;
  final double itemPaddingHorizontal;
  final double itemPaddingVertical;
  final double iconGap;
  final double iconSize;
  final double checkmarkSize;
  final double separatorThickness;
  final double width;
  final double minHeight;
  final double maxHeight;
  final double screenMargin;
  final double previewWidth;
  final double backdropBlurSigma;
  final double backdropOpacity;
  final double liftScaleDelta;
  final double liftShadowOpacity;
  final double liftShadowBlur;
  final double liftShadowOffsetY;
  final double menuScaleBegin;
  final double modernPressedOverlayOpacity;
  final double iosPressedOverlayOpacity;
  final double iosHoverOverlayOpacity;

  static VMenuTokens lerp(VMenuTokens a, VMenuTokens b, double t) {
    return VMenuTokens(
      background: lerpComponentTokenColor(a.background, b.background, t),
      border: lerpComponentTokenColor(a.border, b.border, t),
      hoverBackground:
          lerpComponentTokenColor(a.hoverBackground, b.hoverBackground, t),
      selectedBackground: lerpComponentTokenColor(
          a.selectedBackground, b.selectedBackground, t),
      selectedText: lerpComponentTokenColor(a.selectedText, b.selectedText, t),
      text: lerpComponentTokenColor(a.text, b.text, t),
      disabledText: lerpComponentTokenColor(a.disabledText, b.disabledText, t),
      destructiveText:
          lerpComponentTokenColor(a.destructiveText, b.destructiveText, t),
      focusRing: lerpComponentTokenColor(a.focusRing, b.focusRing, t),
      separatorColor:
          lerpComponentTokenColor(a.separatorColor, b.separatorColor, t),
      backdropColor:
          lerpComponentTokenColor(a.backdropColor, b.backdropColor, t),
      liftShadowColor:
          lerpComponentTokenColor(a.liftShadowColor, b.liftShadowColor, t),
      radius: lerpComponentTokenDouble(a.radius, b.radius, t),
      borderWidth: lerpComponentTokenDouble(a.borderWidth, b.borderWidth, t),
      itemHeight: lerpComponentTokenDouble(a.itemHeight, b.itemHeight, t),
      itemPaddingHorizontal: lerpComponentTokenDouble(
          a.itemPaddingHorizontal, b.itemPaddingHorizontal, t),
      itemPaddingVertical: lerpComponentTokenDouble(
          a.itemPaddingVertical, b.itemPaddingVertical, t),
      iconGap: lerpComponentTokenDouble(a.iconGap, b.iconGap, t),
      iconSize: lerpComponentTokenDouble(a.iconSize, b.iconSize, t),
      checkmarkSize:
          lerpComponentTokenDouble(a.checkmarkSize, b.checkmarkSize, t),
      separatorThickness: lerpComponentTokenDouble(
          a.separatorThickness, b.separatorThickness, t),
      width: lerpComponentTokenDouble(a.width, b.width, t),
      minHeight: lerpComponentTokenDouble(a.minHeight, b.minHeight, t),
      maxHeight: lerpComponentTokenDouble(a.maxHeight, b.maxHeight, t),
      screenMargin: lerpComponentTokenDouble(a.screenMargin, b.screenMargin, t),
      previewWidth: lerpComponentTokenDouble(a.previewWidth, b.previewWidth, t),
      backdropBlurSigma:
          lerpComponentTokenDouble(a.backdropBlurSigma, b.backdropBlurSigma, t),
      backdropOpacity:
          lerpComponentTokenDouble(a.backdropOpacity, b.backdropOpacity, t),
      liftScaleDelta:
          lerpComponentTokenDouble(a.liftScaleDelta, b.liftScaleDelta, t),
      liftShadowOpacity:
          lerpComponentTokenDouble(a.liftShadowOpacity, b.liftShadowOpacity, t),
      liftShadowBlur:
          lerpComponentTokenDouble(a.liftShadowBlur, b.liftShadowBlur, t),
      liftShadowOffsetY:
          lerpComponentTokenDouble(a.liftShadowOffsetY, b.liftShadowOffsetY, t),
      menuScaleBegin:
          lerpComponentTokenDouble(a.menuScaleBegin, b.menuScaleBegin, t),
      modernPressedOverlayOpacity: lerpComponentTokenDouble(
        a.modernPressedOverlayOpacity,
        b.modernPressedOverlayOpacity,
        t,
      ),
      iosPressedOverlayOpacity: lerpComponentTokenDouble(
        a.iosPressedOverlayOpacity,
        b.iosPressedOverlayOpacity,
        t,
      ),
      iosHoverOverlayOpacity: lerpComponentTokenDouble(
          a.iosHoverOverlayOpacity, b.iosHoverOverlayOpacity, t),
    );
  }

  VMenuTokens copyWith({
    Color? background,
    Color? border,
    Color? hoverBackground,
    Color? selectedBackground,
    Color? selectedText,
    Color? text,
    Color? disabledText,
    Color? destructiveText,
    Color? focusRing,
    Color? separatorColor,
    Color? backdropColor,
    Color? liftShadowColor,
    double? radius,
    double? borderWidth,
    double? itemHeight,
    double? itemPaddingHorizontal,
    double? itemPaddingVertical,
    double? iconGap,
    double? iconSize,
    double? checkmarkSize,
    double? separatorThickness,
    double? width,
    double? minHeight,
    double? maxHeight,
    double? screenMargin,
    double? previewWidth,
    double? backdropBlurSigma,
    double? backdropOpacity,
    double? liftScaleDelta,
    double? liftShadowOpacity,
    double? liftShadowBlur,
    double? liftShadowOffsetY,
    double? menuScaleBegin,
    double? modernPressedOverlayOpacity,
    double? iosPressedOverlayOpacity,
    double? iosHoverOverlayOpacity,
  }) {
    return VMenuTokens(
      background: background ?? this.background,
      border: border ?? this.border,
      hoverBackground: hoverBackground ?? this.hoverBackground,
      selectedBackground: selectedBackground ?? this.selectedBackground,
      selectedText: selectedText ?? this.selectedText,
      text: text ?? this.text,
      disabledText: disabledText ?? this.disabledText,
      destructiveText: destructiveText ?? this.destructiveText,
      focusRing: focusRing ?? this.focusRing,
      separatorColor: separatorColor ?? this.separatorColor,
      backdropColor: backdropColor ?? this.backdropColor,
      liftShadowColor: liftShadowColor ?? this.liftShadowColor,
      radius: radius ?? this.radius,
      borderWidth: borderWidth ?? this.borderWidth,
      itemHeight: itemHeight ?? this.itemHeight,
      itemPaddingHorizontal:
          itemPaddingHorizontal ?? this.itemPaddingHorizontal,
      itemPaddingVertical: itemPaddingVertical ?? this.itemPaddingVertical,
      iconGap: iconGap ?? this.iconGap,
      iconSize: iconSize ?? this.iconSize,
      checkmarkSize: checkmarkSize ?? this.checkmarkSize,
      separatorThickness: separatorThickness ?? this.separatorThickness,
      width: width ?? this.width,
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
      screenMargin: screenMargin ?? this.screenMargin,
      previewWidth: previewWidth ?? this.previewWidth,
      backdropBlurSigma: backdropBlurSigma ?? this.backdropBlurSigma,
      backdropOpacity: backdropOpacity ?? this.backdropOpacity,
      liftScaleDelta: liftScaleDelta ?? this.liftScaleDelta,
      liftShadowOpacity: liftShadowOpacity ?? this.liftShadowOpacity,
      liftShadowBlur: liftShadowBlur ?? this.liftShadowBlur,
      liftShadowOffsetY: liftShadowOffsetY ?? this.liftShadowOffsetY,
      menuScaleBegin: menuScaleBegin ?? this.menuScaleBegin,
      modernPressedOverlayOpacity:
          modernPressedOverlayOpacity ?? this.modernPressedOverlayOpacity,
      iosPressedOverlayOpacity:
          iosPressedOverlayOpacity ?? this.iosPressedOverlayOpacity,
      iosHoverOverlayOpacity:
          iosHoverOverlayOpacity ?? this.iosHoverOverlayOpacity,
    );
  }
}
