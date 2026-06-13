part of '../../main.dart';

class _AnimatedTextDemo extends StatefulWidget {
  const _AnimatedTextDemo();

  @override
  State<_AnimatedTextDemo> createState() => _AnimatedTextDemoState();
}

class _AnimatedTextDemoState extends State<_AnimatedTextDemo> {
  int _replayKey = 0;
  bool _showCursor = true;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('VAnimatedText', variant: VTextVariant.heading),
        VText(
          'Unified animated text component. One widget — 8 effects. '
          'Each effect is a self-contained strategy, added via the factory without '
          'modifying the core component.',
          variant: VTextVariant.body,
          color: theme.colors.textMuted,
        ),

        // Controls
        VFlex.horizontal(gap: 8, children: [
          VButton(
            onPressed: () => setState(() => _replayKey++),
            variant: VButtonVariant.secondary,
            size: VControlSize.sm,
            child: const VText('Replay All', variant: VTextVariant.label),
          ),
          VButton(
            onPressed: () => setState(() => _showCursor = !_showCursor),
            variant: VButtonVariant.secondary,
            size: VControlSize.sm,
            child: VText(
              _showCursor ? 'Hide Cursor' : 'Show Cursor',
              variant: VTextVariant.label,
            ),
          ),
        ]),

        // ---- Typewriter ----
        _effectCard(
          theme,
          'typewriter',
          'Typewriter / 打字机',
          'Letter-by-letter typing with cursor and streaming optimisation. '
          'Appending to text continues from the prefix without restarting.',
          children: [
            VAnimatedText(
              'The quick brown fox jumps over the lazy dog.',
              key: ValueKey('typewriter-$_replayKey'),
              effect: VTextAnimationEffect.typewriter,
              showCursor: _showCursor,
              speed: const Duration(milliseconds: 30),
              variant: VTextVariant.body,
            ),
          ],
        ),

        // ---- Reveal ----
        _effectCard(
          theme,
          'reveal',
          'Reveal / 渐显',
          'Soft opacity transition from 70% to 100% using motion tokens. '
          'Subtle and non-distracting — ideal for content that changes in place.',
          children: [
            VAnimatedText(
              'This text reveals softly each time it appears or changes.',
              key: ValueKey('reveal-$_replayKey'),
              effect: VTextAnimationEffect.reveal,
              variant: VTextVariant.body,
            ),
          ],
        ),

        // ---- Fade ----
        _effectCard(
          theme,
          'fade',
          'Fade / 淡入',
          'Standard 0 → 1 opacity entrance. Clean, predictable, universally '
          'understood.',
          children: [
            VAnimatedText(
              'Fading in from nothing to full presence.',
              key: ValueKey('fade-$_replayKey'),
              effect: VTextAnimationEffect.fade,
              variant: VTextVariant.body,
            ),
          ],
        ),

        // ---- Scale ----
        _effectCard(
          theme,
          'scale',
          'Scale / 缩放',
          'Text scales from 95% to 100% while fading in. Adds a subtle '
          '"growing into place" feel — great for headings and emphasis.',
          children: [
            VAnimatedText(
              'Scaling up with quiet confidence.',
              key: ValueKey('scale-$_replayKey'),
              effect: VTextAnimationEffect.scale,
              variant: VTextVariant.title,
            ),
          ],
        ),

        // ---- Bounce ----
        _effectCard(
          theme,
          'bounce',
          'Bounce / 弹跳',
          'Elastic entrance — text drops from above and springs into position. '
          'Playful and energetic; use for chat messages and notifications.',
          children: [
            VAnimatedText(
              'Bouncing in with elastic energy!',
              key: ValueKey('bounce-$_replayKey'),
              effect: VTextAnimationEffect.bounce,
              variant: VTextVariant.title,
            ),
          ],
        ),

        // ---- Scramble ----
        _effectCard(
          theme,
          'scramble',
          'Scramble / 乱码收敛',
          'Random characters gradually converge to the target. '
          'ASCII letters and digits scramble; non-ASCII characters are preserved.',
          children: [
            VAnimatedText(
              'Hello, VidraUI! 123',
              key: ValueKey('scramble-$_replayKey'),
              effect: VTextAnimationEffect.scramble,
              variant: VTextVariant.body,
            ),
          ],
        ),

        // ---- Wavy ----
        _effectCard(
          theme,
          'wavy',
          'Wavy / 波浪',
          'Per-character sine wave oscillation. No layout shift — purely Transform.translate. '
          'Loops continuously while visible.',
          children: [
            VAnimatedText(
              '~ W A V Y ~',
              key: ValueKey('wavy-$_replayKey'),
              effect: VTextAnimationEffect.wavy,
              variant: VTextVariant.title,
            ),
          ],
        ),

        // ---- Flicker ----
        _effectCard(
          theme,
          'flicker',
          'Flicker / 闪烁',
          'Neon-sign flicker effect. Pre-computed opacity sequence driven by a '
          'single repeating AnimationController — no per-frame random calls.',
          children: [
            VAnimatedText(
              'NEON DREAMS',
              key: ValueKey('flicker-$_replayKey'),
              effect: VTextAnimationEffect.flicker,
              variant: VTextVariant.heading,
            ),
          ],
        ),
      ],
    );
  }

  Widget _effectCard(
    VThemeData theme,
    String enumName,
    String title,
    String description, {
    required List<Widget> children,
  }) {
    return VSurface(
      variant: VSurfaceVariant.card,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: VFlex.vertical(
          crossAxisAlignment: CrossAxisAlignment.start,
          gap: 8,
          children: [
            VFlex.horizontal(
              crossAxisAlignment: CrossAxisAlignment.center,
              gap: 8,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: theme.colors.actionPrimary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(theme.radii.xs),
                  ),
                  child: VText(
                    'VTextAnimationEffect.$enumName',
                    variant: VTextVariant.caption,
                    color: theme.colors.actionPrimary,
                  ),
                ),
                Expanded(
                  child: VText(title, variant: VTextVariant.subtitle),
                ),
              ],
            ),
            VText(
              description,
              variant: VTextVariant.caption,
              color: theme.colors.textMuted,
            ),
            const VDivider(),
            ...children,
          ],
        ),
      ),
    );
  }
}
