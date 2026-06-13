part of '../../main.dart';

class _TogglesDemo extends StatefulWidget {
  const _TogglesDemo();

  @override
  State<_TogglesDemo> createState() => _TogglesDemoState();
}

class _TogglesDemoState extends State<_TogglesDemo> {
  bool? _checked = true;
  bool? _indeterminateChecked;
  bool _switched = false;
  String _option = 'a';

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Toggles', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 16,
                  children: [
                    const VText('Checkbox', variant: VTextVariant.title),
                    VFlex.horizontal(gap: 16, children: [
                      VCheckbox(
                        checked: _checked,
                        label: 'Accept terms',
                        onChanged: (v) => setState(() => _checked = v),
                      ),
                      VCheckbox(
                        checked: _indeterminateChecked,
                        tristate: true,
                        label: 'Tristate checkbox',
                        onChanged: (v) => setState(() => _indeterminateChecked = v),
                      ),
                    ]),
                    VCheckbox(
                      checked: true,
                      label: 'Always on (disabled)',
                      enabled: false,
                      onChanged: (v) {},
                    ),
                    const VText('Switch', variant: VTextVariant.title),
                    VFlex.horizontal(gap: 16, children: [
                      VSwitch(
                        checked: _switched,
                        semanticLabel: 'Enable notifications',
                        onChanged: (v) => setState(() => _switched = v),
                      ),
                      VText(
                        _switched ? 'On' : 'Off',
                        variant: VTextVariant.body,
                      ),
                    ]),
                    VFlex.horizontal(gap: 16, children: [
                      VSwitch(
                        checked: true,
                        enabled: false,
                        semanticLabel: 'Always on (disabled)',
                        onChanged: (v) {},
                      ),
                      VText(
                        'Always on (disabled)',
                        variant: VTextVariant.body,
                      ),
                      VSwitch(
                        checked: false,
                        enabled: false,
                        semanticLabel: 'Always off (disabled)',
                        onChanged: (v) {},
                      ),
                      VText(
                        'Always off (disabled)',
                        variant: VTextVariant.body,
                      ),
                    ]),
                    const VText('Radio', variant: VTextVariant.title),
                    VFlex.vertical(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      gap: 8,
                      children: [
                        VRadio(
                          selected: _option == 'a',
                          label: 'Option A',
                          onSelected: () => setState(() => _option = 'a'),
                        ),
                        VRadio(
                          selected: _option == 'b',
                          label: 'Option B',
                          onSelected: () => setState(() => _option = 'b'),
                        ),
                        VRadio(
                          selected: _option == 'c',
                          label: 'Option C (disabled)',
                          enabled: false,
                          onSelected: () {},
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ]);
  }
}


// docs-snippet:start toggle-controls
// VCheckbox(
//   checked: accepted,
//   label: 'Accept terms',
//   onChanged: (value) => setState(() => accepted = value),
// )
// docs-snippet:end toggle-controls

