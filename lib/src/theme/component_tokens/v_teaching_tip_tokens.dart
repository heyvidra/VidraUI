import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

// ---------------------------------------------------------------------------
// VTeachingTipTokens
// ---------------------------------------------------------------------------

/// Component-level tokens for [VTeachingTip].
@immutable
class VTeachingTipTokens {
  factory VTeachingTipTokens.fromColors(VColors colors) {
    return VTeachingTipTokens(
      background: colors.surface,
      border: colors.border,
      radius: 12.0,
      titleColor: colors.text,
      subtitleColor: colors.textMuted,
      arrowSize: 8.0,
      gap: 12.0,
      surfaceWidth: 300.0,
      margin: 12.0,
      closeButtonSize: 24.0,
      titleSubtitleGap: 8.0,
      contentActionGap: 16.0,
      actionButtonGap: 8.0,
      padding: const EdgeInsets.all(16.0),
      illustrationHeight: 120.0,
      estimatedSubtitleHeightIllustration: 56.0,
      estimatedSubtitleHeightNormal: 44.0,
      estimatedActionsHeight: 56.0,
    );
  }

  const VTeachingTipTokens({
    this.background = const Color(0xFFFEFBFF),
    this.border = const Color(0xFFE5E7EB),
    this.radius = 12.0,
    this.titleColor = const Color(0xFF111827),
    this.subtitleColor = const Color(0xFF6B7280),
    this.arrowSize = 8.0,
    this.gap = 12.0,
    this.surfaceWidth = 300.0,
    this.margin = 12.0,
    this.closeButtonSize = 24.0,
    this.titleSubtitleGap = 8.0,
    this.contentActionGap = 16.0,
    this.actionButtonGap = 8.0,
    this.padding = const EdgeInsets.all(16.0),
    this.illustrationHeight = 120.0,
    this.estimatedSubtitleHeightIllustration = 56.0,
    this.estimatedSubtitleHeightNormal = 44.0,
    this.estimatedActionsHeight = 56.0,
  });

  final Color background;
  final Color border;
  final double radius;
  final Color titleColor;
  final Color subtitleColor;
  final double arrowSize;
  final double gap;
  final double surfaceWidth;
  final double margin;
  final double closeButtonSize;
  final double titleSubtitleGap;
  final double contentActionGap;
  final double actionButtonGap;
  final EdgeInsetsGeometry padding;
  final double illustrationHeight;
  final double estimatedSubtitleHeightIllustration;
  final double estimatedSubtitleHeightNormal;
  final double estimatedActionsHeight;

  static VTeachingTipTokens lerp(
    VTeachingTipTokens a,
    VTeachingTipTokens b,
    double t,
  ) {
    return VTeachingTipTokens(
      background: lerpComponentTokenColor(a.background, b.background, t),
      border: lerpComponentTokenColor(a.border, b.border, t),
      radius: lerpComponentTokenDouble(a.radius, b.radius, t),
      titleColor: lerpComponentTokenColor(a.titleColor, b.titleColor, t),
      subtitleColor:
          lerpComponentTokenColor(a.subtitleColor, b.subtitleColor, t),
      arrowSize: lerpComponentTokenDouble(a.arrowSize, b.arrowSize, t),
      gap: lerpComponentTokenDouble(a.gap, b.gap, t),
      surfaceWidth: lerpComponentTokenDouble(a.surfaceWidth, b.surfaceWidth, t),
      margin: lerpComponentTokenDouble(a.margin, b.margin, t),
      closeButtonSize:
          lerpComponentTokenDouble(a.closeButtonSize, b.closeButtonSize, t),
      titleSubtitleGap:
          lerpComponentTokenDouble(a.titleSubtitleGap, b.titleSubtitleGap, t),
      contentActionGap:
          lerpComponentTokenDouble(a.contentActionGap, b.contentActionGap, t),
      actionButtonGap:
          lerpComponentTokenDouble(a.actionButtonGap, b.actionButtonGap, t),
      padding: t < 0.5 ? a.padding : b.padding,
      illustrationHeight:
          lerpComponentTokenDouble(a.illustrationHeight, b.illustrationHeight, t),
      estimatedSubtitleHeightIllustration:
          lerpComponentTokenDouble(a.estimatedSubtitleHeightIllustration, b.estimatedSubtitleHeightIllustration, t),
      estimatedSubtitleHeightNormal:
          lerpComponentTokenDouble(a.estimatedSubtitleHeightNormal, b.estimatedSubtitleHeightNormal, t),
      estimatedActionsHeight:
          lerpComponentTokenDouble(a.estimatedActionsHeight, b.estimatedActionsHeight, t),
    );
  }

  VTeachingTipTokens copyWith({
    Color? background,
    Color? border,
    double? radius,
    Color? titleColor,
    Color? subtitleColor,
    double? arrowSize,
    double? gap,
    double? surfaceWidth,
    double? margin,
    double? closeButtonSize,
    double? titleSubtitleGap,
    double? contentActionGap,
    double? actionButtonGap,
    EdgeInsetsGeometry? padding,
    double? illustrationHeight,
    double? estimatedSubtitleHeightIllustration,
    double? estimatedSubtitleHeightNormal,
    double? estimatedActionsHeight,
  }) {
    return VTeachingTipTokens(
      background: background ?? this.background,
      border: border ?? this.border,
      radius: radius ?? this.radius,
      titleColor: titleColor ?? this.titleColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      arrowSize: arrowSize ?? this.arrowSize,
      gap: gap ?? this.gap,
      surfaceWidth: surfaceWidth ?? this.surfaceWidth,
      margin: margin ?? this.margin,
      closeButtonSize: closeButtonSize ?? this.closeButtonSize,
      titleSubtitleGap: titleSubtitleGap ?? this.titleSubtitleGap,
      contentActionGap: contentActionGap ?? this.contentActionGap,
      actionButtonGap: actionButtonGap ?? this.actionButtonGap,
      padding: padding ?? this.padding,
      illustrationHeight: illustrationHeight ?? this.illustrationHeight,
      estimatedSubtitleHeightIllustration: estimatedSubtitleHeightIllustration ?? this.estimatedSubtitleHeightIllustration,
      estimatedSubtitleHeightNormal: estimatedSubtitleHeightNormal ?? this.estimatedSubtitleHeightNormal,
      estimatedActionsHeight: estimatedActionsHeight ?? this.estimatedActionsHeight,
    );
  }
}
