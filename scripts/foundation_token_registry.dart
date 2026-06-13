/// Single source of truth for every foundation token class with generated
/// copyWith, lerp, operator ==, and hashCode methods.
///
/// Used by `dart run scripts/generate_foundation_tokens.dart`.
///
/// To add a new field to a foundation token class:
/// 1. Add the field to the class declaration (constructor + field + dartdoc)
/// 2. Add the field name to the class's entry below
/// 3. Run `dart run scripts/generate_foundation_tokens.dart`
const foundationTokenRegistry = <ClassEntry>[

  ClassEntry(
    file: 'lib/src/foundation/sizes.dart',
    className: 'VSizes',
    gFile: 'lib/src/foundation/v_sizes.g.dart',
    lerpStrategy: 'double',
    hashCodeStyle: 'hashAll',
    fields: [
      FieldEntry('controlSm'), FieldEntry('controlMd'), FieldEntry('controlLg'),
      FieldEntry('iconSm'), FieldEntry('iconMd'), FieldEntry('iconLg'),
      FieldEntry('avatarSm'), FieldEntry('avatarMd'), FieldEntry('avatarLg'),
      FieldEntry('switchWidth'), FieldEntry('switchHeight'), FieldEntry('switchThumb'),
      FieldEntry('sliderThumb'), FieldEntry('sliderTrack'),
      FieldEntry('dialogMaxWidth'), FieldEntry('checkboxSize'), FieldEntry('radioSize'),
      FieldEntry('borderThin'), FieldEntry('borderThick'),
      FieldEntry('buttonPaddingHorizontalSm'), FieldEntry('buttonPaddingHorizontalMd'), FieldEntry('buttonPaddingHorizontalLg'),
      FieldEntry('buttonPaddingVerticalSm'), FieldEntry('buttonPaddingVerticalMd'), FieldEntry('buttonPaddingVerticalLg'),
    ],
  ),

  ClassEntry(
    file: 'lib/src/foundation/spacing.dart',
    className: 'VSpacing',
    gFile: 'lib/src/foundation/v_spacing.g.dart',
    lerpStrategy: 'double',
    fields: [
      FieldEntry('xs'), FieldEntry('sm'), FieldEntry('md'),
      FieldEntry('lg'), FieldEntry('xl'), FieldEntry('x2l'), FieldEntry('x3l'),
      // gap and iconGap participate in copyWith but use a fixed lerp value
      // (they do not animate between themes, so they are excluded from lerp).
      FieldEntry('gap'), FieldEntry('iconGap'),
    ],
    // gap and iconGap are included in hashCode/== for structural equality.
    hashCodeFields: ['xs', 'sm', 'md', 'lg', 'xl', 'x2l', 'x3l', 'gap', 'iconGap'],
  ),

  ClassEntry(
    file: 'lib/src/foundation/radii.dart',
    className: 'VRadii',
    gFile: 'lib/src/foundation/v_radii.g.dart',
    lerpStrategy: 'double',
    fields: [
      FieldEntry('xs'), FieldEntry('sm'), FieldEntry('md'),
      FieldEntry('lg'), FieldEntry('xl'), FieldEntry('full'),
    ],
  ),

  ClassEntry(
    file: 'lib/src/foundation/shadows.dart',
    className: 'VShadows',
    gFile: 'lib/src/foundation/v_shadows.g.dart',
    lerpStrategy: 'BoxShadow',
    generateCopyWith: false,
    fields: [
      FieldEntry('level1'), FieldEntry('level2'),
      FieldEntry('level3'), FieldEntry('level4'),
    ],
  ),

  ClassEntry(
    file: 'lib/src/foundation/typography.dart',
    className: 'VTypography',
    gFile: 'lib/src/foundation/v_typography.g.dart',
    lerpStrategy: 'TextStyle',
    fields: [
      FieldEntry('heading'), FieldEntry('title'), FieldEntry('subtitle'),
      FieldEntry('body'), FieldEntry('label'), FieldEntry('caption'),
    ],
  ),

  ClassEntry(
    file: 'lib/src/foundation/semantic_tokens.dart',
    className: 'VColors',
    gFile: 'lib/src/foundation/v_colors.g.dart',
    lerpStrategy: 'Color',
    hashCodeStyle: 'hashAll',
    fields: [
      FieldEntry('background'), FieldEntry('surface'),
      FieldEntry('surfaceElevated'), FieldEntry('surfaceHover'),
      FieldEntry('surfaceLevel0'), FieldEntry('surfaceLevel1'),
      FieldEntry('surfaceLevel2'), FieldEntry('surfaceLevel3'),
      FieldEntry('surfaceLevel4'),
      FieldEntry('text'), FieldEntry('textMuted'), FieldEntry('textDisabled'),
      FieldEntry('border'), FieldEntry('borderStrong'),
      FieldEntry('actionPrimary'), FieldEntry('actionPrimaryHover'),
      FieldEntry('actionPrimaryPressed'), FieldEntry('actionPrimaryText'),
      FieldEntry('danger'), FieldEntry('dangerHover'), FieldEntry('dangerSurface'),
      FieldEntry('success'), FieldEntry('successHover'), FieldEntry('successSurface'),
      FieldEntry('warning'), FieldEntry('warningHover'), FieldEntry('warningSurface'),
      FieldEntry('focusRing'), FieldEntry('scrim'),
    ],
  ),

  ClassEntry(
    file: 'lib/src/foundation/responsive.dart',
    className: 'VBreakpointValues',
    gFile: 'lib/src/foundation/v_breakpoint_values.g.dart',
    lerpStrategy: 'double',
    fields: [
      FieldEntry('sm'), FieldEntry('md'), FieldEntry('lg'),
      FieldEntry('xl'), FieldEntry('xxl'),
    ],
  ),

];

class ClassEntry {
  const ClassEntry({
    required this.file,
    required this.className,
    required this.gFile,
    required this.lerpStrategy,
    required this.fields,
    this.generateCopyWith = true,
    this.generateDiagnostics = true,
    this.hashCodeStyle = 'hash',
    this.hashCodeFields,
  });

  final String file;
  final String className;
  final String gFile;
  final String lerpStrategy;
  final List<FieldEntry> fields;
  final bool generateCopyWith;

  /// Whether to generate a `_\$<Class>FillProperties` function for DevTools.
  final bool generateDiagnostics;

  final String hashCodeStyle;
  final List<String>? hashCodeFields;
}

class FieldEntry {
  const FieldEntry(this.name);
  final String name;
}
