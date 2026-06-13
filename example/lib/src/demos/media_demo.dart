part of '../../main.dart';

class _MediaDemo extends StatelessWidget {
  const _MediaDemo();

  @override
  Widget build(BuildContext context) {
    final star = LucideIcons.star;
    final heart = LucideIcons.heart;

    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Media', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 16,
                  children: [
                    const VText('VIcon', variant: VTextVariant.title),
                    VFlex.horizontal(gap: 12, children: [
                      VIcon(star, size: 24, semanticLabel: 'Star'),
                      VIcon(heart,
                          size: 24,
                          color: Color(0xFFDC2626),
                          semanticLabel: 'Heart'),
                      VIcon(LucideIcons.settings, size: 24, opacity: 0.4),
                    ]),
                    const VText('IconButton', variant: VTextVariant.title),
                    VFlex.horizontal(gap: 8, children: [
                      VButton(
                        onPressed: () {},
                        variant: VButtonVariant.secondary,
                        semanticLabel: 'Search',
                        child: VIcon(LucideIcons.search),
                      ),
                      VButton(
                        onPressed: () {},
                        variant: VButtonVariant.secondary,
                        semanticLabel: 'Settings',
                        child: VIcon(LucideIcons.settings),
                      ),
                      VButton(
                        onPressed: () {},
                        variant: VButtonVariant.danger,
                        semanticLabel: 'Delete',
                        child: VIcon(LucideIcons.trash2),
                      ),
                    ]),
                    const VText('VButton with icons',
                        variant: VTextVariant.title),
                    VFlex.horizontal(gap: 8, children: [
                      VButton(
                        leadingIcon: VIcon(star),
                        onPressed: () {},
                        child:
                            const VText('Leading', variant: VTextVariant.label),
                      ),
                      VButton(
                        trailingIcon: VIcon(heart),
                        onPressed: () {},
                        variant: VButtonVariant.secondary,
                        child: const VText('Trailing',
                            variant: VTextVariant.label),
                      ),
                    ]),
                    const VText('VImage', variant: VTextVariant.title),
                    SizedBox(
                      height: 120,
                      child: VImage.network(
                        'https://picsum.photos/400/200',
                        width: 200,
                        height: 120,
                        radius: 8,
                        placeholder: Center(
                            child: VText('Loading…',
                                variant: VTextVariant.caption)),
                      ),
                    ),
                  ]),
            ),
          ),
        ]);
  }
}


// docs-snippet:start media-basic
// VImage.network(
//   'https://picsum.photos/400/200',
//   width: 200,
//   height: 120,
//   radius: 8,
//   placeholder: const Center(child: VSpinner()),
// )
// docs-snippet:end media-basic

