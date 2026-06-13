import 'package:flutter/foundation.dart';

part 'v_sizes.g.dart';

/// Standard control size scale used across interactive widgets.
///
/// Each interactive widget accepts this enum as its `size` parameter.
enum VControlSize {
  /// Small / compact.
  sm,

  /// Medium / default.
  md,

  /// Large / spacious.
  lg,
}

/// Named size tokens for component dimensions.
///
/// Covers common control sizes, icon sizes, and layout dimensions.
/// Component-specific values should live in component tokens.
@immutable
class VSizes with Diagnosticable {
  factory VSizes.defaults() {
    return const VSizes(
      controlSm: 36,  // Match VButton heightSm
      controlMd: 44,  // Match VButton heightMd  
      controlLg: 52,  // Match VButton heightLg
      iconSm: 16,     // Match VButton iconSizeSm
      iconMd: 18,     // Match VButton iconSizeMd
      iconLg: 20,     // Match VButton iconSizeLg
      avatarSm: 24,
      avatarMd: 40,
      avatarLg: 56,
      switchWidth: 44,
      switchHeight: 24,
      switchThumb: 18,
      sliderThumb: 20,
      sliderTrack: 4,
      dialogMaxWidth: 560,
      checkboxSize: 20,
      radioSize: 20,
      borderThin: 1.0,
      borderThick: 2.0,
      buttonPaddingHorizontalSm: 12,
      buttonPaddingHorizontalMd: 16,
      buttonPaddingHorizontalLg: 20,
      buttonPaddingVerticalSm: 8,
      buttonPaddingVerticalMd: 10,
      buttonPaddingVerticalLg: 12,
    );
  }
  const VSizes({
    required this.controlSm,
    required this.controlMd,
    required this.controlLg,
    required this.iconSm,
    required this.iconMd,
    required this.iconLg,
    required this.avatarSm,
    required this.avatarMd,
    required this.avatarLg,
    required this.switchWidth,
    required this.switchHeight,
    required this.switchThumb,
    required this.sliderThumb,
    required this.sliderTrack,
    required this.dialogMaxWidth,
    required this.checkboxSize,
    required this.radioSize,
    required this.borderThin,
    required this.borderThick,
    required this.buttonPaddingHorizontalSm,
    required this.buttonPaddingHorizontalMd,
    required this.buttonPaddingHorizontalLg,
    required this.buttonPaddingVerticalSm,
    required this.buttonPaddingVerticalMd,
    required this.buttonPaddingVerticalLg,
  });

  /// Small control height (e.g. dense button).
  final double controlSm;

  /// Default control height.
  final double controlMd;

  /// Large control height.
  final double controlLg;

  /// Small icon size.
  final double iconSm;

  /// Default icon size.
  final double iconMd;

  /// Large icon size.
  final double iconLg;

  /// Small avatar diameter.
  final double avatarSm;

  /// Default avatar diameter.
  final double avatarMd;

  /// Large avatar diameter.
  final double avatarLg;

  /// Switch track width.
  final double switchWidth;

  /// Switch track height.
  final double switchHeight;

  /// Switch thumb diameter.
  final double switchThumb;

  /// Slider thumb diameter.
  final double sliderThumb;

  /// Slider track thickness.
  final double sliderTrack;

  /// Dialog max width.
  final double dialogMaxWidth;

  /// Checkbox / multi-select box size.
  final double checkboxSize;

  /// Radio button size.
  final double radioSize;

  /// Thin border width (e.g. input borders).
  final double borderThin;

  /// Thick border width (e.g. focus indicators).
  final double borderThick;

  /// Button horizontal padding for small size.
  final double buttonPaddingHorizontalSm;

  /// Button horizontal padding for medium size.
  final double buttonPaddingHorizontalMd;

  /// Button horizontal padding for large size.
  final double buttonPaddingHorizontalLg;

  /// Button vertical padding for small size.
  final double buttonPaddingVerticalSm;

  /// Button vertical padding for medium size.
  final double buttonPaddingVerticalMd;

  /// Button vertical padding for large size.
  final double buttonPaddingVerticalLg;

  static VSizes lerp(VSizes a, VSizes b, double t) =>
      _$VSizesLerp(a, b, t);

  VSizes copyWith({
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
  }) =>
      _$VSizesCopyWith(this,
          controlSm: controlSm,
          controlMd: controlMd,
          controlLg: controlLg,
          iconSm: iconSm,
          iconMd: iconMd,
          iconLg: iconLg,
          avatarSm: avatarSm,
          avatarMd: avatarMd,
          avatarLg: avatarLg,
          switchWidth: switchWidth,
          switchHeight: switchHeight,
          switchThumb: switchThumb,
          sliderThumb: sliderThumb,
          sliderTrack: sliderTrack,
          dialogMaxWidth: dialogMaxWidth,
          checkboxSize: checkboxSize,
          radioSize: radioSize,
          borderThin: borderThin,
          borderThick: borderThick,
          buttonPaddingHorizontalSm: buttonPaddingHorizontalSm,
          buttonPaddingHorizontalMd: buttonPaddingHorizontalMd,
          buttonPaddingHorizontalLg: buttonPaddingHorizontalLg,
          buttonPaddingVerticalSm: buttonPaddingVerticalSm,
          buttonPaddingVerticalMd: buttonPaddingVerticalMd,
          buttonPaddingVerticalLg: buttonPaddingVerticalLg,
      );

  @override
  bool operator ==(Object other) => _$VSizesEq(this, other);

  @override
  int get hashCode => _$VSizesHash(this);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    _$VSizesFillProperties(this, properties);
  }
}
