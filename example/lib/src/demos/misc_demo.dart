part of '../../main.dart';

class _MiscDemo extends StatelessWidget {
  const _MiscDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Avatar & Badge', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 16,
                  children: [
                    const VText('Avatars', variant: VTextVariant.title),
                    VFlex.horizontal(gap: 8, children: const [
                      VAvatar(name: 'John Doe'),
                      VAvatar(name: 'Jane'),
                      VAvatar(name: ''),
                    ]),
                    const VText('Badges', variant: VTextVariant.title),
                    VFlex.horizontal(gap: 16, children: const [
                      VBadge(
                        count: 3,
                        child: IconsType(),
                      ),
                      VBadge(
                        count: 150,
                        child: IconsType(),
                      ),
                      VBadge(
                        showDot: true,
                        child: IconsType(),
                      ),
                    ]),
                  ]),
            ),
          ),
        ]);
  }
}

class IconsType extends StatelessWidget {
  const IconsType({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xFFE5E7EB),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: SizedBox(width: 32, height: 32),
    );
  }
}

