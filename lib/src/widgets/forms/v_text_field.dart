import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/v_component_themes.g.dart';
import '../../theme/v_theme.dart';
import '../../theme/v_theme_data.dart';
import '../basic/v_text.dart';
import '../selection/v_text_selection_controls.dart';
import '../selection/v_text_selection_menu.dart';

part 'v_text_field_context_menu.dart';
part 'v_text_field_selection.dart';
part 'v_text_field_state.dart';

// ---------------------------------------------------------------------------
// Public typedef for custom context menu builders
// ---------------------------------------------------------------------------

typedef VTextFieldContextMenuBuilder = Widget Function(
  BuildContext context,
  EditableTextState editableTextState,
  VTextFieldContextMenuData data,
);

// ---------------------------------------------------------------------------
// Context menu data model
// ---------------------------------------------------------------------------

class VTextFieldContextMenuData {
  const VTextFieldContextMenuData({
    required this.isDesktop,
    required this.hasText,
    required this.hasSelection,
    required this.readOnly,
    required this.obscureText,
    required this.items,
  });

  final bool isDesktop;
  final bool hasText;
  final bool hasSelection;
  final bool readOnly;
  final bool obscureText;
  final List<VTextFieldContextMenuItem> items;
}

class VTextFieldContextMenuItem {
  const VTextFieldContextMenuItem({
    required this.label,
    this.shortcut,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final String? shortcut;
  final bool enabled;
  final VoidCallback onTap;
}

// ---------------------------------------------------------------------------
// VTextField
// ---------------------------------------------------------------------------

class VTextField extends StatefulWidget {
  const VTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.leading,
    this.trailing,
    this.label,
    this.hint,
    this.errorText,
    this.enabled = true,
    this.semanticLabel,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.autofocus = false,
    this.contextMenuBuilder,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? leading;
  final Widget? trailing;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool enabled;
  final String? semanticLabel;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int? minLines;
  final bool readOnly;
  final bool autofocus;

  /// Custom context menu builder. When provided, replaces the default menu.
  final VTextFieldContextMenuBuilder? contextMenuBuilder;

  @override
  State<VTextField> createState() => _VTextFieldState();
}
