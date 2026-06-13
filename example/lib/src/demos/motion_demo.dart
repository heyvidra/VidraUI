part of '../../main.dart';

class _MotionDemo extends StatefulWidget {
  const _MotionDemo();

  @override
  State<_MotionDemo> createState() => _MotionDemoState();
}

class _MotionDemoState extends State<_MotionDemo> {
  bool _helperVisible = true;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final slowMotion = theme.motion.copyWith(
      overlay: const VMotionSpec(
        duration: Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        reverseDuration: Duration(milliseconds: 520),
        reverseCurve: Curves.easeInCubic,
      ),
      emphasized: const VMotionSpec(
        duration: Duration(milliseconds: 900),
        curve: Curves.easeOutCubic,
        reverseDuration: Duration(milliseconds: 650),
        reverseCurve: Curves.easeInCubic,
      ),
    );

    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Motion', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    const VText('Animation helpers',
                        variant: VTextVariant.title),
                    VButton(
                      onPressed: () =>
                          setState(() => _helperVisible = !_helperVisible),
                      variant: VButtonVariant.secondary,
                      child: const VText('Toggle helpers',
                          variant: VTextVariant.label),
                    ),
                    VAnimatedBox(
                      width: _helperVisible ? 220 : 140,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colors.surfaceElevated,
                        borderRadius: BorderRadius.circular(theme.radii.md),
                      ),
                      child: const VText(
                        'Animated box',
                        variant: VTextVariant.caption,
                      ),
                    ),
                    VAnimatedScaleFade(
                      visible: _helperVisible,
                      maintainState: true,
                      child: VSurface(
                        variant: VSurfaceVariant.panel,
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: VText('Scale + fade',
                              variant: VTextVariant.caption),
                        ),
                      ),
                    ),
                    VAnimatedSlideFade(
                      visible: _helperVisible,
                      maintainState: true,
                      beginOffset: const Offset(0, 0.18),
                      child: VSurface(
                        variant: VSurfaceVariant.panel,
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: VText('Slide + fade',
                              variant: VTextVariant.caption),
                        ),
                      ),
                    ),
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
                    const VText('Overlays', variant: VTextVariant.title),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      VButton(
                        onPressed: () => _openMotionDialog(context,
                            title: 'Animated dialog'),
                        child: const VText(
                          'Open animated dialog',
                          variant: VTextVariant.label,
                        ),
                      ),
                      VButton(
                        onPressed: () => _openMotionSheet(context),
                        variant: VButtonVariant.secondary,
                        child: const VText(
                          'Open bottom sheet',
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
                    const VText('Keyboard behavior',
                        variant: VTextVariant.title),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      VButton(
                        onPressed: () => _openKeyboardSheet(
                          context,
                          VSheetKeyboardBehavior.resize,
                        ),
                        variant: VButtonVariant.secondary,
                        child:
                            const VText('Resize', variant: VTextVariant.label),
                      ),
                      VButton(
                        onPressed: () => _openKeyboardSheet(
                          context,
                          VSheetKeyboardBehavior.overlay,
                        ),
                        variant: VButtonVariant.secondary,
                        child:
                            const VText('Overlay', variant: VTextVariant.label),
                      ),
                      VButton(
                        onPressed: () => _openKeyboardSheet(
                          context,
                          VSheetKeyboardBehavior.none,
                        ),
                        variant: VButtonVariant.secondary,
                        child: const VText('None', variant: VTextVariant.label),
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
                    const VText('Scoped motion', variant: VTextVariant.title),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      Builder(
                        builder: (scopedContext) {
                          return VButton(
                            onPressed: () => _openMotionDialog(
                              scopedContext,
                              title: 'Normal motion',
                            ),
                            variant: VButtonVariant.secondary,
                            child: const VText(
                              'Normal dialog',
                              variant: VTextVariant.label,
                            ),
                          );
                        },
                      ),
                      VMotionScope(
                        motion: theme.motion.copyWith(reducedMotion: true),
                        child: Builder(
                          builder: (scopedContext) {
                            return VButton(
                              onPressed: () => _openMotionDialog(
                                scopedContext,
                                title: 'Reduced motion',
                              ),
                              variant: VButtonVariant.secondary,
                              child: const VText(
                                'Reduced dialog',
                                variant: VTextVariant.label,
                              ),
                            );
                          },
                        ),
                      ),
                      VMotionScope(
                        motion: slowMotion,
                        child: Builder(
                          builder: (scopedContext) {
                            return VButton(
                              onPressed: () => _openMotionSheet(scopedContext),
                              variant: VButtonVariant.secondary,
                              child: const VText(
                                'Open slow bottom sheet',
                                variant: VTextVariant.label,
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
                  ]),
            ),
          ),
        ]);
  }

  static void _openMotionDialog(
    BuildContext context, {
    required String title,
  }) {
    VDialog.show<void>(
      context,
      builder: (ctx) {
        return VDialogSurface(
          child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 16,
              children: [
                VText(title, variant: VTextVariant.title),
                const VText(
                  'Dialog entrance and close are driven by motion.overlay.',
                  variant: VTextVariant.body,
                ),
                VFlex.horizontal(
                  gap: 8,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    VButton(
                      onPressed: () => VDialogScope.of<void>(ctx)(null),
                      child: const VText('Close', variant: VTextVariant.label),
                    ),
                  ],
                ),
              ]),
        );
      },
    );
  }

  static void _openMotionSheet(BuildContext context) {
    VSheet.show<void>(
      context,
      edge: VSheetEdge.bottom,
      builder: (ctx) {
        return VSheetSurface(
          edge: VSheetEdge.bottom,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: VFlex.vertical(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                gap: 16,
                children: [
                  const VText('Animated bottom sheet',
                      variant: VTextVariant.title),
                  const VText(
                    'The sheet slides from the bottom and closes the same way.',
                    variant: VTextVariant.body,
                  ),
                  VButton(
                    onPressed: () => VSheetScope.of<void>(ctx)(null),
                    child: const VText('Close', variant: VTextVariant.label),
                  ),
                ]),
          ),
        );
      },
    );
  }

  static void _openKeyboardSheet(
    BuildContext context,
    VSheetKeyboardBehavior behavior,
  ) {
    VSheet.show<void>(
      context,
      edge: VSheetEdge.bottom,
      keyboardBehavior: behavior,
      builder: (ctx) {
        return VSheetSurface(
          edge: VSheetEdge.bottom,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: VFlex.vertical(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                gap: 16,
                children: [
                  VText(
                    'Keyboard: ${behavior.name}',
                    variant: VTextVariant.title,
                  ),
                  const VTextField(
                    label: 'Message',
                    hint: 'Focus to open keyboard',
                    minLines: 2,
                    maxLines: 4,
                  ),
                  VButton(
                    onPressed: () => VSheetScope.of<void>(ctx)(null),
                    child: const VText('Close', variant: VTextVariant.label),
                  ),
                ]),
          ),
        );
      },
    );
  }
}


// docs-snippet:start motion-basic
// VMotionScope(
//   motion: VTheme.of(context).motion.copyWith(reducedMotion: true),
//   child: VAnimatedScaleFade(
//     visible: visible,
//     child: const VSurface(child: VText('Motion-aware content')),
//   ),
// )
// docs-snippet:end motion-basic

