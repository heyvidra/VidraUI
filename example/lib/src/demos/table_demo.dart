part of '../../main.dart';

class _TableDemo extends StatelessWidget {
  const _TableDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Table', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: VTable(
                columns: [
                  VTableColumn(header: 'Name', width: 130),
                  VTableColumn(header: 'Role', width: 100),
                  VTableColumn(header: 'Status', width: 90),
                ],
                rows: [
                  ['Alice Chen', 'Admin', 'Active'],
                  ['Bob Smith', 'Editor', 'Active'],
                  ['Carol Wu', 'Viewer', 'Inactive'],
                  ['Dave Lee', 'Editor', 'Active'],
                ],
              ),
            ),
          ),
        ]);
  }
}


// docs-snippet:start table-basic
// VTable(
//   sortColumnIndex: 0,
//   columns: const [
//     VTableColumn(header: 'Name', width: 130),
//     VTableColumn(header: 'Role', width: 100),
//   ],
//   rows: const [
//     ['Alice Chen', 'Admin'],
//     ['Bob Smith', 'Editor'],
//   ],
// )
// docs-snippet:end table-basic

// docs-snippet:start table-tokens
// final theme = VTheme.of(context);
//
// VTheme(
//   data: theme.copyWith(
//     components: theme.components.copyWith(
//       table: theme.components.table.copyWith(
//         headerBackground: theme.colors.surfaceHover,
//         headerForeground: theme.colors.text,
//         sortIndicatorColor: theme.colors.actionPrimary,
//         rowBackground: theme.colors.surface,
//         alternateRowBackground: theme.colors.surfaceSubtle,
//       ),
//     ),
//   ),
//   child: const VTable(
//     sortColumnIndex: 0,
//     columns: [VTableColumn(header: 'Name'), VTableColumn(header: 'Role')],
//     rows: [['Alice', 'Admin'], ['Bob', 'Editor']],
//   ),
// )
// docs-snippet:end table-tokens

