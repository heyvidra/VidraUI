import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

part 'v_typography.g.dart';

/// Named text styles used throughout the design system.
@immutable
class VTypography with Diagnosticable {
  factory VTypography.defaults() {
    return const VTypography(
      heading: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
      title: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      subtitle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
      body: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      label: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
      caption: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.3,
      ),
    );
  }
  const VTypography({
    required this.heading,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.label,
    required this.caption,
  });

  final TextStyle heading;
  final TextStyle title;
  final TextStyle subtitle;
  final TextStyle body;
  final TextStyle label;
  final TextStyle caption;

  static VTypography lerp(VTypography a, VTypography b, double t) =>
      _$VTypographyLerp(a, b, t);

  VTypography copyWith({
    TextStyle? heading,
    TextStyle? title,
    TextStyle? subtitle,
    TextStyle? body,
    TextStyle? label,
    TextStyle? caption,
  }) =>
      _$VTypographyCopyWith(this,
          heading: heading,
          title: title,
          subtitle: subtitle,
          body: body,
          label: label,
          caption: caption,
      );

  @override
  bool operator ==(Object other) => _$VTypographyEq(this, other);

  @override
  int get hashCode => _$VTypographyHash(this);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    _$VTypographyFillProperties(this, properties);
  }
}
