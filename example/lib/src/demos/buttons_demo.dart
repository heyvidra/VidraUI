part of '../../main.dart';

class _ButtonsDemo extends StatelessWidget {
  const _ButtonsDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        gap: 16,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const VText('Buttons', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  gap: 12,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const VText('Variants', variant: VTextVariant.title),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [
                        VButton(
                          onPressed: _noop,
                          child: VText('Primary', variant: VTextVariant.label),
                        ),
                        VButton(
                          onPressed: _noop,
                          variant: VButtonVariant.secondary,
                          child:
                              VText('Secondary', variant: VTextVariant.label),
                        ),
                        VButton(
                          onPressed: _noop,
                          variant: VButtonVariant.danger,
                          child: VText('Danger', variant: VTextVariant.label),
                        ),
                      ],
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: VButton(
                        onPressed: null,
                        child: VText('Disabled', variant: VTextVariant.label),
                      ),
                    ),
                    const VText('Loading', variant: VTextVariant.title),
                    Wrap(spacing: 8, runSpacing: 8, children: const [
                      VButton(
                        loading: true,
                        onPressed: _noop,
                        child: VText('Saving…', variant: VTextVariant.label),
                      ),
                      VButton(
                        loading: true,
                        onPressed: _noop,
                        variant: VButtonVariant.secondary,
                        loadingSemanticLabel: 'Processing',
                        child: VText('Loading', variant: VTextVariant.label),
                      ),
                    ]),
                    const VText('Sizes', variant: VTextVariant.title),
                    Wrap(spacing: 8, runSpacing: 8, children: const [
                      VButton(
                        size: VControlSize.sm,
                        onPressed: _noop,
                        child: VText('Small', variant: VTextVariant.label),
                      ),
                      VButton(
                        onPressed: _noop,
                        child: VText('Medium', variant: VTextVariant.label),
                      ),
                      VButton(
                        size: VControlSize.lg,
                        onPressed: _noop,
                        child: VText('Large', variant: VTextVariant.label),
                      ),
                    ]),
                    const VText('Icons', variant: VTextVariant.title),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      VButton(
                        leadingIcon: VIcon(LucideIcons.plus),
                        onPressed: _noop,
                        child:
                            const VText('Create', variant: VTextVariant.label),
                      ),
                      VButton(
                        // appearance: _BrandGradientAppearance(),
                        // loading: true,
                        // loadingIndicator: VSpinner(size: 16, color: VidraFlowPalette.white),
                        leadingIcon: VIcon(LucideIcons.circleDot),
                        onPressed: _noop,
                        child: VText('Start transcription',
                            variant: VTextVariant.label),
                      ),
                      VButton(
                        trailingIcon: VIcon(LucideIcons.arrowRight),
                        variant: VButtonVariant.secondary,
                        onPressed: _noop,
                        child: const VText('Continue',
                            variant: VTextVariant.label),
                      ),
                      VButton(
                        shape: VButtonShape.circle,
                        semanticLabel: 'Search',
                        onPressed: _noop,
                        child: VIcon(LucideIcons.search),
                      ),
                      VButton(
                        shape: VButtonShape.circle,
                        size: VControlSize.sm,
                        variant: VButtonVariant.secondary,
                        semanticLabel: 'Settings',
                        onPressed: _noop,
                        child: VIcon(LucideIcons.settings),
                      ),
                    ]),
                    const VText('Shape: None (Text Buttons)', variant: VTextVariant.title),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      VButton(
                        shape: VButtonShape.none,
                        onPressed: _noop,
                        child: const VText('Text Button', variant: VTextVariant.label),
                      ),
                      VButton(
                        shape: VButtonShape.none,
                        variant: VButtonVariant.secondary,
                        onPressed: _noop,
                        child: const VText('Secondary Text', variant: VTextVariant.label),
                      ),
                      VButton(
                        shape: VButtonShape.none,
                        variant: VButtonVariant.danger,
                        onPressed: _noop,
                        child: const VText('Danger Text', variant: VTextVariant.label),
                      ),
                      VButton(
                        shape: VButtonShape.none,
                        leadingIcon: VIcon(LucideIcons.download),
                        onPressed: _noop,
                        child: const VText('Download', variant: VTextVariant.label),
                      ),
                      VButton(
                        shape: VButtonShape.none,
                        trailingIcon: VIcon(LucideIcons.externalLink),
                        onPressed: _noop,
                        child: const VText('Open', variant: VTextVariant.label),
                      ),
                      VButton(
                        shape: VButtonShape.none,
                        semanticLabel: 'Delete',
                        onPressed: _noop,
                        child: VIcon(LucideIcons.trash),
                      ),
                      VButton(
                        shape: VButtonShape.none,
                        semanticLabel: 'Edit',
                        onPressed: _noop,
                        child: VIcon(LucideIcons.edit),
                      ),
                    ]),
                    SizedBox(
                        width: double.infinity,
                        child: VButton(
                          size: VControlSize.lg,
                          onPressed: _noop,
                          child: VText('Large', variant: VTextVariant.label),
                        )),
                  ]),
            ),
          ),
        ]);
  }

  static void _noop() {}
}


// docs-snippet:start button-variants
// VFlex.horizontal(
//   gap: 8,
//   children: const [
//     VButton(onPressed: save, child: VText('Primary')),
//     VButton(
//       onPressed: cancel,
//       variant: VButtonVariant.secondary,
//       child: VText('Secondary'),
//     ),
//     VButton(
//       onPressed: delete,
//       variant: VButtonVariant.danger,
//       child: VText('Danger'),
//     ),
//   ],
// )
// docs-snippet:end button-variants

// docs-snippet:start button-icon-loading
// VFlex.horizontal(
//   gap: 8,
//   children: [
//     VButton(
//       leadingIcon: VIcon(LucideIcons.save),
//       loading: saving,
//       loadingSemanticLabel: 'Saving changes',
//       onPressed: saving ? null : save,
//       child: const VText('Save', variant: VTextVariant.label),
//     ),
//     VButton(
//       shape: VButtonShape.circle,
//       semanticLabel: 'Search',
//       onPressed: search,
//       child: VIcon(LucideIcons.search),
//     ),
//   ],
// )
// docs-snippet:end button-icon-loading

