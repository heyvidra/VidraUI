part of '../../main.dart';

class _AnimatedSwitcherDemo extends StatefulWidget {
  const _AnimatedSwitcherDemo();
  @override
  State<_AnimatedSwitcherDemo> createState() => _AnimatedSwitcherDemoState();
}

class _AnimatedSwitcherDemoState extends State<_AnimatedSwitcherDemo> {
  final _pageCtrl = VAnimatedSwitcherController(count: 4);
  final _likeCtrl = VAnimatedSwitcherController(count: 2);
  VContentTransition _transition = VContentTransition.slide;

  @override
  void initState() {
    super.initState();
    _pageCtrl.addListener(_rebuild);
    _likeCtrl.addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  static final _pages = <Color>[
    const Color(0xFF3B82F6),
    const Color(0xFF10B981),
    const Color(0xFFF59E0B),
    const Color(0xFF8B5CF6),
  ]
      .map((c) => DecoratedBox(
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: c.withValues(alpha: 0.3)),
            ),
            child: const SizedBox(
              height: 160,
              child: Center(child: VText('Page', variant: VTextVariant.title)),
            ),
          ))
      .toList();

  @override
  void dispose() {
    _pageCtrl.dispose();
    _likeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('Animated Switcher', variant: VTextVariant.heading),
        const VText(
          'Switch between children with animated transitions.\nDirection is auto-inferred — next slides left, previous slides right.',
          variant: VTextVariant.caption,
        ),

        // Controls
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.vertical(
            gap: 12,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              VFlex.horizontal(
                gap: 8,
                children: [
                  const VText('Transition:', variant: VTextVariant.label),
                  for (final t in VContentTransition.values)
                    VButton(
                      variant: _transition == t
                          ? VButtonVariant.primary
                          : VButtonVariant.secondary,
                      size: VControlSize.sm,
                      onPressed: () => setState(() => _transition = t),
                      child: VText(t.name, variant: VTextVariant.caption),
                    ),
                ],
              ),
            ],
          ),
        ),

        // Page nav buttons
        VFlex.horizontal(
          gap: 8,
          children: [
            VButton(
              variant: VButtonVariant.secondary,
              size: VControlSize.sm,
              onPressed: () => _pageCtrl.previous(),
              child: const VText('← Prev', variant: VTextVariant.label),
            ),
            for (var i = 0; i < _pageCtrl.count; i++)
              VButton(
                variant: _pageCtrl.index == i
                    ? VButtonVariant.primary
                    : VButtonVariant.secondary,
                size: VControlSize.sm,
                onPressed: () => _pageCtrl.jumpTo(i),
                child: VText('${i + 1}', variant: VTextVariant.label),
              ),
            VButton(
              variant: VButtonVariant.secondary,
              size: VControlSize.sm,
              onPressed: () => _pageCtrl.next(),
              child: const VText('Next →', variant: VTextVariant.label),
            ),
          ],
        ),

        // Page switcher
        VSurface(
          variant: VSurfaceVariant.card,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: VAnimatedSwitcher(
              controller: _pageCtrl,
              transition: _transition,
              children: _pages,
            ),
          ),
        ),

        // Icon toggle — custom enter/exit via VAnimatedSwitcher
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.horizontal(
            gap: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VGestureDetector(
                onTap: () => _likeCtrl.jumpTo(_likeCtrl.index == 0 ? 1 : 0),
                child: SizedBox.square(
                  dimension: 48,
                  child: VAnimatedSwitcher(
                    controller: _likeCtrl,
                    // exit: shake + fade
                    exitTransition: (context, child, anim) => AnimatedBuilder(
                      animation: anim,
                      builder: (context, _) {
                        final shake = math.sin(anim.value * math.pi * 3.7) * 5.0;
                        return Opacity(
                          opacity: anim.value,
                          child: Transform.translate(
                            offset: Offset(shake, 0),
                            child: child,
                          ),
                        );
                      },
                    ),
                    // enter: bounce pop
                    enterTransition: (context, child, anim) {
                      final curved = CurvedAnimation(
                        parent: anim,
                        curve: Curves.elasticOut,
                      );
                      final scale = Tween<double>(begin: 0.5, end: 1.0).animate(curved);
                      return FadeTransition(
                        opacity: anim,
                        child: ScaleTransition(scale: scale, child: child),
                      );
                    },
                    children: [
                      const Icon(LucideIcons.heart, size: 32, color: Color(0xFF94A3B8)),
                      const Icon(LucideIcons.heart, size: 32, color: Color(0xFFEF4444)),
                    ],
                  ),
                ),
              ),
              VText(
                _likeCtrl.index == 1 ? 'Liked ♥' : 'Tap the heart',
                variant: VTextVariant.body,
              ),
            ],
          ),
        ),
      ],
    );
  }
}