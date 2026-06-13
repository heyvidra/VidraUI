part of '../../main.dart';

class _TabsDemo extends StatelessWidget {
  const _TabsDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Tabs', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VTabs(
                tabs: const ['Overview', 'Details', 'Settings'],
                children: const [
                  VText('Overview content', variant: VTextVariant.body),
                  VText('Details content', variant: VTextVariant.body),
                  VText('Settings content', variant: VTextVariant.body),
                ],
              ),
            ),
          ),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                gap: 12,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const VText('Tabs with Icons and Custom Widgets', variant: VTextVariant.title),
                  VTabs(
                    tabs: const [
                      VTabItem(label: 'Home', icon: Text('🏠')),
                      VTabItem(label: 'Profile', icon: Text('👤')),
                      Text('⚙️ Custom Tab'),
                    ],
                    children: const [
                      VText('Home Screen overview', variant: VTextVariant.body),
                      VText('User profile configurations', variant: VTextVariant.body),
                      VText('System settings and preferences', variant: VTextVariant.body),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]);
  }
}


// docs-snippet:start tabs-basic
// VTabs(
//   tabs: const ['Overview', 'Details'],
//   children: const [
//     VText('Overview content'),
//     VText('Details content'),
//   ],
// )
// docs-snippet:end tabs-basic

