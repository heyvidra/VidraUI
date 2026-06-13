part of '../../main.dart';

class _AppearanceDemo extends StatelessWidget {
  const _AppearanceDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Appearance', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 16,
                  children: [
                    const VText('Default (none)', variant: VTextVariant.title),
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
                      VButton(
                        onPressed: _noop,
                        variant: VButtonVariant.danger,
                        child: VText('Danger', variant: VTextVariant.label),
                      ),
                    ]),
                    const VText('Flat', variant: VTextVariant.title),
                    VAppearanceScope(
                      appearance: VFlatAppearance(),
                      child: VFlex.horizontal(
                        gap: 8,
                        children: [
                          VButton(
                            onPressed: _noop,
                            child:
                                VText('Primary', variant: VTextVariant.label),
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
                    ),
                    const VText('Soft', variant: VTextVariant.title),
                    VAppearanceScope(
                      appearance: VSoftAppearance(),
                      child: VFlex.horizontal(
                        gap: 8,
                        children: [
                          VButton(
                            onPressed: _noop,
                            child:
                                VText('Primary', variant: VTextVariant.label),
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
                    ),
                    const VText('Outlined', variant: VTextVariant.title),
                    VAppearanceScope(
                      appearance: VOutlinedAppearance(),
                      child: VFlex.horizontal(
                        gap: 8,
                        children: [
                          VButton(
                            onPressed: _noop,
                            child:
                                VText('Primary', variant: VTextVariant.label),
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
                    ),
                    const VText('Glass', variant: VTextVariant.title),
                    VAppearanceScope(
                      appearance: ExampleGlassmorphismAppearance(),
                      child: VFlex.horizontal(
                        gap: 8,
                        children: [
                          VButton(
                            onPressed: _noop,
                            child:
                                VText('Primary', variant: VTextVariant.label),
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
                    ),
                    const VText('Neumorphic', variant: VTextVariant.title),
                    VAppearanceScope(
                      appearance: ExampleNeumorphismAppearance(),
                      child: VFlex.horizontal(
                        gap: 8,
                        children: [
                          VButton(
                            onPressed: _noop,
                            child:
                                VText('Primary', variant: VTextVariant.label),
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
                    ),
                  ]),
            ),
          ),
        ]);
  }

  static void _noop() {}
}


// docs-snippet:start app-bar-basic
// VAppBar(
//   leading: VIcon(LucideIcons.chevronLeft, semanticLabel: 'Back'),
//   title: const VText('Title'),
//   actions: [VIcon(LucideIcons.settings, semanticLabel: 'Settings')],
// )
// docs-snippet:end app-bar-basic

// docs-snippet:start app-shell-basic
// void main() {
//   runApp(
//     VidraApp.navigator(
//       title: 'My App',
//       theme: VThemeData.light(),
//       darkTheme: VThemeData.dark(),
//       home: const MyHomePage(),
//     ),
//   );
// }
// docs-snippet:end app-shell-basic

// docs-snippet:start appearance-basic
// VAppearanceScope(
//   appearance: const VSoftAppearance(),
//   child: VButton(
//     onPressed: save,
//     child: const VText('Save', variant: VTextVariant.label),
//   ),
// )
// docs-snippet:end appearance-basic

