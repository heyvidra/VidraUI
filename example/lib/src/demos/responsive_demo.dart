part of '../../main.dart';

class _ResponsiveDemo extends StatelessWidget {
  const _ResponsiveDemo();

  @override
  Widget build(BuildContext context) {
    final bp = context.vBreakpoint;
    final cols = VResponsive.value<int>(context, xs: 1, sm: 2, md: 3, lg: 4);

    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Responsive', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    VText(
                        'Window: ${context.vScreenWidth.toStringAsFixed(0)} × ${context.vScreenHeight.toStringAsFixed(0)}',
                        variant: VTextVariant.body),
                    VText('Breakpoint: ${bp.name} (columns: $cols)',
                        variant: VTextVariant.title,
                        color: context.vIsCompact
                            ? const Color(0xFFDC2626)
                            : const Color(0xFF2563EB)),
                    VText(
                        'Compact: ${context.vIsCompact}  Medium: ${context.vIsMedium}  Expanded: ${context.vIsExpanded}',
                        variant: VTextVariant.caption),
                    VText(
                        'Keyboard: ${context.vKeyboardVisible ? 'visible' : 'hidden'} (${context.vKeyboardInset.toStringAsFixed(0)})',
                        variant: VTextVariant.caption),
                    VText(
                        'Orientation: ${context.vIsPortrait ? 'Portrait' : 'Landscape'}',
                        variant: VTextVariant.caption),
                    VDivider(),
                    // Show responsive grid
                    Row(
                      children: List.generate(cols, (i) {
                        return Expanded(
                          child: Container(
                            height: 40,
                            margin:
                                EdgeInsets.only(right: i < cols - 1 ? 4 : 0),
                            decoration: BoxDecoration(
                              color: context.vIsCompact
                                  ? const Color(0x33DC2626)
                                  : const Color(0x332563EB),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text('${i + 1}',
                                  style: const TextStyle(fontSize: 12)),
                            ),
                          ),
                        );
                      }),
                    ),
                  ]),
            ),
          ),
        ]);
  }
}


// docs-snippet:start responsive-basic
// final columns = VResponsive.value<int>(
//   context,
//   xs: 1,
//   sm: 2,
//   md: 3,
//   lg: 4,
// );
// docs-snippet:end responsive-basic

