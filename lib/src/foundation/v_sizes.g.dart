// GENERATED CODE — DO NOT EDIT.
//
// Regenerate with:
//   dart run scripts/generate_foundation_tokens.dart
//
// Registry: scripts/foundation_token_registry.dart

// coverage:ignore-file

part of 'sizes.dart';

VSizes _$VSizesLerp(
  VSizes a,
  VSizes b,
  double t,
) {
  return VSizes(
    controlSm: a.controlSm + (b.controlSm - a.controlSm) * t,
    controlMd: a.controlMd + (b.controlMd - a.controlMd) * t,
    controlLg: a.controlLg + (b.controlLg - a.controlLg) * t,
    iconSm: a.iconSm + (b.iconSm - a.iconSm) * t,
    iconMd: a.iconMd + (b.iconMd - a.iconMd) * t,
    iconLg: a.iconLg + (b.iconLg - a.iconLg) * t,
    avatarSm: a.avatarSm + (b.avatarSm - a.avatarSm) * t,
    avatarMd: a.avatarMd + (b.avatarMd - a.avatarMd) * t,
    avatarLg: a.avatarLg + (b.avatarLg - a.avatarLg) * t,
    switchWidth: a.switchWidth + (b.switchWidth - a.switchWidth) * t,
    switchHeight: a.switchHeight + (b.switchHeight - a.switchHeight) * t,
    switchThumb: a.switchThumb + (b.switchThumb - a.switchThumb) * t,
    sliderThumb: a.sliderThumb + (b.sliderThumb - a.sliderThumb) * t,
    sliderTrack: a.sliderTrack + (b.sliderTrack - a.sliderTrack) * t,
    dialogMaxWidth: a.dialogMaxWidth + (b.dialogMaxWidth - a.dialogMaxWidth) * t,
    checkboxSize: a.checkboxSize + (b.checkboxSize - a.checkboxSize) * t,
    radioSize: a.radioSize + (b.radioSize - a.radioSize) * t,
    borderThin: a.borderThin + (b.borderThin - a.borderThin) * t,
    borderThick: a.borderThick + (b.borderThick - a.borderThick) * t,
    buttonPaddingHorizontalSm: a.buttonPaddingHorizontalSm + (b.buttonPaddingHorizontalSm - a.buttonPaddingHorizontalSm) * t,
    buttonPaddingHorizontalMd: a.buttonPaddingHorizontalMd + (b.buttonPaddingHorizontalMd - a.buttonPaddingHorizontalMd) * t,
    buttonPaddingHorizontalLg: a.buttonPaddingHorizontalLg + (b.buttonPaddingHorizontalLg - a.buttonPaddingHorizontalLg) * t,
    buttonPaddingVerticalSm: a.buttonPaddingVerticalSm + (b.buttonPaddingVerticalSm - a.buttonPaddingVerticalSm) * t,
    buttonPaddingVerticalMd: a.buttonPaddingVerticalMd + (b.buttonPaddingVerticalMd - a.buttonPaddingVerticalMd) * t,
    buttonPaddingVerticalLg: a.buttonPaddingVerticalLg + (b.buttonPaddingVerticalLg - a.buttonPaddingVerticalLg) * t,
  );
}

VSizes _$VSizesCopyWith(
  VSizes self, {
  double? controlSm,
  double? controlMd,
  double? controlLg,
  double? iconSm,
  double? iconMd,
  double? iconLg,
  double? avatarSm,
  double? avatarMd,
  double? avatarLg,
  double? switchWidth,
  double? switchHeight,
  double? switchThumb,
  double? sliderThumb,
  double? sliderTrack,
  double? dialogMaxWidth,
  double? checkboxSize,
  double? radioSize,
  double? borderThin,
  double? borderThick,
  double? buttonPaddingHorizontalSm,
  double? buttonPaddingHorizontalMd,
  double? buttonPaddingHorizontalLg,
  double? buttonPaddingVerticalSm,
  double? buttonPaddingVerticalMd,
  double? buttonPaddingVerticalLg,
}) {
  return VSizes(
    controlSm: controlSm ?? self.controlSm,
    controlMd: controlMd ?? self.controlMd,
    controlLg: controlLg ?? self.controlLg,
    iconSm: iconSm ?? self.iconSm,
    iconMd: iconMd ?? self.iconMd,
    iconLg: iconLg ?? self.iconLg,
    avatarSm: avatarSm ?? self.avatarSm,
    avatarMd: avatarMd ?? self.avatarMd,
    avatarLg: avatarLg ?? self.avatarLg,
    switchWidth: switchWidth ?? self.switchWidth,
    switchHeight: switchHeight ?? self.switchHeight,
    switchThumb: switchThumb ?? self.switchThumb,
    sliderThumb: sliderThumb ?? self.sliderThumb,
    sliderTrack: sliderTrack ?? self.sliderTrack,
    dialogMaxWidth: dialogMaxWidth ?? self.dialogMaxWidth,
    checkboxSize: checkboxSize ?? self.checkboxSize,
    radioSize: radioSize ?? self.radioSize,
    borderThin: borderThin ?? self.borderThin,
    borderThick: borderThick ?? self.borderThick,
    buttonPaddingHorizontalSm: buttonPaddingHorizontalSm ?? self.buttonPaddingHorizontalSm,
    buttonPaddingHorizontalMd: buttonPaddingHorizontalMd ?? self.buttonPaddingHorizontalMd,
    buttonPaddingHorizontalLg: buttonPaddingHorizontalLg ?? self.buttonPaddingHorizontalLg,
    buttonPaddingVerticalSm: buttonPaddingVerticalSm ?? self.buttonPaddingVerticalSm,
    buttonPaddingVerticalMd: buttonPaddingVerticalMd ?? self.buttonPaddingVerticalMd,
    buttonPaddingVerticalLg: buttonPaddingVerticalLg ?? self.buttonPaddingVerticalLg,
  );
}

