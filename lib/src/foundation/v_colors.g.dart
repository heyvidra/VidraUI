// GENERATED CODE — DO NOT EDIT.
//
// Regenerate with:
//   dart run scripts/generate_foundation_tokens.dart
//
// Registry: scripts/foundation_token_registry.dart

// coverage:ignore-file

part of 'semantic_tokens.dart';

VColors _$VColorsLerp(
  VColors a,
  VColors b,
  double t,
) {
  return VColors(
    background: Color.lerp(a.background, b.background, t)!,
    surface: Color.lerp(a.surface, b.surface, t)!,
    surfaceElevated: Color.lerp(a.surfaceElevated, b.surfaceElevated, t)!,
    surfaceHover: Color.lerp(a.surfaceHover, b.surfaceHover, t)!,
    surfaceLevel0: Color.lerp(a.surfaceLevel0, b.surfaceLevel0, t)!,
    surfaceLevel1: Color.lerp(a.surfaceLevel1, b.surfaceLevel1, t)!,
    surfaceLevel2: Color.lerp(a.surfaceLevel2, b.surfaceLevel2, t)!,
    surfaceLevel3: Color.lerp(a.surfaceLevel3, b.surfaceLevel3, t)!,
    surfaceLevel4: Color.lerp(a.surfaceLevel4, b.surfaceLevel4, t)!,
    text: Color.lerp(a.text, b.text, t)!,
    textMuted: Color.lerp(a.textMuted, b.textMuted, t)!,
    textDisabled: Color.lerp(a.textDisabled, b.textDisabled, t)!,
    border: Color.lerp(a.border, b.border, t)!,
    borderStrong: Color.lerp(a.borderStrong, b.borderStrong, t)!,
    actionPrimary: Color.lerp(a.actionPrimary, b.actionPrimary, t)!,
    actionPrimaryHover: Color.lerp(a.actionPrimaryHover, b.actionPrimaryHover, t)!,
    actionPrimaryPressed: Color.lerp(a.actionPrimaryPressed, b.actionPrimaryPressed, t)!,
    actionPrimaryText: Color.lerp(a.actionPrimaryText, b.actionPrimaryText, t)!,
    danger: Color.lerp(a.danger, b.danger, t)!,
    dangerHover: Color.lerp(a.dangerHover, b.dangerHover, t)!,
    dangerSurface: Color.lerp(a.dangerSurface, b.dangerSurface, t)!,
    success: Color.lerp(a.success, b.success, t)!,
    successHover: Color.lerp(a.successHover, b.successHover, t)!,
    successSurface: Color.lerp(a.successSurface, b.successSurface, t)!,
    warning: Color.lerp(a.warning, b.warning, t)!,
    warningHover: Color.lerp(a.warningHover, b.warningHover, t)!,
    warningSurface: Color.lerp(a.warningSurface, b.warningSurface, t)!,
    focusRing: Color.lerp(a.focusRing, b.focusRing, t)!,
    scrim: Color.lerp(a.scrim, b.scrim, t)!,
  );
}

VColors _$VColorsCopyWith(
  VColors self, {
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
}) {
  return VColors(
    background: background ?? self.background,
    surface: surface ?? self.surface,
    surfaceElevated: surfaceElevated ?? self.surfaceElevated,
    surfaceHover: surfaceHover ?? self.surfaceHover,
    surfaceLevel0: surfaceLevel0 ?? self.surfaceLevel0,
    surfaceLevel1: surfaceLevel1 ?? self.surfaceLevel1,
    surfaceLevel2: surfaceLevel2 ?? self.surfaceLevel2,
    surfaceLevel3: surfaceLevel3 ?? self.surfaceLevel3,
    surfaceLevel4: surfaceLevel4 ?? self.surfaceLevel4,
    text: text ?? self.text,
    textMuted: textMuted ?? self.textMuted,
    textDisabled: textDisabled ?? self.textDisabled,
    border: border ?? self.border,
    borderStrong: borderStrong ?? self.borderStrong,
    actionPrimary: actionPrimary ?? self.actionPrimary,
    actionPrimaryHover: actionPrimaryHover ?? self.actionPrimaryHover,
    actionPrimaryPressed: actionPrimaryPressed ?? self.actionPrimaryPressed,
    actionPrimaryText: actionPrimaryText ?? self.actionPrimaryText,
    danger: danger ?? self.danger,
    dangerHover: dangerHover ?? self.dangerHover,
    dangerSurface: dangerSurface ?? self.dangerSurface,
    success: success ?? self.success,
    successHover: successHover ?? self.successHover,
    successSurface: successSurface ?? self.successSurface,
    warning: warning ?? self.warning,
    warningHover: warningHover ?? self.warningHover,
    warningSurface: warningSurface ?? self.warningSurface,
    focusRing: focusRing ?? self.focusRing,
    scrim: scrim ?? self.scrim,
  );
}

