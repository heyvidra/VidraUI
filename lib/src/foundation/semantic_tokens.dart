import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'primitive_tokens.dart';
import 'shadows.dart';

part 'v_colors.g.dart';

/// Semantic color roles — product-level meaning without component names.
///
/// Widgets should consume these, or component tokens derived from these.
/// Direct primitive token usage in widget code is discouraged.
@immutable
class VColors with Diagnosticable {
  factory VColors.light() {
    return const VColors(
      background: VPrimitiveColors.gray50,
      surface: VPrimitiveColors.white,
      surfaceElevated: VPrimitiveColors.gray100,
      surfaceHover: VPrimitiveColors.gray100,
      surfaceLevel0: VPrimitiveColors.gray50,
      surfaceLevel1: VPrimitiveColors.white,
      surfaceLevel2: VPrimitiveColors.white,
      surfaceLevel3: VPrimitiveColors.white,
      surfaceLevel4: VPrimitiveColors.white,
      text: VPrimitiveColors.gray950,
      textMuted: VPrimitiveColors.gray500,
      textDisabled: VPrimitiveColors.gray400,
      border: VPrimitiveColors.gray200,
      borderStrong: VPrimitiveColors.gray400,
      actionPrimary: VPrimitiveColors.blue600,
      actionPrimaryHover: VPrimitiveColors.blue700,
      actionPrimaryPressed: VPrimitiveColors.blue800,
      actionPrimaryText: VPrimitiveColors.white,
      danger: VPrimitiveColors.red500,
      dangerHover: VPrimitiveColors.red600,
      dangerSurface: VPrimitiveColors.red50,
      success: VPrimitiveColors.green600,
      successHover: VPrimitiveColors.green700,
      successSurface: VPrimitiveColors.green50,
      warning: VPrimitiveColors.amber600,
      warningHover: VPrimitiveColors.amber700,
      warningSurface: VPrimitiveColors.amber50,
      focusRing: VPrimitiveColors.blue500,
      scrim: VPrimitiveColors.black,
    );
  }

  factory VColors.dark() {
    return const VColors(
      background: VPrimitiveColors.gray950,
      surface: VPrimitiveColors.gray900,
      surfaceElevated: VPrimitiveColors.gray800,
      surfaceHover: VPrimitiveColors.gray700,
      surfaceLevel0: VPrimitiveColors.gray950,
      surfaceLevel1: VPrimitiveColors.gray900,
      surfaceLevel2: VPrimitiveColors.gray800,
      surfaceLevel3: VPrimitiveColors.gray700,
      surfaceLevel4: VPrimitiveColors.gray600,
      text: VPrimitiveColors.gray50,
      textMuted: VPrimitiveColors.gray400,
      textDisabled: VPrimitiveColors.gray500,
      border: VPrimitiveColors.gray600,
      borderStrong: VPrimitiveColors.gray700,
      actionPrimary: VPrimitiveColors.blue500,
      actionPrimaryHover: VPrimitiveColors.blue400,
      actionPrimaryPressed: VPrimitiveColors.blue700,
      actionPrimaryText: VPrimitiveColors.white,
      danger: VPrimitiveColors.red300,
      dangerHover: VPrimitiveColors.red200,
      dangerSurface: VPrimitiveColors.red950,
      success: VPrimitiveColors.green400,
      successHover: VPrimitiveColors.green500,
      successSurface: VPrimitiveColors.green950,
      warning: VPrimitiveColors.amber400,
      warningHover: VPrimitiveColors.amber300,
      warningSurface: VPrimitiveColors.amber950,
      focusRing: VPrimitiveColors.blue400,
      scrim: VPrimitiveColors.black,
    );
  }

  const VColors({
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.surfaceHover,
    required this.surfaceLevel0,
    required this.surfaceLevel1,
    required this.surfaceLevel2,
    required this.surfaceLevel3,
    required this.surfaceLevel4,
    required this.text,
    required this.textMuted,
    required this.textDisabled,
    required this.border,
    required this.borderStrong,
    required this.actionPrimary,
    required this.actionPrimaryHover,
    required this.actionPrimaryPressed,
    required this.actionPrimaryText,
    required this.danger,
    required this.dangerHover,
    required this.dangerSurface,
    required this.success,
    required this.successHover,
    required this.successSurface,
    required this.warning,
    required this.warningHover,
    required this.warningSurface,
    required this.focusRing,
    required this.scrim,
  });

