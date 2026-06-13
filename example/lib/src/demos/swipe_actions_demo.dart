part of '../../main.dart';

class _SwipeActionsDemo extends StatelessWidget {
  const _SwipeActionsDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Swipe Actions', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                VSwipeActions(
                  endAction: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: VButton(
                        variant: VButtonVariant.danger,
                        onPressed: () {},
                        child:
                            const VText('Delete', variant: VTextVariant.label),
                      ),
                    ),
                  ),
                  child: VSurface(
                    width: double.infinity,
                    variant: VSurfaceVariant.elevated,
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: VText('Swipe left ←', variant: VTextVariant.body),
                    ),
                  ),
                ),
                const VDivider(indent: 16),
                VSwipeActions(
                  startAction: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: VButton(
                        variant: VButtonVariant.secondary,
                        onPressed: () {},
                        child:
                            const VText('Archive', variant: VTextVariant.label),
                      ),
                    ),
                  ),
                  endAction: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: VButton(
                        variant: VButtonVariant.danger,
                        onPressed: () {},
                        child:
                            const VText('Delete', variant: VTextVariant.label),
                      ),
                    ),
                  ),
                  child: VSurface(
                    width: double.infinity,
                    variant: VSurfaceVariant.elevated,
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: VText('Swipe both sides ↔',
                          variant: VTextVariant.body),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}

