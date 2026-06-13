import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for app bar.
@immutable
class VAppBarTokens {
  factory VAppBarTokens.fromColors(VColors colors) {
    return VAppBarTokens(
      height: 56,
      expandedHeight: 200,
      leadingWidth: 56,
      horizontalPadding: 16,
      actionGap: 8,
      bottomSpacing: 8,
      background: colors.surface,
      foreground: colors.text,
      border: colors.border,
      shadow: const BoxShadow(
        color: Color(0x0A000000),
        blurRadius: 4,
        offset: Offset(0, 1),
      ),
      elevatedShadow: const BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    );
  }

  const VAppBarTokens({
    required this.height,
    required this.expandedHeight,
    required this.leadingWidth,
    required this.horizontalPadding,
    required this.actionGap,
    required this.bottomSpacing,
    required this.background,
    required this.foreground,
    required this.border,
    required this.shadow,
    required this.elevatedShadow,
  });

  final double height;
  final double expandedHeight;
  final double leadingWidth;
  final double horizontalPadding;
  final double actionGap;
  final double bottomSpacing;
  final Color background;
  final Color foreground;
  final Color border;
  final BoxShadow? shadow;
  final BoxShadow? elevatedShadow;

  static VAppBarTokens lerp(VAppBarTokens a, VAppBarTokens b, double t) {
    return VAppBarTokens(
      height: lerpComponentTokenDouble(a.height, b.height, t),
      expandedHeight:
          lerpComponentTokenDouble(a.expandedHeight, b.expandedHeight, t),
      leadingWidth: lerpComponentTokenDouble(a.leadingWidth, b.leadingWidth, t),
      horizontalPadding:
          lerpComponentTokenDouble(a.horizontalPadding, b.horizontalPadding, t),
      actionGap: lerpComponentTokenDouble(a.actionGap, b.actionGap, t),
      bottomSpacing:
          lerpComponentTokenDouble(a.bottomSpacing, b.bottomSpacing, t),
      background: lerpComponentTokenColor(a.background, b.background, t),
      foreground: lerpComponentTokenColor(a.foreground, b.foreground, t),
      border: lerpComponentTokenColor(a.border, b.border, t),
      shadow: BoxShadow.lerp(a.shadow, b.shadow, t),
      elevatedShadow: BoxShadow.lerp(a.elevatedShadow, b.elevatedShadow, t),
    );
  }

  VAppBarTokens copyWith({
    double? height,
    double? expandedHeight,
    double? leadingWidth,
    double? horizontalPadding,
    double? actionGap,
    double? bottomSpacing,
    Color? background,
    Color? foreground,
    Color? border,
    BoxShadow? shadow,
    BoxShadow? elevatedShadow,
  }) {
    return VAppBarTokens(
      height: height ?? this.height,
      expandedHeight: expandedHeight ?? this.expandedHeight,
      leadingWidth: leadingWidth ?? this.leadingWidth,
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      actionGap: actionGap ?? this.actionGap,
      bottomSpacing: bottomSpacing ?? this.bottomSpacing,
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
      elevatedShadow: elevatedShadow ?? this.elevatedShadow,
    );
  }
}
