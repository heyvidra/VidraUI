part of '../../main.dart';

class _DividerDemo extends StatelessWidget {
  const _DividerDemo();

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 24,
      children: [
        const VText('Divider', variant: VTextVariant.heading),

        // Solid Dividers section
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 16,
              children: [
                const VText('Solid Dividers', variant: VTextVariant.title),
                const VText('Standard horizontal solid divider.',
                    variant: VTextVariant.body),
                const VDivider(),
                const VText('With custom thickness and indent.',
                    variant: VTextVariant.body),
                const VDivider(
                  thickness: 2,
                  indent: 32,
                  endIndent: 32,
                ),
                const VText('With custom color.', variant: VTextVariant.body),
                VDivider(
                  color: theme.colors.danger,
                  thickness: 1.5,
                ),
              ],
            ),
          ),
        ),

        // Dotted Dividers section
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 16,
              children: [
                const VText('Dotted Dividers', variant: VTextVariant.title),
                const VText('Standard horizontal dotted divider.',
                    variant: VTextVariant.body),
                const VDivider(style: VDividerStyle.dotted),
                const VText('Dotted divider with custom dot radius and step.',
                    variant: VTextVariant.body),
                const VDivider(
                  style: VDividerStyle.dotted,
                  dotRadius: 3,
                  dotStep: 10,
                ),
              ],
            ),
          ),
        ),

        // Dividers with Labels section
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 16,
              children: [
                const VText('Dividers with Labels',
                    variant: VTextVariant.title),
                const VText('Horizontal divider with a text label.',
                    variant: VTextVariant.body),
                const VDivider(
                  label: VText('OR'),
                ),
                const VText(
                    'Horizontal divider with custom styled widget label.',
                    variant: VTextVariant.body),
                VDivider(
                  thickness: 1,
                  label: VBox(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        VIcon(LucideIcons.star, size: 14),
                        SizedBox(width: 4),
                        VText('SPECIAL OFFERS', variant: VTextVariant.caption),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Vertical Dividers section
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 16,
              children: [
                const VText('Vertical Dividers', variant: VTextVariant.title),
                const VText(
                    'Vertical dividers used inside a Row to separate elements. Must have constrained height.',
                    variant: VTextVariant.body),
                SizedBox(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const VText('Section A', variant: VTextVariant.body),
                      const VDivider(axis: Axis.vertical),
                      const VText('Section B', variant: VTextVariant.body),
                      const VDivider(
                        axis: Axis.vertical,
                        style: VDividerStyle.dotted,
                        dotRadius: 2,
                        dotStep: 6,
                      ),
                      const VDivider(
                        axis: Axis.vertical,
                        label: VText('OR', variant: VTextVariant.caption),
                      ),
                      const VText('Section C', variant: VTextVariant.body),
                      VDivider(
                        axis: Axis.vertical,
                        thickness: 2,
                        color: theme.colors.actionPrimary,
                      ),
                      const VText('Section D', variant: VTextVariant.body),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
