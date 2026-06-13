part of '../../main.dart';

class _AutoSuggestDemo extends StatefulWidget {
  const _AutoSuggestDemo();

  @override
  State<_AutoSuggestDemo> createState() => _AutoSuggestDemoState();
}

class _AutoSuggestDemoState extends State<_AutoSuggestDemo> {
  String _selectedSync = 'None';
  String _selectedAsync = 'None';
  String _selectedCustom = 'None';

  final List<String> _countries = [
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'China',
    'India',
    'Brazil',
    'South Africa',
    'Spain',
    'Italy',
    'Mexico',
    'Sweden',
    'Norway',
  ];

  final List<VAutoSuggestItem> _users = [
    const VAutoSuggestItem(
      value: 'alice',
      label: 'Alice Smith',
      subtitle: 'Software Engineer',
      leading: VIcon(LucideIcons.user, size: 18),
    ),
    const VAutoSuggestItem(
      value: 'bob',
      label: 'Bob Johnson',
      subtitle: 'Product Manager',
      leading: VIcon(LucideIcons.user, size: 18),
    ),
    const VAutoSuggestItem(
      value: 'charlie',
      label: 'Charlie Brown',
      subtitle: 'Designer',
      leading: VIcon(LucideIcons.user, size: 18),
    ),
    const VAutoSuggestItem(
      value: 'david',
      label: 'David Miller',
      subtitle: 'DevOps Lead',
      leading: VIcon(LucideIcons.user, size: 18),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('Auto Suggest Box', variant: VTextVariant.heading),
        const VText(
          'A combined input and suggestion dropdown, supporting synchronous and asynchronous search sources.',
          variant: VTextVariant.body,
        ),

        // Synchronous Demo
        const VText('Synchronous Search (Countries)', variant: VTextVariant.title),
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 12,
              children: [
                VAutoSuggestBox(
                  label: 'Country',
                  hint: 'Type a country name...',
                  suggestionsBuilder: (query) {
                    if (query.isEmpty) return const [];
                    return _countries
                        .where((c) => c.toLowerCase().contains(query.toLowerCase()))
                        .map((c) => VAutoSuggestItem(value: c, label: c))
                        .toList();
                  },
                  onSelected: (item) {
                    setState(() => _selectedSync = item.label);
                  },
                ),
                VText('Selected: $_selectedSync', variant: VTextVariant.caption),
              ],
            ),
          ),
        ),

        // Asynchronous Demo
        const VText('Asynchronous Search (Simulated)', variant: VTextVariant.title),
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 12,
              children: [
                VAutoSuggestBox(
                  label: 'Search Cities',
                  hint: 'Type to load async cities...',
                  asyncSuggestionsBuilder: (query) async {
                    if (query.isEmpty) return const [];
                    // Simulate network latency
                    await Future.delayed(const Duration(milliseconds: 600));
                    final cities = ['New York', 'London', 'Tokyo', 'Paris', 'Berlin', 'Sydney'];
                    return cities
                        .where((c) => c.toLowerCase().contains(query.toLowerCase()))
                        .map((c) => VAutoSuggestItem(value: c, label: c))
                        .toList();
                  },
                  onSelected: (item) {
                    setState(() => _selectedAsync = item.label);
                  },
                ),
                VText('Selected: $_selectedAsync', variant: VTextVariant.caption),
              ],
            ),
          ),
        ),

        // Custom Items Demo
        const VText('Custom Suggestion Items', variant: VTextVariant.title),
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 12,
              children: [
                VAutoSuggestBox(
                  label: 'Team Members',
                  hint: 'Search by name or title...',
                  leading: const VIcon(LucideIcons.search, size: 18),
                  suggestionsBuilder: (query) {
                    if (query.isEmpty) return const [];
                    return _users
                        .where((u) =>
                            u.label.toLowerCase().contains(query.toLowerCase()) ||
                            (u.subtitle?.toLowerCase().contains(query.toLowerCase()) ?? false))
                        .toList();
                  },
                  onSelected: (item) {
                    setState(() => _selectedCustom = '${item.label} (${item.subtitle})');
                  },
                ),
                VText('Selected: $_selectedCustom', variant: VTextVariant.caption),
              ],
            ),
          ),
        ),

        // Disabled State
        const VText('Disabled State', variant: VTextVariant.title),
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VAutoSuggestBox(
              label: 'Locked Suggestion Box',
              hint: 'Cannot suggest or edit',
              enabled: false,
              suggestionsBuilder: (query) => const [],
            ),
          ),
        ),
      ],
    );
  }
}

// docs-snippet:start auto-suggest-basic
// VAutoSuggestBox(
//   label: 'Country',
//   hint: 'Start typing...',
//   suggestionsBuilder: (query) => countries
//       .where((c) => c.toLowerCase().contains(query.toLowerCase()))
//       .map((c) => VAutoSuggestItem(value: c, label: c))
//       .toList(),
//   onSelected: (item) => print('Selected: ${item.label}'),
// )
// docs-snippet:end auto-suggest-basic
