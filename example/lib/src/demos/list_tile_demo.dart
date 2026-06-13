part of '../../main.dart';

class _ListTileDemo extends StatelessWidget {
  const _ListTileDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('List Tile', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VSwipeActions(
                  endAction: Center(
                    child: VButton(
                      variant: VButtonVariant.danger,
                      onPressed: () {},
                      child: const VText('Delete', variant: VTextVariant.label),
                    ),
                  ),
                  child: const VListTile(
                    leading: VAvatar(name: 'SA'),
                    title: 'Swipe actions',
                    subtitle: 'Swipe left, tap Delete, or tap another row',
                    trailing: VText('New', variant: VTextVariant.caption),
                  ),
                ),
                const VDivider(indent: 72),
                const VListTile(
                  leading: VAvatar(name: 'AC'),
                  title: 'Alice Chen',
                  subtitle: 'alice@example.com',
                  trailing: VText('Admin', variant: VTextVariant.caption),
                ),
                const VDivider(indent: 72),
                const VListTile(
                  leading: VAvatar(name: 'BS'),
                  title: 'Bob Smith',
                  subtitle: 'bob@example.com',
                  trailing: VText('Editor', variant: VTextVariant.caption),
                ),
                const VDivider(indent: 72),
                const VListTile(
                  leading: VAvatar(name: 'CW'),
                  title: 'Carol Wu',
                  subtitle: 'carol@example.com',
                  trailing: VText('Viewer', variant: VTextVariant.caption),
                ),
              ],
            ),
          ),
        ]);
  }
}


// docs-snippet:start list-tile-basic
// VListTile(
//   leading: const VAvatar(name: 'AC'),
//   title: 'Alice Chen',
//   subtitle: 'alice@example.com',
//   trailing: const VText('Admin', variant: VTextVariant.caption),
// )
// docs-snippet:end list-tile-basic

