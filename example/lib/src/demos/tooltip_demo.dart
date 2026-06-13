part of '../../main.dart';

class _TooltipDemo extends StatelessWidget {
  const _TooltipDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Tooltip', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: VText(
                'Hover the buttons below to see tooltips.',
                variant: VTextVariant.body,
              ),
            ),
          ),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.horizontal(
                gap: 8,
                children: [
                  VTooltip(
                    message: 'Save changes to the server',
                    child: VButton(
                      onPressed: () {},
                      variant: VButtonVariant.secondary,
                      child: const VText('Save', variant: VTextVariant.label),
                    ),
                  ),
                  VTooltip(
                    message: 'Delete this item permanently',
                    child: VButton(
                      onPressed: () {},
                      variant: VButtonVariant.danger,
                      child: const VText('Delete', variant: VTextVariant.label),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]);
  }
}

