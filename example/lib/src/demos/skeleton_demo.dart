part of '../../main.dart';

class _SkeletonDemo extends StatelessWidget {
  const _SkeletonDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Skeleton Loader', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VShimmer(
                child: VFlex.vertical(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    gap: 12,
                    children: [
                      Row(
                        children: [
                          VSkeletonCircle(size: 40),
                          SizedBox(width: 12),
                          Expanded(
                            child: VFlex.vertical(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                gap: 6,
                                children: [
                                  VSkeletonBox(width: 160, height: 14),
                                  VSkeletonBox(width: 120, height: 12),
                                ]),
                          ),
                        ],
                      ),
                      VSkeletonBox(height: 14),
                      VSkeletonBox(height: 14),
                      VSkeletonBox(width: 200, height: 14),
                    ]),
              ),
            ),
          ),
        ]);
  }
}

