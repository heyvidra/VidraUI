part of '../../main.dart';

class _SegmentedControlDemo extends StatefulWidget {
  const _SegmentedControlDemo();

  @override
  State<_SegmentedControlDemo> createState() => _SegmentedControlDemoState();
}

class _SegmentedControlDemoState extends State<_SegmentedControlDemo> {
  String _sizeValue = 'md';
  String _iconValue = 'audio';
  String _disabledValue = 'one';

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return VFlex.vertical(
      gap: theme.spacing.xl,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        const VText(
          'VSegmentedControl',
          variant: VTextVariant.heading,
        ),
        const VText(
          'A premium, sliding segmented horizontal selector matching macOS design patterns. Smooth animations guide indicators upon click or keyboard arrows traversal.',
        ),

        // Sizes Showcase
        _DocsSection(
          title: 'Component Sizes',
          child: VFlex.vertical(
            gap: theme.spacing.lg,
            children: [
              VFlex.vertical(
                gap: theme.spacing.xs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VText('Small (sm)', variant: VTextVariant.caption),
                  VSegmentedControl<String>(
                    value: _sizeValue,
                    size: VControlSize.sm,
                    options: const [
                      VSegmentedControlOption(value: 'sm', label: 'Small'),
                      VSegmentedControlOption(value: 'md', label: 'Medium'),
                      VSegmentedControlOption(value: 'lg', label: 'Large'),
                    ],
                    onChanged: (v) => setState(() => _sizeValue = v),
                  ),
                ],
              ),
              VFlex.vertical(
                gap: theme.spacing.xs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VText('Medium (md)', variant: VTextVariant.caption),
                  VSegmentedControl<String>(
                    value: _sizeValue,
                    size: VControlSize.md,
                    options: const [
                      VSegmentedControlOption(value: 'sm', label: 'Small'),
                      VSegmentedControlOption(value: 'md', label: 'Medium'),
                      VSegmentedControlOption(value: 'lg', label: 'Large'),
                    ],
                    onChanged: (v) => setState(() => _sizeValue = v),
                  ),
                ],
              ),
              VFlex.vertical(
                gap: theme.spacing.xs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VText('Large (lg)', variant: VTextVariant.caption),
                  VSegmentedControl<String>(
                    value: _sizeValue,
                    size: VControlSize.lg,
                    options: const [
                      VSegmentedControlOption(value: 'sm', label: 'Small'),
                      VSegmentedControlOption(value: 'md', label: 'Medium'),
                      VSegmentedControlOption(value: 'lg', label: 'Large'),
                    ],
                    onChanged: (v) => setState(() => _sizeValue = v),
                  ),
                ],
              ),
            ],
          ),
        ),

        // With Icons
        _DocsSection(
          title: 'Options with Icons',
          child: VSegmentedControl<String>(
            value: _iconValue,
            options: [
              VSegmentedControlOption(
                value: 'audio',
                label: 'Audio Input',
                icon: Icon(LucideIcons.mic, size: 16, color: theme.colors.text),
              ),
              VSegmentedControlOption(
                value: 'system',
                label: 'System Audio',
                icon: Icon(LucideIcons.volume2, size: 16, color: theme.colors.text),
              ),
              VSegmentedControlOption(
                value: 'settings',
                label: 'Config',
                icon: Icon(LucideIcons.settings, size: 16, color: theme.colors.text),
              ),
            ],
            onChanged: (v) => setState(() => _iconValue = v),
          ),
        ),

        // States & Disabled Options
        _DocsSection(
          title: 'States & Disabled Elements',
          child: VFlex.vertical(
            gap: theme.spacing.lg,
            children: [
              VFlex.vertical(
                gap: theme.spacing.xs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VText('Individual option disabled (Option Three is disabled)', variant: VTextVariant.caption),
                  VSegmentedControl<String>(
                    value: _disabledValue,
                    options: const [
                      VSegmentedControlOption(value: 'one', label: 'Option One'),
                      VSegmentedControlOption(value: 'two', label: 'Option Two'),
                      VSegmentedControlOption(value: 'three', label: 'Option Three', enabled: false),
                    ],
                    onChanged: (v) => setState(() => _disabledValue = v),
                  ),
                ],
              ),
              VFlex.vertical(
                gap: theme.spacing.xs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VText('Entire component disabled', variant: VTextVariant.caption),
                  VSegmentedControl<String>(
                    value: 'one',
                    enabled: false,
                    options: const [
                      VSegmentedControlOption(value: 'one', label: 'Option One'),
                      VSegmentedControlOption(value: 'two', label: 'Option Two'),
                      VSegmentedControlOption(value: 'three', label: 'Option Three'),
                    ],
                    onChanged: (_) {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// docs-snippet:start segmented-control-basic
// VSegmentedControl<String>(
//   value: selected,
//   options: const [
//     VSegmentedControlOption(value: 'day', label: 'Day'),
//     VSegmentedControlOption(value: 'week', label: 'Week'),
//     VSegmentedControlOption(value: 'month', label: 'Month'),
//   ],
//   onChanged: (v) => setState(() => selected = v),
// )
// docs-snippet:end segmented-control-basic

// docs-snippet:start segmented-control-sizes
// VFlex.vertical(
//   gap: 12,
//   children: [
//     VSegmentedControl<String>(
//       value: selected,
//       size: VControlSize.sm,
//       options: const [
//         VSegmentedControlOption(value: 'a', label: 'Small'),
//         VSegmentedControlOption(value: 'b', label: 'Controls'),
//       ],
//       onChanged: (v) => setState(() => selected = v),
//     ),
//     VSegmentedControl<String>(
//       value: selected,
//       size: VControlSize.lg,
//       options: const [
//         VSegmentedControlOption(value: 'a', label: 'Large'),
//         VSegmentedControlOption(value: 'b', label: 'Controls'),
//         VSegmentedControlOption(value: 'c', label: 'Disabled', enabled: false),
//       ],
//       onChanged: (v) => setState(() => selected = v),
//     ),
//   ],
// )
// docs-snippet:end segmented-control-sizes