  final Color background;
  final Color surface;
  final Color surfaceElevated;
  final Color surfaceHover;

  /// Tonal surface colors mapped to [VElevation] levels.
  final Color surfaceLevel0;
  final Color surfaceLevel1;
  final Color surfaceLevel2;
  final Color surfaceLevel3;
  final Color surfaceLevel4;

  final Color text;
  final Color textMuted;
  final Color textDisabled;

  final Color border;
  final Color borderStrong;

  final Color actionPrimary;
  final Color actionPrimaryHover;
  final Color actionPrimaryPressed;
  final Color actionPrimaryText;

  final Color danger;
  final Color dangerHover;
  final Color dangerSurface;

  final Color success;
  final Color successHover;
  final Color successSurface;

  final Color warning;

  /// Hover-state color for warning-tinted controls.
  final Color warningHover;

  /// Background color for warning-tinted surface areas.
  final Color warningSurface;

  final Color focusRing;

  /// Opaque base color for scrims, modal barriers, and elevation shadows.
  ///
  /// Consumers modulate alpha via [Color.withValues] or a `FadeTransition`.
  final Color scrim;

  /// Resolves the surface color for a given [elevation].
  Color surfaceColor(VElevation elevation) {
    return switch (elevation) {
      VElevation.level0 => surfaceLevel0,
      VElevation.level1 => surfaceLevel1,
      VElevation.level2 => surfaceLevel2,
      VElevation.level3 => surfaceLevel3,
      VElevation.level4 => surfaceLevel4,
    };
  }

  /// Linearly interpolate between two [VColors] instances.
  ///
  /// Every field is interpolated via [Color.lerp].
  static VColors lerp(VColors a, VColors b, double t) =>
      _$VColorsLerp(a, b, t);

  VColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceElevated,
    Color? surfaceHover,
    Color? surfaceLevel0,
    Color? surfaceLevel1,
    Color? surfaceLevel2,
    Color? surfaceLevel3,
    Color? surfaceLevel4,
    Color? text,
    Color? textMuted,
    Color? textDisabled,
    Color? border,
    Color? borderStrong,
    Color? actionPrimary,
    Color? actionPrimaryHover,
    Color? actionPrimaryPressed,
    Color? actionPrimaryText,
    Color? danger,
    Color? dangerHover,
    Color? dangerSurface,
    Color? success,
    Color? successHover,
    Color? successSurface,
    Color? warning,
    Color? warningHover,
    Color? warningSurface,
    Color? focusRing,
    Color? scrim,
  }) =>
      _$VColorsCopyWith(this,
          background: background,
          surface: surface,
          surfaceElevated: surfaceElevated,
          surfaceHover: surfaceHover,
          surfaceLevel0: surfaceLevel0,
          surfaceLevel1: surfaceLevel1,
          surfaceLevel2: surfaceLevel2,
          surfaceLevel3: surfaceLevel3,
          surfaceLevel4: surfaceLevel4,
          text: text,
          textMuted: textMuted,
          textDisabled: textDisabled,
          border: border,
          borderStrong: borderStrong,
          actionPrimary: actionPrimary,
          actionPrimaryHover: actionPrimaryHover,
          actionPrimaryPressed: actionPrimaryPressed,
          actionPrimaryText: actionPrimaryText,
          danger: danger,
          dangerHover: dangerHover,
          dangerSurface: dangerSurface,
          success: success,
          successHover: successHover,
          successSurface: successSurface,
          warning: warning,
          warningHover: warningHover,
          warningSurface: warningSurface,
          focusRing: focusRing,
          scrim: scrim,
      );

  @override
  bool operator ==(Object other) => _$VColorsEq(this, other);

  @override
  int get hashCode => _$VColorsHash(this);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    _$VColorsFillProperties(this, properties);
  }
}
