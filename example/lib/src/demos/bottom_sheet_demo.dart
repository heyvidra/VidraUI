part of '../../main.dart';

class _BottomSheetDemo extends StatefulWidget {
  const _BottomSheetDemo();

  @override
  State<_BottomSheetDemo> createState() => _BottomSheetDemoState();
}

class _BottomSheetDemoState extends State<_BottomSheetDemo> {
  bool _pushedOpen = false;

  void _openEdgeSheet(
    BuildContext context, {
    required VSheetEdge edge,
    required String title,
  }) {
    final isHorizontal = edge == VSheetEdge.left || edge == VSheetEdge.right;
    VSheet.show<void>(
      context,
      edge: edge,
      size: VSheetSize.auto,
      minExtent: isHorizontal ? 280 : null,
      builder: (ctx) => VSheetSurface(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 16,
              children: [
                VText(title, variant: VTextVariant.heading),
                const VText(
                  'Sheets can enter from any screen edge.',
                  variant: VTextVariant.body,
                ),
                VButton(
                  onPressed: () => VSheetScope.of<void>(ctx)(null),
                  child: const VText('Close', variant: VTextVariant.label),
                ),
              ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Sheet', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    const VText('Modal sheets', variant: VTextVariant.title),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      VButton(
                        onPressed: () {
                          VSheet.show<void>(
                            context,
                            edge: VSheetEdge.bottom,
                            size: VSheetSize.auto,
                            builder: (ctx) => VSheetSurface(
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: VFlex.vertical(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    gap: 16,
                                    children: [
                                      const VText(
                                        'Auto height',
                                        variant: VTextVariant.heading,
                                      ),
                                      const VText(
                                        'This sheet grows to fit its content.',
                                        variant: VTextVariant.body,
                                      ),
                                      VButton(
                                        onPressed: () =>
                                            VSheetScope.of<void>(ctx)(null),
                                        child: const VText(
                                          'Close',
                                          variant: VTextVariant.label,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        },
                        variant: VButtonVariant.secondary,
                        child: const VText('Bottom sheet',
                            variant: VTextVariant.label),
                      ),
                      VButton(
                        onPressed: () => _openEdgeSheet(
                          context,
                          edge: VSheetEdge.top,
                          title: 'Top sheet',
                        ),
                        variant: VButtonVariant.secondary,
                        child: const VText(
                          'Top sheet',
                          variant: VTextVariant.label,
                        ),
                      ),
                      VButton(
                        onPressed: () => _openEdgeSheet(
                          context,
                          edge: VSheetEdge.left,
                          title: 'Left sheet',
                        ),
                        variant: VButtonVariant.secondary,
                        child: const VText(
                          'Left sheet',
                          variant: VTextVariant.label,
                        ),
                      ),
                      VButton(
                        onPressed: () => _openEdgeSheet(
                          context,
                          edge: VSheetEdge.right,
                          title: 'Right sheet',
                        ),
                        variant: VButtonVariant.secondary,
                        child: const VText(
                          'Right sheet',
                          variant: VTextVariant.label,
                        ),
                      ),
                      VButton(
                        onPressed: () {
                          VSheet.show<void>(
                            context,
                            edge: VSheetEdge.bottom,
                            size: VSheetSize.auto,
                            surfaceBackground: VBackground.gradient(
                              LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  theme.colors.actionPrimary,
                                  theme.colors.actionPrimaryPressed,
                                ],
                              ),
                            ),
                            builder: (ctx) => VSheetSurface(
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: VFlex.vertical(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    gap: 16,
                                    children: [
                                      VText(
                                        'Gradient sheet',
                                        variant: VTextVariant.heading,
                                        color: theme.colors.actionPrimaryText,
                                      ),
                                      VText(
                                        'surfaceBackground changes only the sheet surface.',
                                        variant: VTextVariant.body,
                                        color: theme.colors.actionPrimaryText,
                                      ),
                                      VButton(
                                        onPressed: () =>
                                            VSheetScope.of<void>(ctx)(null),
                                        variant: VButtonVariant.secondary,
                                        child: const VText(
                                          'Close',
                                          variant: VTextVariant.label,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        },
                        child: const VText(
                          'Gradient sheet',
                          variant: VTextVariant.label,
                        ),
                      ),
                      VButton(
                        onPressed: () {
                          VSheet.show<void>(
                            context,
                            edge: VSheetEdge.bottom,
                            size: VSheetSize.auto,
                            minExtent: 280,
                            builder: (ctx) => VSheetSurface(
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: VFlex.vertical(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    gap: 16,
                                    children: [
                                      const VText(
                                        'Minimum height',
                                        variant: VTextVariant.heading,
                                      ),
                                      const VText(
                                        'Short content can still reserve useful space.',
                                        variant: VTextVariant.body,
                                      ),
                                      VButton(
                                        onPressed: () =>
                                            VSheetScope.of<void>(ctx)(null),
                                        child: const VText(
                                          'Close',
                                          variant: VTextVariant.label,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        },
                        variant: VButtonVariant.secondary,
                        child: const VText(
                          'Min-height sheet',
                          variant: VTextVariant.label,
                        ),
                      ),
                    ]),
                  ]),
            ),
          ),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    const VText('Pushed layout', variant: VTextVariant.title),
                    SizedBox(
                      height: 320,
                      child: VScaffold(
                        background: VBackground.gradient(
                          LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              theme.colors.background,
                              theme.colors.surfaceElevated,
                            ],
                          ),
                        ),
                        body: VSurface(
                          variant: VSurfaceVariant.panel,
                          child: Center(
                            child: VText(
                              _pushedOpen
                                  ? 'Body is constrained above the sheet.'
                                  : 'Body fills the available space.',
                              variant: VTextVariant.body,
                            ),
                          ),
                        ),
                        footer: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: VButton(
                            onPressed: () =>
                                setState(() => _pushedOpen = !_pushedOpen),
                            variant: VButtonVariant.secondary,
                            child: VText(
                              _pushedOpen
                                  ? 'Hide pushed sheet'
                                  : 'Show pushed sheet',
                              variant: VTextVariant.label,
                            ),
                          ),
                        ),
                        bottomSheet: _pushedOpen
                            ? VSheetSurface(edge: VSheetEdge.bottom,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: VFlex.vertical(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      gap: 12,
                                      children: const [
                                        VText(
                                          'Pushed bottom sheet',
                                          variant: VTextVariant.title,
                                        ),
                                        VText(
                                          'This sheet participates in scaffold layout.',
                                          variant: VTextVariant.body,
                                        ),
                                      ]),
                                ),
                              )
                            : null,
                      ),
                    ),
                  ]),
            ),
          ),
        ]);
  }
}

