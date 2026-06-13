/// Single source of truth for every field on [VComponentTokens].
///
/// Used by `dart run scripts/generate_component_tokens.dart` to generate
/// the `fromColors`, `lerp`, and `copyWith` method bodies.
///
/// To add a new component token:
/// 1. Add an entry to [tokenRegistry] below
/// 2. Declare the field on `VComponentTokens` (constructor + field + import)
/// 3. Run `dart run scripts/generate_component_tokens.dart`
const tokenRegistry = <_TokenEntry>[
  _TokenEntry('appBar', 'VAppBarTokens', required: true),
  _TokenEntry('button', 'VButtonTokens', required: true),
  _TokenEntry('checkbox', 'VCheckboxTokens', required: true),
  _TokenEntry('chip', 'VChipTokens', required: true),
  _TokenEntry('menu', 'VMenuTokens', required: true),
  _TokenEntry('radio', 'VRadioTokens', required: true),
  _TokenEntry('select', 'VSelectTokens', required: true),
  _TokenEntry('switch_', 'VSwitchTokens', required: true),
  _TokenEntry('surface', 'VSurfaceTokens', required: true),
  _TokenEntry('dialog', 'VDialogTokens', required: true),
  _TokenEntry('input', 'VInputTokens', required: true),
  _TokenEntry('toast', 'VToastTokens'),
  _TokenEntry('datePicker', 'VDatePickerTokens'),
  _TokenEntry('timePicker', 'VTimePickerTokens'),
  _TokenEntry('table', 'VTableTokens'),
  _TokenEntry('scrollbar', 'VScrollbarTokens'),
  _TokenEntry('segmentedControl', 'VSegmentedControlTokens', required: true),
  _TokenEntry('accordion', 'VAccordionTokens', required: true),
  _TokenEntry('autoSuggest', 'VAutoSuggestTokens'),
  _TokenEntry('teachingTip', 'VTeachingTipTokens'),
  _TokenEntry('navigationBar', 'VNavigationBarTokens', required: true),
  _TokenEntry('steps', 'VStepsTokens', required: true),
  _TokenEntry('timeline', 'VTimeLineTokens', required: true),
  _TokenEntry('divider', 'VDividerTokens', required: true),
  _TokenEntry('slider', 'VSliderTokens', required: true),
];

class _TokenEntry {
  const _TokenEntry(this.name, this.type, {this.required = false});

  /// Field name as it appears on [VComponentTokens], e.g. `'dialog'`.
  final String name;

  /// Dart type name, e.g. `'VDialogTokens'`.
  final String type;

  /// Whether the constructor parameter is required.
  final bool required;
}
