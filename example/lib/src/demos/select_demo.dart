part of '../../main.dart';

class _SelectDemo extends StatefulWidget {
  const _SelectDemo();
  @override
  State<_SelectDemo> createState() => _SelectDemoState();
}

class _SelectDemoState extends State<_SelectDemo> {
  String? _selected;
  String? _fruitSelected;
  Set<String> _multiSelected = {};

  static const _options = [
    VSelectOption(value: 'a', label: 'Option A'),
    VSelectOption(value: 'b', label: 'Option B'),
    VSelectOption(value: 'c', label: 'Option C (disabled)', enabled: false),
  ];

  static final _searchOptions = [
    const VSelectOption(value: 'apple', label: 'Apple', leading: Text('🍎')),
    const VSelectOption(value: 'banana', label: 'Banana', leading: Text('🍌')),
    const VSelectOption(value: 'orange', label: 'Orange', leading: Text('🍊')),
    const VSelectOption(value: 'grape', label: 'Grape', leading: Text('🍇')),
  ];

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Select', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    const VText('Single Select', variant: VTextVariant.title),
                    VSelect<String>(
                      label: 'Choose an option',
                      placeholder: 'Select...',
                      options: _options,
                      value: _selected,
                      onChanged: (String v) => setState(() => _selected = v),
                    ),
                    const SizedBox(height: 8),
                    const VText('Searchable Select with Option Icons', variant: VTextVariant.title),
                    VSelect<String>(
                      label: 'Choose a fruit',
                      placeholder: 'Search fruit...',
                      searchable: true,
                      options: _searchOptions,
                      value: _fruitSelected,
                      onChanged: (String v) => setState(() => _fruitSelected = v),
                    ),
                    const SizedBox(height: 8),
                    const VText('Multi Select', variant: VTextVariant.title),
                    VSelect<String>.multiple(
                      label: 'Choose tags',
                      placeholder: 'None selected',
                      options: _options,
                      values: _multiSelected,
                      onChangedMultiple: (v) =>
                          setState(() => _multiSelected = v),
                    ),
                    const SizedBox(height: 8),
                    const VText(
                      'Forced upward menu',
                      variant: VTextVariant.title,
                    ),
                    VSelect<String>(
                      label: 'Choose above',
                      placeholder: 'Opens upward',
                      menuPlacement: VAnchoredOverlayPlacement.up,
                      options: _options,
                      value: _selected,
                      onChanged: (String v) => setState(() => _selected = v),
                    ),
                  ]),
            ),
          ),
        ]);
  }
}


// docs-snippet:start select-basic
// VSelect<String>(
//   label: 'Choose an option',
//   options: const [
//     VSelectOption(value: 'a', label: 'Option A'),
//     VSelectOption(value: 'b', label: 'Option B'),
//   ],
//   value: selected,
//   onChanged: (value) => setState(() => selected = value),
// )
// docs-snippet:end select-basic

// docs-snippet:start selectable-text-basic
// const VSelectableText(
//   'This text can be selected.',
//   variant: VTextVariant.body,
// )
// docs-snippet:end selectable-text-basic

