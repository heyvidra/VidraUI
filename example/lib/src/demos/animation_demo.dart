part of '../../main.dart';

class _AnimationDemo extends StatefulWidget {
  const _AnimationDemo();
  @override
  State<_AnimationDemo> createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<_AnimationDemo> {
  bool _visible = true;
  int _staggerKey = 0;
  int _typewriterKey = 0;
  String _streamText = 'VidraUI design system provides premium, fluid animations.';
  bool _showCursor = true;
  int _effectsKey = 0;

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Animation', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    const VText('Visibility', variant: VTextVariant.title),
                    VFlex.horizontal(gap: 8, children: [
                      VButton(
                        onPressed: () => setState(() => _visible = !_visible),
                        variant: VButtonVariant.secondary,
                        child: VText(_visible ? 'Hide' : 'Show',
                            variant: VTextVariant.label),
                      ),
                    ]),
                    VAnimatedVisibility(
                      visible: _visible,
                      child: VSurface(
                        variant: VSurfaceVariant.elevated,
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: VText('Fade In / Out',
                              variant: VTextVariant.body),
                        ),
                      ),
                    ),
                    VAnimatedScaleFade(
                      visible: _visible,
                      child: VSurface(
                        variant: VSurfaceVariant.card,
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child:
                              VText('Scale + Fade', variant: VTextVariant.body),
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
                    const VText('Stagger', variant: VTextVariant.title),
                    VButton(
                      onPressed: () => setState(() => _staggerKey++),
                      variant: VButtonVariant.secondary,
                      child: const VText('Replay', variant: VTextVariant.label),
                    ),
                    VStagger(
                      key: ValueKey(_staggerKey),
                      children: List.generate(5, (i) {
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
                    const VText('Animated Text / 动画文本', variant: VTextVariant.title),
                    VFlex.horizontal(gap: 8, children: [
                      VButton(
                        onPressed: () => setState(() => _typewriterKey++),
                        variant: VButtonVariant.secondary,
                        size: VControlSize.sm,
                        child: const VText('Replay', variant: VTextVariant.label),
                      ),
                      VButton(
                        onPressed: () => setState(() {
                          _showCursor = !_showCursor;
                        }),
                        variant: VButtonVariant.secondary,
                        size: VControlSize.sm,
                        child: VText(_showCursor ? 'Hide Cursor' : 'Show Cursor', variant: VTextVariant.label),
                      ),
                      VButton(
                        onPressed: () => setState(() {
                          _streamText += ' Smooth additions!';
                        }),
                        variant: VButtonVariant.secondary,
                        size: VControlSize.sm,
                        child: const VText('Stream Text', variant: VTextVariant.label),
                      ),
                    ]),
                    VSurface(
                      variant: VSurfaceVariant.elevated,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: VFlex.vertical(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          gap: 8,
                          children: [
                            // Typewriter with cursor and streaming support
                            VAnimatedText(
                              _streamText,
                              key: ValueKey('typewriter_${_typewriterKey}_${_streamText.hashCode}'),
                              effect: VTextAnimationEffect.typewriter,
                              showCursor: _showCursor,
                              speed: const Duration(milliseconds: 30),
                              variant: VTextVariant.body,
                            ),
                            const VDivider(),
                            const VText('Reveal (Opacity Transition) / 渐隐渐显:', variant: VTextVariant.caption),
                            VAnimatedText(
                              'This text fades in softly when created or changed.',
                              key: ValueKey('reveal_$_typewriterKey'),
                              effect: VTextAnimationEffect.reveal,
                              variant: VTextVariant.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          // -- New effects showcase ---------------------------------------
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    const VText('All Effects / 全部效果', variant: VTextVariant.title),
                    VButton(
                      onPressed: () => setState(() => _effectsKey++),
                      variant: VButtonVariant.secondary,
                      size: VControlSize.sm,
                      child: const VText('Replay All', variant: VTextVariant.label),
                    ),
                    VSurface(
                      variant: VSurfaceVariant.elevated,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: VFlex.vertical(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          gap: 12,
                          children: [
                            _effectRow('Fade', VTextAnimationEffect.fade, 'Fade in from transparent'),
                            _effectRow('Scale', VTextAnimationEffect.scale, 'Scale up + fade in'),
                            _effectRow('Bounce', VTextAnimationEffect.bounce, 'Elastic bounce entrance'),
                            _effectRow('Scramble', VTextAnimationEffect.scramble, 'Characters converge to target'),
                            _effectRow('Wavy', VTextAnimationEffect.wavy, 'Per-character sine wave'),
                            _effectRow('Flicker', VTextAnimationEffect.flicker, 'Neon-like opacity flicker'),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ]);
  }

  Widget _effectRow(String label, VTextAnimationEffect effect, String description) {
    return VFlex.horizontal(
      crossAxisAlignment: CrossAxisAlignment.center,
      gap: 8,
      children: [
        SizedBox(
          width: 120,
          child: VAnimatedText(
            label,
            key: ValueKey('effect_${effect.name}_$_effectsKey'),
            effect: effect,
            variant: VTextVariant.label,
          ),
        ),
        Expanded(
          child: VText(
            description,
            variant: VTextVariant.caption,
            color: VTheme.of(context).colors.textMuted,
          ),
        ),
      ],
    );
  }
}

