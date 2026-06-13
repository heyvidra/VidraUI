part of '../../main.dart';

class _OverlayDemo extends StatelessWidget {
  const _OverlayDemo();

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Overlay', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    const VText('Toast & Dialog', variant: VTextVariant.title),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      VButton(
                        onPressed: () {
                          VToast.show(
                            context,
                            message: 'Item saved successfully',
                            variant: VToastVariant.success,
                          );
                        },
                        variant: VButtonVariant.secondary,
                        child: const VText('Show Toast',
                            variant: VTextVariant.label),
                      ),
                      VButton(
                        onPressed: () {
                          VToast.show(
                            context,
                            message: 'Stacked toast ${DateTime.now().millisecond}',
                            variant: VToastVariant.info,
                            stackMode: VToastStackMode.stack,
                          );
                        },
                        variant: VButtonVariant.secondary,
                        child: const VText('Stack Toast',
                            variant: VTextVariant.label),
                      ),
                      VButton(
                        onPressed: () {
                          VToast.show(
                            context,
                            message: 'Archived item',
                            variant: VToastVariant.info,
                            action: (context, dismiss) => VButton(
                              size: VControlSize.sm,
                              variant: VButtonVariant.secondary,
                              onPressed: dismiss,
                              child: const VText(
                                'Undo',
                                variant: VTextVariant.label,
                              ),
                            ),
                          );
                        },
                        variant: VButtonVariant.secondary,
                        child: const VText(
                          'Action Toast',
                          variant: VTextVariant.label,
                        ),
                      ),
                      VButton(
                        onPressed: () {
                          VToast.show(
                            context,
                            message: 'Gradient toast',
                            background: VBackground.gradient(
                              LinearGradient(
                                colors: [
                                  theme.colors.surfaceElevated,
                                  theme.colors.surfaceHover,
                                ],
                              ),
                            ),
                          );
                        },
                        variant: VButtonVariant.secondary,
                        child: const VText(
                          'Gradient Toast',
                          variant: VTextVariant.label,
                        ),
                      ),
                      VButton(
                        onPressed: () => _showConfirm(context),
                        child: const VText('Show Dialog',
                            variant: VTextVariant.label),
                      ),
                      VButton(
                        onPressed: () => _showGradientDialog(context),
                        child: const VText(
                          'Gradient Dialog',
                          variant: VTextVariant.label,
                        ),
                      ),
                      VButton(
                        onPressed: () {
                          VPopover.show(
                            context,
                            alignment: Alignment.topRight,
                            offset: const Offset(-24, 120),
                            surfaceBackground: VBackground.gradient(
                              LinearGradient(
                                colors: [
                                  theme.colors.surface,
                                  theme.colors.surfaceElevated,
                                ],
                              ),
                            ),
                            builder: (_) => const VText(
                              'Popover surface',
                              variant: VTextVariant.body,
                            ),
                          );
                        },
                        variant: VButtonVariant.secondary,
                        child: const VText('Show Popover',
                            variant: VTextVariant.label),
                      ),
                      VButton(
                        onPressed: () {
                          VPopover.show(
                            context,
                            alignment: Alignment.topRight,
                            offset: const Offset(-24, 176),
                            surfaceBackground: VBackground.gradient(
                              LinearGradient(
                                colors: [
                                  theme.colors.actionPrimary,
                                  theme.colors.actionPrimaryPressed,
                                ],
                              ),
                            ),
                            builder: (_) => VText(
                              'Gradient popover',
                              variant: VTextVariant.body,
                              color: theme.colors.actionPrimaryText,
                            ),
                          );
                        },
                        variant: VButtonVariant.secondary,
                        child: const VText(
                          'Gradient Popover',
                          variant: VTextVariant.label,
                        ),
                      ),
                    ]),
                  ]),
            ),
          ),
        ]);
  }

  static void _showConfirm(BuildContext context) {
    VDialog.show<void>(
      context,
      builder: (ctx) {
        return VAlertDialog(
          title: 'Delete item?',
          body: 'This action cannot be undone.',
          closable: true,
          onClose: () => VDialogScope.of<void>(ctx)(null),
          actions: [
            VButton(
              onPressed: () => VDialogScope.of<void>(ctx)(null),
              variant: VButtonVariant.secondary,
              child: const VText('Cancel', variant: VTextVariant.label),
            ),
            VButton(
              onPressed: () {
                VDialogScope.of<void>(ctx)(null);
                VToast.show(
                  context,
                  message: 'Item deleted',
                  variant: VToastVariant.info,
                );
              },
              variant: VButtonVariant.danger,
              child: const VText('Delete', variant: VTextVariant.label),
            ),
          ],
        );
      },
    );
  }

  static void _showGradientDialog(BuildContext context) {
    final theme = VTheme.of(context);
    VDialog.show<void>(
      context,
      builder: (ctx) {
        return VDialogSurface(
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
          child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 16,
              children: [
                VText(
                  'Gradient dialog',
                  variant: VTextVariant.title,
                  color: theme.colors.actionPrimaryText,
                ),
                VText(
                  'The gradient is applied to the dialog surface only.',
                  variant: VTextVariant.body,
                  color: theme.colors.actionPrimaryText,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: VButton(
                    onPressed: () => VDialogScope.of<void>(ctx)(null),
                    variant: VButtonVariant.secondary,
                    child: const VText('Close', variant: VTextVariant.label),
                  ),
                ),
              ]),
        );
      },
    );
  }
}

// docs-snippet:start overlay-basic
// VToast.show(
//   context,
//   message: 'Item saved successfully',
//   variant: VToastVariant.success,
// )
// docs-snippet:end overlay-basic
