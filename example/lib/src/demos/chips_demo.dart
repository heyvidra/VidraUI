part of '../../main.dart';

class _ChipsDemo extends StatelessWidget {
  const _ChipsDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        gap: 16,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const VText('Chips', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  gap: 12,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const VText('Variants', variant: VTextVariant.title),
                    Wrap(spacing: 8, runSpacing: 8, children: const [
                      VChip(label: Text('Soft')),
                      VChip(
                          label: Text('Filled'), variant: VChipVariant.filled),
                      VChip(
                          label: Text('Outlined'),
                          variant: VChipVariant.outlined),
                      VChip(label: Text('Selected'), selected: true),
                      VChip(label: Text('Disabled'), enabled: false),
                    ]),
                    const VText('With leading', variant: VTextVariant.title),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      VChip(
                        leading: VIcon(LucideIcons.info, size: 14),
                        label: const Text('Info'),
                        variant: VChipVariant.soft,
                      ),
                      VChip(
                        leading: VIcon(LucideIcons.check, size: 14),
                        label: const Text('Success'),
                        variant: VChipVariant.filled,
                        selected: true,
                      ),
                    ]),
                    const VText('With delete', variant: VTextVariant.title),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      VChip(
                          label: const Text('Deletable'),
                          variant: VChipVariant.soft,
                          onDeleted: () {}),
                      VChip(
                          label: const Text('Interactive'),
                          variant: VChipVariant.filled,
                          onPressed: () {}),
                    ]),
                  ]),
            ),
          ),
        ]);
  }
}


// docs-snippet:start chip-variants
// Wrap(
//   spacing: 8,
//   children: const [
//     VChip(label: Text('Soft')),
//     VChip(label: Text('Filled'), variant: VChipVariant.filled),
//     VChip(label: Text('Selected'), selected: true),
//   ],
// )
// docs-snippet:end chip-variants

