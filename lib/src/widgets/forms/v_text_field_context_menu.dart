part of 'v_text_field.dart';

// ---------------------------------------------------------------------------
// Context menu data builder
// ---------------------------------------------------------------------------

VTextFieldContextMenuData _buildContextMenuData(EditableTextState state) {
  final widget = state.widget;
  final behavior = VPlatformScope.of(state.context);
  final isDesktop = behavior.isDesktop;
  final readOnly = widget.readOnly;
  final obscure = widget.obscureText;
  final hasSelection = state.textEditingValue.selection.isValid &&
      !state.textEditingValue.selection.isCollapsed;
  final hasText = state.textEditingValue.text.isNotEmpty;
  final ctrl = behavior.shortcutModifier;

  return VTextFieldContextMenuData(
    isDesktop: isDesktop,
    hasText: hasText,
    hasSelection: hasSelection,
    readOnly: readOnly,
    obscureText: obscure,
    items: [
      VTextFieldContextMenuItem(
        label: 'Cut',
        shortcut: '${ctrl}X',
        enabled: !readOnly && hasSelection && !obscure,
        onTap: () {
          state.cutSelection(SelectionChangedCause.toolbar);
          state.hideToolbar();
        },
      ),
      VTextFieldContextMenuItem(
        label: 'Copy',
        shortcut: '${ctrl}C',
        enabled: hasSelection && !obscure,
        onTap: () {
          state.copySelection(SelectionChangedCause.toolbar);
          state.hideToolbar();
        },
      ),
      VTextFieldContextMenuItem(
        label: 'Paste',
        shortcut: '${ctrl}V',
        enabled: !readOnly,
        onTap: () {
          state.pasteText(SelectionChangedCause.toolbar);
          state.hideToolbar();
        },
      ),
      VTextFieldContextMenuItem(
        label: 'Select All',
        shortcut: '${ctrl}A',
        enabled: hasText,
        onTap: () {
          state.selectAll(SelectionChangedCause.toolbar);
          state.hideToolbar();
        },
      ),
    ],
  );
}
