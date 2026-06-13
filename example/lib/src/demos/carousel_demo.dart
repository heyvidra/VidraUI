part of '../../main.dart';

class _CarouselDemo extends StatelessWidget {
  const _CarouselDemo();

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final slides = [
      Container(
        color: theme.colors.actionPrimary,
        child: const Center(
          child: VText('Slide 1',
              variant: VTextVariant.heading, color: Color(0xFFFFFFFF)),
        ),
      ),
      Container(
        color: theme.colors.success,
        child: const Center(
          child: VText('Slide 2',
              variant: VTextVariant.heading, color: Color(0xFFFFFFFF)),
        ),
      ),
      Container(
        color: theme.colors.danger,
        child: const Center(
          child: VText('Slide 3',
              variant: VTextVariant.heading, color: Color(0xFFFFFFFF)),
        ),
      ),
    ];

    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Carousel', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(theme.radii.md),
              child: VCarousel(
                height: 160,
                children: slides,
              ),
            ),
          ),
        ]);
  }
}


// docs-snippet:start carousel-basic
// VCarousel(
//   height: 160,
//   children: [
//     VSurface(child: const Center(child: VText('Slide 1'))),
//     VSurface(child: const Center(child: VText('Slide 2'))),
//   ],
// )
// docs-snippet:end carousel-basic

