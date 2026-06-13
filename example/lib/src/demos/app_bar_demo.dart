part of '../../main.dart';

class _AppBarDemo extends StatelessWidget {
  const _AppBarDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('App Bar', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VAppBar(
                  leading:
                      VIcon(LucideIcons.chevronLeft, semanticLabel: 'Back'),
                  title: const VText('Title'),
                  variant: VAppBarVariant.flat,
                  actions: [
                    VIcon(LucideIcons.settings, semanticLabel: 'Settings')
                  ],
                ),
              ],
            ),
          ),
          const VText('Sliver App Bar', variant: VTextVariant.title),
          SizedBox(
            height: 300,
            child: VSurface(
              variant: VSurfaceVariant.card,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomScrollView(
                  slivers: [
                    VAppBar.sliver(
                      leading:
                          VIcon(LucideIcons.chevronLeft, semanticLabel: 'Back'),
                      title: const VText('Profile'),
                      expandedHeight: 160,
                      flexibleSpace: Container(
                        color: VTheme.of(context)
                            .colors
                            .actionPrimary
                            .withValues(alpha: 0.2),
                        child: const Center(
                            child: VText('Flexible Space',
                                variant: VTextVariant.title)),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: VFlex.vertical(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          gap: 8,
                          children: List.generate(20, (i) {
                            return VSurface(
                              variant: VSurfaceVariant.elevated,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: VText('Item ${i + 1}',
                                    variant: VTextVariant.body),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]);
  }
}

