/// Registry of every VComponentThemeWrapper subclass.
///
/// Used by `dart run scripts/generate_component_themes.dart`.
class Entry {
  const Entry(this.className, this.tokenType, this.accessor, {this.extraTypedef});

  /// Class name, e.g. 'VDialogTheme'.
  final String className;

  /// Token type, e.g. 'VDialogTokens'.
  final String tokenType;

  /// Accessor path on VComponentTokens, e.g. 'dialog'.
  final String accessor;

  /// Optional typedef to emit before the class, e.g.
  /// `'typedef VButtonTokensOverride = VScopedTokenOverride<VButtonTokens>;'`
  final String? extraTypedef;
}

const entries = <Entry>[
  Entry('VAccordionTheme',          'VAccordionTokens',          'accordion'),
  Entry('VAppBarTheme',             'VAppBarTokens',             'appBar'),
  Entry('VButtonTheme',             'VButtonTokens',             'button',
      extraTypedef: 'typedef VButtonTokensOverride = VScopedTokenOverride<VButtonTokens>;'),
  Entry('VCheckboxTheme',           'VCheckboxTokens',           'checkbox'),
  Entry('VChipTheme',               'VChipTokens',               'chip'),
  Entry('VDatePickerTheme',         'VDatePickerTokens',         'datePicker'),
  Entry('VDialogTheme',             'VDialogTokens',             'dialog'),
  Entry('VDividerTheme',            'VDividerTokens',            'divider'),
  Entry('VInputTheme',              'VInputTokens',              'input'),
  Entry('VMenuTheme',               'VMenuTokens',               'menu'),
  Entry('VNavigationBarTheme',      'VNavigationBarTokens',      'navigationBar'),
  Entry('VRadioTheme',              'VRadioTokens',              'radio'),
  Entry('VSegmentedControlTheme',   'VSegmentedControlTokens',   'segmentedControl'),
  Entry('VSelectTheme',             'VSelectTokens',             'select'),
  Entry('VStepsTheme',              'VStepsTokens',              'steps'),
  Entry('VSurfaceTheme',            'VSurfaceTokens',            'surface'),
  Entry('VSwitchTheme',             'VSwitchTokens',             'switch_'),
  Entry('VTableTheme',              'VTableTokens',              'table'),
  Entry('VTimePickerTheme',         'VTimePickerTokens',         'timePicker'),
  Entry('VTimeLineTheme',           'VTimeLineTokens',           'timeline'),
  Entry('VToastTheme',              'VToastTokens',              'toast'),
];
