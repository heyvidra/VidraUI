import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/component_tokens.dart';
import '../../theme/v_component_themes.g.dart';
import '../../theme/v_icon_theme.dart';
import '../../theme/v_icon_theme_data.dart';
import '../../theme/v_theme.dart';
import '../../theme/v_theme_data.dart';
import '../basic/v_text.dart';
import '../navigation/v_list_navigator.dart';
import 'v_anchored_overlay.dart';
import 'v_popover.dart';

part 'v_menu_anchor_state.dart';
part 'v_menu_anchor_submenu.dart';
part 'v_menu_anchor_surface.dart';

/// Builds the trigger for a [VMenuAnchor].
typedef VMenuAnchorBuilder = Widget Function(
  BuildContext context,
  VMenuController controller,
  bool isOpen,
);

/// Selection behavior for a [VMenuAnchor].
enum VMenuSelectionMode {
  /// Menu items behave as actions only.
  none,

  /// One item may be selected.
  single,

  /// Multiple items may be selected.
  multiple,
}

/// Semantic role for a menu item.
enum VMenuItemRole {
  normal,
  destructive,
}

/// Controls a [VMenuAnchor].
class VMenuController extends VPopoverController {}

/// A menu row or separator for [VMenuAnchor].
class VMenuItem<T> {
  const VMenuItem({
    required this.label,
    this.description,
    this.value,
    this.onPressed,
    this.enabled = true,
    this.role = VMenuItemRole.normal,
    this.leading,
    this.trailing,
    this.semanticLabel,
    this.closeOnActivate,
    this.children,
  }) : isSeparator = false;

  const VMenuItem.separator()
      : label = '',
        description = null,
        value = null,
        onPressed = null,
        enabled = false,
        role = VMenuItemRole.normal,
        leading = null,
        trailing = null,
        semanticLabel = null,
        closeOnActivate = null,
        children = null,
        isSeparator = true;

  /// Visible item label.
  final String label;

  /// Optional secondary text displayed below [label].
  ///
  /// Truncated with an ellipsis when it overflows the menu width.
  final String? description;

  /// Optional value used by single and multiple selection menus.
  final T? value;

  /// Optional action callback.
  final VoidCallback? onPressed;

  /// Whether the item can be activated.
  final bool enabled;

  /// Visual and semantic item role.
  final VMenuItemRole role;

  /// Optional leading widget.
  final Widget? leading;

  /// Optional trailing widget.
  final Widget? trailing;

  /// Optional accessibility label.
  final String? semanticLabel;

  /// Whether activation closes the menu. Defaults by menu mode.
  final bool? closeOnActivate;

  /// Whether this item renders as a separator.
  final bool isSeparator;

  /// Sub-items for a nested cascading submenu.
  final List<VMenuItem<T>>? children;

  /// Whether this item has sub-items/children.
  bool get isSubmenu => children != null && children!.isNotEmpty;
}

/// Anchors an action or selection menu to a trigger widget.
class VMenuAnchor<T> extends StatefulWidget {
  const VMenuAnchor({
    super.key,
    required this.items,
    required this.builder,
    this.controller,
    this.enabled = true,
    this.semanticLabel,
    this.maxMenuHeight = 280,
    this.placement = VAnchoredOverlayPlacement.auto,
    this.selectionMode = VMenuSelectionMode.none,
    this.selectedValue,
    this.selectedValues,
    this.onSelected,
    this.onSelectionChanged,
    this.onActivate,
    this.isSubmenu = false,
  });

  final List<VMenuItem<T>> items;
  final VMenuAnchorBuilder builder;
  final VMenuController? controller;
  final bool enabled;
  final String? semanticLabel;
  final double maxMenuHeight;
  final VAnchoredOverlayPlacement placement;
  final VMenuSelectionMode selectionMode;
  final T? selectedValue;
  final Set<T>? selectedValues;
  final ValueChanged<T>? onSelected;
  final ValueChanged<Set<T>>? onSelectionChanged;
  final ValueChanged<VMenuItem<dynamic>>? onActivate;
  final bool isSubmenu;

  @override
  State<VMenuAnchor<T>> createState() => _VMenuAnchorState<T>();
}
