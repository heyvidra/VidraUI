// GENERATED CODE — DO NOT EDIT.
//
// Regenerate with:
//   dart run scripts/generate_foundation_tokens.dart
//
// Registry: scripts/foundation_token_registry.dart

// coverage:ignore-file

part of 'typography.dart';

VTypography _$VTypographyLerp(
  VTypography a,
  VTypography b,
  double t,
) {
  return VTypography(
    heading: TextStyle.lerp(a.heading, b.heading, t)!,
    title: TextStyle.lerp(a.title, b.title, t)!,
    subtitle: TextStyle.lerp(a.subtitle, b.subtitle, t)!,
    body: TextStyle.lerp(a.body, b.body, t)!,
    label: TextStyle.lerp(a.label, b.label, t)!,
    caption: TextStyle.lerp(a.caption, b.caption, t)!,
  );
}

VTypography _$VTypographyCopyWith(
  VTypography self, {
  TextStyle? heading,
  TextStyle? title,
  TextStyle? subtitle,
  TextStyle? body,
  TextStyle? label,
  TextStyle? caption,
}) {
  return VTypography(
    heading: heading ?? self.heading,
    title: title ?? self.title,
    subtitle: subtitle ?? self.subtitle,
    body: body ?? self.body,
    label: label ?? self.label,
    caption: caption ?? self.caption,
  );
}

bool _$VTypographyEq(VTypography a, Object other) {
  if (identical(a, other)) return true;
  return other is VTypography
    && a.heading == other.heading
    && a.title == other.title
    && a.subtitle == other.subtitle
    && a.body == other.body
    && a.label == other.label
    && a.caption == other.caption
    ;
}

int _$VTypographyHash(VTypography self) => Object.hash(
  self.heading,
  self.title,
  self.subtitle,
  self.body,
  self.label,
  self.caption,
);

void _$VTypographyFillProperties(
  VTypography self,
  DiagnosticPropertiesBuilder properties,
) {
  properties.add(DiagnosticsProperty<TextStyle>('heading', self.heading));
  properties.add(DiagnosticsProperty<TextStyle>('title', self.title));
  properties.add(DiagnosticsProperty<TextStyle>('subtitle', self.subtitle));
  properties.add(DiagnosticsProperty<TextStyle>('body', self.body));
  properties.add(DiagnosticsProperty<TextStyle>('label', self.label));
  properties.add(DiagnosticsProperty<TextStyle>('caption', self.caption));
}

