part of '../../main.dart';

class _MenuDemo extends StatefulWidget {
  const _MenuDemo();

  @override
  State<_MenuDemo> createState() => _MenuDemoState();
}

class _MenuDemoState extends State<_MenuDemo> {
  String _density = 'comfortable';
  Set<String> _columns = {'name', 'status'};

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Menu', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  gap: 12,
                  children: [
                    const VText('Action menu', variant: VTextVariant.title),
                    VMenuAnchor<String>(
                      items: [
                        VMenuItem(
                          label: 'Duplicate',
                          value: 'duplicate',
                          onPressed: () => VToast.show(
                            context,
                            message: 'Duplicated item',
                          ),
                        ),
                        const VMenuItem(
                          label: 'Archive unavailable',
                          value: 'archive',
                          enabled: false,
                        ),
                        const VMenuItem.separator(),
                        VMenuItem(
                          label: 'Delete',
                          value: 'delete',
                          role: VMenuItemRole.destructive,
                          onPressed: () => VToast.show(
                            context,
                            message: 'Delete selected',
                            variant: VToastVariant.warning,
                          ),
                        ),
                      ],
                      builder: (context, controller, isOpen) {
                        return VButton(
                          onPressed: controller.toggle,
                          variant: VButtonVariant.secondary,
                          child: VText(
                            isOpen ? 'Close actions' : 'Open actions',
                            variant: VTextVariant.label,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const VText('Single selection',
                        variant: VTextVariant.title),
                    VMenuAnchor<String>(
                      selectionMode: VMenuSelectionMode.single,
                      selectedValue: _density,
                      onSelected: (value) => setState(() => _density = value),
                      items: const [
                        VMenuItem(value: 'compact', label: 'Compact'),
                        VMenuItem(value: 'comfortable', label: 'Comfortable'),
                        VMenuItem(value: 'spacious', label: 'Spacious'),
                      ],
                      builder: (context, controller, isOpen) {
                        return VButton(
                          onPressed: controller.toggle,
                          variant: VButtonVariant.secondary,
                          child: VText(
                            'Density: $_density',
                            variant: VTextVariant.label,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const VText('Multiple selection',
                        variant: VTextVariant.title),
                    VMenuAnchor<String>(
                      selectionMode: VMenuSelectionMode.multiple,
                      selectedValues: _columns,
                      onSelectionChanged: (values) =>
                          setState(() => _columns = values),
                      items: const [
                        VMenuItem(value: 'name', label: 'Name'),
                        VMenuItem(value: 'status', label: 'Status'),
                        VMenuItem(value: 'owner', label: 'Owner'),
                      ],
                      builder: (context, controller, isOpen) {
                        return VButton(
                          onPressed: controller.toggle,
                          variant: VButtonVariant.secondary,
                          child: VText(
                            '${_columns.length} columns',
                            variant: VTextVariant.label,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const VText('Cascading submenus',
                        variant: VTextVariant.title),
                    VMenuAnchor<String>(
                      items: [
                        VMenuItem(
                          label: 'Share',
                          children: [
                            VMenuItem(
                              label: 'Email',
                              value: 'email',
                              onPressed: () => VToast.show(
                                context,
                                message: 'Shared via Email',
                              ),
                            ),
                            VMenuItem(
                              label: 'Copy Link',
                              value: 'link',
                              onPressed: () => VToast.show(
                                context,
                                message: 'Copied link to clipboard',
                              ),
                            ),
                          ],
                        ),
                        VMenuItem(
                          label: 'Export',
                          children: [
                            VMenuItem(
                              label: 'PDF Document (.pdf)',
                              value: 'pdf',
                              onPressed: () => VToast.show(
                                context,
                                message: 'Exported as PDF',
                              ),
                            ),
                            VMenuItem(
                              label: 'Excel Worksheet (.xlsx)',
                              value: 'xlsx',
                              onPressed: () => VToast.show(
                                context,
                                message: 'Exported as Excel',
                              ),
                            ),
                          ],
                        ),
                        const VMenuItem.separator(),
                        VMenuItem(
                          label: 'Properties',
                          value: 'properties',
                          onPressed: () => VToast.show(
                            context,
                            message: 'Opened properties dialog',
                          ),
                        ),
                      ],
                      builder: (context, controller, isOpen) {
                        return VButton(
                          onPressed: controller.toggle,
                          variant: VButtonVariant.secondary,
                          child: const VText(
                            'File options',
                            variant: VTextVariant.label,
                          ),
                        );
                      },
                    ),
                  ]),
            ),
          ),
        ]);
  }
}


// docs-snippet:start menu-action-basic
// VMenuAnchor<String>(
//   items: [
//     VMenuItem(label: 'Duplicate', value: 'duplicate', onPressed: duplicate),
//     const VMenuItem.separator(),
//     VMenuItem(
//       label: 'Delete',
//       value: 'delete',
//       role: VMenuItemRole.destructive,
//       onPressed: delete,
//     ),
//   ],
//   builder: (context, controller, isOpen) {
//     return VButton(
//       onPressed: controller.toggle,
//       child: VText(isOpen ? 'Close' : 'Actions'),
//     );
//   },
// )
// docs-snippet:end menu-action-basic

// docs-snippet:start menu-selection-basic
// VMenuAnchor<String>(
//   selectionMode: VMenuSelectionMode.multiple,
//   selectedValues: selectedColumns,
//   onSelectionChanged: (values) => setState(() => selectedColumns = values),
//   items: const [
//     VMenuItem(value: 'name', label: 'Name'),
//     VMenuItem(value: 'status', label: 'Status'),
//   ],
//   builder: (context, controller, isOpen) {
//     return VButton(
//       onPressed: controller.toggle,
//       child: VText('${selectedColumns.length} columns'),
//     );
//   },
// )
// docs-snippet:end menu-selection-basic

