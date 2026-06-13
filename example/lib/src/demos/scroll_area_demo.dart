part of '../../main.dart';

class _ScrollAreaDemo extends StatefulWidget {
  const _ScrollAreaDemo();

  @override
  State<_ScrollAreaDemo> createState() => _ScrollAreaDemoState();
}

class _ScrollAreaDemoState extends State<_ScrollAreaDemo> {
  bool _showScrollbar = true;

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
      gap: 16,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const VText('Scroll Area & VScrollbar', variant: VTextVariant.heading),
        const VText(
          'A custom scrolling viewport and scrollbar styled by the theme, avoiding Material/Cupertino packages and providing smooth, clamped scroll kinetics.',
          variant: VTextVariant.body,
        ),

        // Section 1: Standard Vertical Scroll Area
        const VText('Standard Scroll Area', variant: VTextVariant.title),
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              gap: 12,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                VFlex.horizontal(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const VText('Vertical Scroll (Fixed Height 200)'),
                    VButton(
                      size: VControlSize.sm,
                      variant: VButtonVariant.secondary,
                      onPressed: () {
                        setState(() {
                          _showScrollbar = !_showScrollbar;
                        });
                      },
                      child: VText(_showScrollbar ? 'Hide Scrollbar' : 'Show Scrollbar'),
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: VTheme.of(context).colors.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: VScrollArea(
                    showScrollbar: _showScrollbar,
                    child: VFlex.vertical(
                      padding: const EdgeInsets.all(12),
                      gap: 8,
                      children: List.generate(
                        20,
                        (index) => VSurface(
                          variant: VSurfaceVariant.panel,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: VFlex.horizontal(
                              gap: 8,
                              children: [
                                VIcon(LucideIcons.list, size: 14),
                                VText('Scrollable Item ${index + 1}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Section 2: Horizontal Scroll Area
        const VText('Horizontal Scroll Area', variant: VTextVariant.title),
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              gap: 12,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const VText('Horizontal Scroll View'),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: VTheme.of(context).colors.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: VScrollArea(
                    scrollDirection: Axis.horizontal,
                    child: VFlex.horizontal(
                      padding: const EdgeInsets.all(12),
                      gap: 8,
                      children: List.generate(
                        10,
                        (index) => Container(
                          width: 120,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: VTheme.of(context).colors.surfaceElevated,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: VFlex.vertical(
                            mainAxisAlignment: MainAxisAlignment.center,
                            gap: 4,
                            children: [
                              VIcon(LucideIcons.image, size: 16),
                              VText('Card ${index + 1}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Section 3: Chainable Extension Method
        const VText('Chainable .scrollable() Extension', variant: VTextVariant.title),
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              gap: 12,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const VText('Applies scrollable behavior inline on any widget subtree.'),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: VTheme.of(context).colors.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: VFlex.vertical(
                    padding: const EdgeInsets.all(12),
                    gap: 6,
                    children: List.generate(
                      8,
                      (index) => VText('• Extension line ${index + 1}', variant: VTextVariant.body),
                    ),
                  ).scrollable(
                    thumbVisibility: true,
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

// docs-snippet:start scroll-area-basic
// VScrollArea(
//   showScrollbar: true,
//   child: Column(
//     children: [
//       Text('Item 1'),
//       Text('Item 2'),
//       Text('Item 3'),
//     ],
//   ),
// )
// docs-snippet:end scroll-area-basic
