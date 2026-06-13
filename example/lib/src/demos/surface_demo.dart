part of '../../main.dart';

class _SurfaceDemo extends StatelessWidget {
  const _SurfaceDemo();

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Surface Variants', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    VFlex.horizontal(
                      gap: 8,
                      children: [
                        Expanded(
                          child: VSurface(
                            variant: VSurfaceVariant.base,
                            child: const Padding(
                              padding: EdgeInsets.all(16),
                              child:
                                  VText('Base', variant: VTextVariant.caption),
                            ),
                          ),
                        ),
                        Expanded(
                          child: VSurface(
                            variant: VSurfaceVariant.elevated,
                            child: const Padding(
                              padding: EdgeInsets.all(16),
                              child: VText('Elevated',
                                  variant: VTextVariant.caption),
                            ),
                          ),
                        ),
                      ],
                    ),
                    VFlex.horizontal(
                      gap: 8,
                      children: [
                        Expanded(
                          child: VSurface(
                            variant: VSurfaceVariant.card,
                            child: const Padding(
                              padding: EdgeInsets.all(16),
                              child:
                                  VText('Card', variant: VTextVariant.caption),
                            ),
                          ),
                        ),
                        Expanded(
                          child: VSurface(
                            variant: VSurfaceVariant.panel,
                            child: const Padding(
                              padding: EdgeInsets.all(16),
                              child:
                                  VText('Panel', variant: VTextVariant.caption),
                            ),
                          ),
                        ),
                      ],
                    ),
                    VSurface(
                      background: VBackground.gradient(
                        LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.colors.actionPrimary,
                            theme.colors.actionPrimaryPressed,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: VFlex.vertical(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            gap: 6,
                            children: [
                              VText(
                                'Gradient surface',
                                variant: VTextVariant.title,
                                color: theme.colors.actionPrimaryText,
                              ),
                              VText(
                                'One-off local background override.',
                                variant: VTextVariant.caption,
                                color: theme.colors.actionPrimaryText,
                              ),
                            ]),
                      ),
                    ),
                  ]),
            ),
          ),
        ]);
  }
}


// docs-snippet:start surface-variants
// VSurface(
//   variant: VSurfaceVariant.card,
//   child: const Padding(
//     padding: EdgeInsets.all(16),
//     child: VText('Card content'),
//   ),
// )
// docs-snippet:end surface-variants

// docs-snippet:start surface-background-color
// VSurface(
//   background: VBackground.color(theme.colors.surfaceElevated),
//   child: const Padding(
//     padding: EdgeInsets.all(16),
//     child: VText('Local color override'),
//   ),
// )
// docs-snippet:end surface-background-color

// docs-snippet:start surface-background-gradient
// VSurface(
//   background: VBackground.gradient(
//     LinearGradient(
//       colors: [theme.colors.actionPrimary, theme.colors.surfaceElevated],
//     ),
//   ),
//   child: const Padding(
//     padding: EdgeInsets.all(16),
//     child: VText('Local gradient override'),
//   ),
// )
// docs-snippet:start surface-elevation
// VSurface(
//   elevation: VElevation.level2,
//   padding: const EdgeInsets.all(16),
//   child: const VText('Elevated content'),
// )
// docs-snippet:end surface-elevation