bool _$VColorsEq(VColors a, Object other) {
  if (identical(a, other)) return true;
  return other is VColors
    && a.background == other.background
    && a.surface == other.surface
    && a.surfaceElevated == other.surfaceElevated
    && a.surfaceHover == other.surfaceHover
    && a.surfaceLevel0 == other.surfaceLevel0
    && a.surfaceLevel1 == other.surfaceLevel1
    && a.surfaceLevel2 == other.surfaceLevel2
    && a.surfaceLevel3 == other.surfaceLevel3
    && a.surfaceLevel4 == other.surfaceLevel4
    && a.text == other.text
    && a.textMuted == other.textMuted
    && a.textDisabled == other.textDisabled
    && a.border == other.border
    && a.borderStrong == other.borderStrong
    && a.actionPrimary == other.actionPrimary
    && a.actionPrimaryHover == other.actionPrimaryHover
    && a.actionPrimaryPressed == other.actionPrimaryPressed
    && a.actionPrimaryText == other.actionPrimaryText
    && a.danger == other.danger
    && a.dangerHover == other.dangerHover
    && a.dangerSurface == other.dangerSurface
    && a.success == other.success
    && a.successHover == other.successHover
    && a.successSurface == other.successSurface
    && a.warning == other.warning
    && a.warningHover == other.warningHover
    && a.warningSurface == other.warningSurface
    && a.focusRing == other.focusRing
    && a.scrim == other.scrim
    ;
}

int _$VColorsHash(VColors self) => Object.hashAll([
  self.background,
  self.surface,
  self.surfaceElevated,
  self.surfaceHover,
  self.surfaceLevel0,
  self.surfaceLevel1,
  self.surfaceLevel2,
  self.surfaceLevel3,
  self.surfaceLevel4,
  self.text,
  self.textMuted,
  self.textDisabled,
  self.border,
  self.borderStrong,
  self.actionPrimary,
  self.actionPrimaryHover,
  self.actionPrimaryPressed,
  self.actionPrimaryText,
  self.danger,
  self.dangerHover,
  self.dangerSurface,
  self.success,
  self.successHover,
  self.successSurface,
  self.warning,
  self.warningHover,
  self.warningSurface,
  self.focusRing,
  self.scrim,
]);

void _$VColorsFillProperties(
  VColors self,
  DiagnosticPropertiesBuilder properties,
) {
  properties.add(DiagnosticsProperty<Color>('background', self.background));
  properties.add(DiagnosticsProperty<Color>('surface', self.surface));
  properties.add(DiagnosticsProperty<Color>('surfaceElevated', self.surfaceElevated));
  properties.add(DiagnosticsProperty<Color>('surfaceHover', self.surfaceHover));
  properties.add(DiagnosticsProperty<Color>('surfaceLevel0', self.surfaceLevel0));
  properties.add(DiagnosticsProperty<Color>('surfaceLevel1', self.surfaceLevel1));
  properties.add(DiagnosticsProperty<Color>('surfaceLevel2', self.surfaceLevel2));
  properties.add(DiagnosticsProperty<Color>('surfaceLevel3', self.surfaceLevel3));
  properties.add(DiagnosticsProperty<Color>('surfaceLevel4', self.surfaceLevel4));
  properties.add(DiagnosticsProperty<Color>('text', self.text));
  properties.add(DiagnosticsProperty<Color>('textMuted', self.textMuted));
  properties.add(DiagnosticsProperty<Color>('textDisabled', self.textDisabled));
  properties.add(DiagnosticsProperty<Color>('border', self.border));
  properties.add(DiagnosticsProperty<Color>('borderStrong', self.borderStrong));
  properties.add(DiagnosticsProperty<Color>('actionPrimary', self.actionPrimary));
  properties.add(DiagnosticsProperty<Color>('actionPrimaryHover', self.actionPrimaryHover));
  properties.add(DiagnosticsProperty<Color>('actionPrimaryPressed', self.actionPrimaryPressed));
  properties.add(DiagnosticsProperty<Color>('actionPrimaryText', self.actionPrimaryText));
  properties.add(DiagnosticsProperty<Color>('danger', self.danger));
  properties.add(DiagnosticsProperty<Color>('dangerHover', self.dangerHover));
  properties.add(DiagnosticsProperty<Color>('dangerSurface', self.dangerSurface));
  properties.add(DiagnosticsProperty<Color>('success', self.success));
  properties.add(DiagnosticsProperty<Color>('successHover', self.successHover));
  properties.add(DiagnosticsProperty<Color>('successSurface', self.successSurface));
  properties.add(DiagnosticsProperty<Color>('warning', self.warning));
  properties.add(DiagnosticsProperty<Color>('warningHover', self.warningHover));
  properties.add(DiagnosticsProperty<Color>('warningSurface', self.warningSurface));
  properties.add(DiagnosticsProperty<Color>('focusRing', self.focusRing));
  properties.add(DiagnosticsProperty<Color>('scrim', self.scrim));
}

