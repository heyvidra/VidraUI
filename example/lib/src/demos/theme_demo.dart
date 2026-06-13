part of '../../main.dart';

class _ThemeDemo extends StatelessWidget {
  const _ThemeDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Theme Override', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 16,
                  children: [
                    const VText(
                      'Default Button Theme',
                      variant: VTextVariant.title,
                    ),
                    VFlex.horizontal(gap: 8, children: const [
                      VButton(
                        onPressed: _noop,
                        child: VText('Primary', variant: VTextVariant.label),
                      ),
                      VButton(
                        onPressed: _noop,
                        variant: VButtonVariant.secondary,
                        child: VText('Secondary', variant: VTextVariant.label),
                      ),
                    ]),
                    const VText(
                      'Scoped Semantic Theme (success)',
                      variant: VTextVariant.title,
                    ),
                    VTheme.override(
                      colors: (colors) => colors.copyWith(
                        actionPrimary: colors.success,
                        actionPrimaryHover: colors.successHover,
                        actionPrimaryPressed: colors.successHover,
                      ),
                      child: VFlex.horizontal(gap: 8, children: const [
                        VButton(
                          onPressed: _noop,
                          child: VText('Save', variant: VTextVariant.label),
                        ),
                        VButton(
                          onPressed: _noop,
                          variant: VButtonVariant.secondary,
                          child:
                              VText('Secondary', variant: VTextVariant.label),
                        ),
                      ]),
                    ),
                    const VText(
                      'Button-only Theme (purple)',
                      variant: VTextVariant.title,
                    ),
                    VButtonTheme.override(
                      data: (_, button) => button.copyWith(
                        primaryBackground: VStateProperty.states(
                          normal: const Color(0xFF7C3AED),
                          hovered: const Color(0xFF6D28D9),
                          pressed: const Color(0xFF5B21B6),
                        ),
                        primaryBorder: VStateProperty.states(
                          normal: const Color(0xFF7C3AED),
                          hovered: const Color(0xFF6D28D9),
                          pressed: const Color(0xFF5B21B6),
                        ),
                      ),
                      child: VFlex.horizontal(gap: 8, children: const [
                        VButton(
                          onPressed: _noop,
                          child: VText('Purple', variant: VTextVariant.label),
                        ),
                        VButton(
                          onPressed: _noop,
                          variant: VButtonVariant.secondary,
                          child:
                              VText('Secondary', variant: VTextVariant.label),
                        ),
                      ]),
                    ),
                    const VText(
                      'Custom Surface Theme (invert)',
                      variant: VTextVariant.title,
                    ),
                    VSurfaceTheme(
                      data: VSurfaceTokens.fromColors(VColors.dark()),
                      child: VFlex.horizontal(gap: 8, children: const [
                        Expanded(
                          child: VSurface(
                            variant: VSurfaceVariant.elevated,
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: VText(
                                'Dark surface override',
                                variant: VTextVariant.caption,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ]),
            ),
          ),
        ]);
  }

  static void _noop() {}
}


// docs-snippet:start theme-basic
// VTheme.override(
//   colors: (colors) => colors.copyWith(
//     actionPrimary: colors.success,
//     actionPrimaryHover: colors.successHover,
//     actionPrimaryPressed: colors.successHover,
//   ),
//   child: child,
// )
// docs-snippet:end theme-basic

// docs-snippet:start theme-component-override
// VButtonTheme.override(
//   data: (theme, button) => button.copyWith(
//     primaryBackground: VStateProperty.states(
//       normal: theme.colors.success,
//       hovered: theme.colors.successHover,
//     ),
//   ),
//   child: const VButton(
//     onPressed: save,
//     child: VText('Save', variant: VTextVariant.label),
//   ),
// )
// docs-snippet:end theme-component-override

// docs-snippet:start theme-token-override
// VTokenTheme<VButtonTokens>.override(
//   data: (theme, button) => button.copyWith(
//     focusRing: theme.colors.success,
//   ),
//   fallback: (theme) => theme.components.button,
//   child: child,
// )
// docs-snippet:end theme-token-override