bool _$VSizesEq(VSizes a, Object other) {
  if (identical(a, other)) return true;
  return other is VSizes
    && a.controlSm == other.controlSm
    && a.controlMd == other.controlMd
    && a.controlLg == other.controlLg
    && a.iconSm == other.iconSm
    && a.iconMd == other.iconMd
    && a.iconLg == other.iconLg
    && a.avatarSm == other.avatarSm
    && a.avatarMd == other.avatarMd
    && a.avatarLg == other.avatarLg
    && a.switchWidth == other.switchWidth
    && a.switchHeight == other.switchHeight
    && a.switchThumb == other.switchThumb
    && a.sliderThumb == other.sliderThumb
    && a.sliderTrack == other.sliderTrack
    && a.dialogMaxWidth == other.dialogMaxWidth
    && a.checkboxSize == other.checkboxSize
    && a.radioSize == other.radioSize
    && a.borderThin == other.borderThin
    && a.borderThick == other.borderThick
    && a.buttonPaddingHorizontalSm == other.buttonPaddingHorizontalSm
    && a.buttonPaddingHorizontalMd == other.buttonPaddingHorizontalMd
    && a.buttonPaddingHorizontalLg == other.buttonPaddingHorizontalLg
    && a.buttonPaddingVerticalSm == other.buttonPaddingVerticalSm
    && a.buttonPaddingVerticalMd == other.buttonPaddingVerticalMd
    && a.buttonPaddingVerticalLg == other.buttonPaddingVerticalLg
    ;
}

int _$VSizesHash(VSizes self) => Object.hashAll([
  self.controlSm,
  self.controlMd,
  self.controlLg,
  self.iconSm,
  self.iconMd,
  self.iconLg,
  self.avatarSm,
  self.avatarMd,
  self.avatarLg,
  self.switchWidth,
  self.switchHeight,
  self.switchThumb,
  self.sliderThumb,
  self.sliderTrack,
  self.dialogMaxWidth,
  self.checkboxSize,
  self.radioSize,
  self.borderThin,
  self.borderThick,
  self.buttonPaddingHorizontalSm,
  self.buttonPaddingHorizontalMd,
  self.buttonPaddingHorizontalLg,
  self.buttonPaddingVerticalSm,
  self.buttonPaddingVerticalMd,
  self.buttonPaddingVerticalLg,
]);

void _$VSizesFillProperties(
  VSizes self,
  DiagnosticPropertiesBuilder properties,
) {
  properties.add(DoubleProperty('controlSm', self.controlSm));
  properties.add(DoubleProperty('controlMd', self.controlMd));
  properties.add(DoubleProperty('controlLg', self.controlLg));
  properties.add(DoubleProperty('iconSm', self.iconSm));
  properties.add(DoubleProperty('iconMd', self.iconMd));
  properties.add(DoubleProperty('iconLg', self.iconLg));
  properties.add(DoubleProperty('avatarSm', self.avatarSm));
  properties.add(DoubleProperty('avatarMd', self.avatarMd));
  properties.add(DoubleProperty('avatarLg', self.avatarLg));
  properties.add(DoubleProperty('switchWidth', self.switchWidth));
  properties.add(DoubleProperty('switchHeight', self.switchHeight));
  properties.add(DoubleProperty('switchThumb', self.switchThumb));
  properties.add(DoubleProperty('sliderThumb', self.sliderThumb));
  properties.add(DoubleProperty('sliderTrack', self.sliderTrack));
  properties.add(DoubleProperty('dialogMaxWidth', self.dialogMaxWidth));
  properties.add(DoubleProperty('checkboxSize', self.checkboxSize));
  properties.add(DoubleProperty('radioSize', self.radioSize));
  properties.add(DoubleProperty('borderThin', self.borderThin));
  properties.add(DoubleProperty('borderThick', self.borderThick));
  properties.add(DoubleProperty('buttonPaddingHorizontalSm', self.buttonPaddingHorizontalSm));
  properties.add(DoubleProperty('buttonPaddingHorizontalMd', self.buttonPaddingHorizontalMd));
  properties.add(DoubleProperty('buttonPaddingHorizontalLg', self.buttonPaddingHorizontalLg));
  properties.add(DoubleProperty('buttonPaddingVerticalSm', self.buttonPaddingVerticalSm));
  properties.add(DoubleProperty('buttonPaddingVerticalMd', self.buttonPaddingVerticalMd));
  properties.add(DoubleProperty('buttonPaddingVerticalLg', self.buttonPaddingVerticalLg));
}

