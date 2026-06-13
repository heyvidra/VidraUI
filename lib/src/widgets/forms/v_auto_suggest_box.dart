import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/component_tokens.dart';
import '../../theme/v_theme.dart';
import '../../theme/v_theme_data.dart';
import '../basic/v_text.dart';
import '../feedback/v_progress.dart';
import '../navigation/v_list_navigator.dart';
import '../overlays/v_anchored_overlay.dart';
import '../overlays/v_popover.dart';
import 'v_text_field.dart';

part 'v_auto_suggest_box_panel.dart';
part 'v_auto_suggest_box_state.dart';

// ---------------------------------------------------------------------------
// Public data model
// ---------------------------------------------------------------------------

/// A single suggestion item displayed in [VAutoSuggestBox].
class VAutoSuggestItem {
  const VAutoSuggestItem({
    required this.value,
    required this.label,
    this.subtitle,
    this.leading,
    this.enabled = true,
  });

  /// The machine-readable value passed to [VAutoSuggestBox.onSelected].
  final String value;

  /// The human-readable label shown in the list.
  final String label;

  /// Optional secondary text shown below the label.
  final String? subtitle;

  /// Optional leading widget (e.g. an icon or avatar).
  final Widget? leading;

  /// When false, the item appears greyed out and cannot be selected.
  final bool enabled;
}

// ---------------------------------------------------------------------------
// Suggestion source typedefs
// ---------------------------------------------------------------------------

/// Synchronous suggestion builder called on every keystroke.
///
/// Return an empty list to hide the dropdown.
typedef VAutoSuggestBuilder = List<VAutoSuggestItem> Function(String query);

/// Asynchronous suggestion builder.
///
/// The future is debounced internally.  Resolve to `null` to leave the
/// current suggestions unchanged (e.g. while the previous request is in
/// flight).
typedef VAutoSuggestAsyncBuilder = Future<List<VAutoSuggestItem>?> Function(
    String query);

// ---------------------------------------------------------------------------
// VAutoSuggestBox
// ---------------------------------------------------------------------------

/// A combobox that combines [VTextField] with an anchored suggestion dropdown.
///
/// ## Basic usage
/// ```dart
/// VAutoSuggestBox(
///   label: 'Country',
///   hint: 'Start typing…',
///   suggestionsBuilder: (query) => countries
///       .where((c) => c.toLowerCase().contains(query.toLowerCase()))
///       .map((c) => VAutoSuggestItem(value: c, label: c))
///       .toList(),
///   onSelected: (item) => setState(() => _country = item.value),
/// )
/// ```
///
/// ## Async usage
/// ```dart
/// VAutoSuggestBox(
///   label: 'User search',
///   hint: 'Type a username…',
///   asyncSuggestionsBuilder: (query) => api.searchUsers(query),
///   onSelected: (item) => setState(() => _userId = item.value),
/// )
/// ```
///
/// ## Selection modes
/// - [onSelected]: called when the user picks an item from the dropdown.
/// - [onChanged]: mirrors [VTextField.onChanged], called on every keystroke.
/// - [onSubmitted]: called when the user presses Enter with the raw text.
///
/// Pass an external [controller] if you need to read or set the text
/// programmatically.
class VAutoSuggestBox extends StatefulWidget {
  const VAutoSuggestBox({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.errorText,
    this.enabled = true,
    this.semanticLabel,
    this.leading,
    this.trailing,
    this.suggestionsBuilder,
    this.asyncSuggestionsBuilder,
    this.debounceDuration = const Duration(milliseconds: 200),
    this.maxSuggestions = 8,
    this.maxDropdownHeight = 280,
    this.highlightMatch = true,
    this.onSelected,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.placement = VAnchoredOverlayPlacement.auto,
  }) : assert(
          suggestionsBuilder != null || asyncSuggestionsBuilder != null,
          'Provide either suggestionsBuilder or asyncSuggestionsBuilder.',
        );

  // --- text-field pass-throughs ---

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool enabled;
  final String? semanticLabel;
  final Widget? leading;
  final Widget? trailing;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  // --- suggestion source (exactly one must be non-null) ---

  /// Synchronous suggestion builder.  Mutually exclusive with
  /// [asyncSuggestionsBuilder].
  final VAutoSuggestBuilder? suggestionsBuilder;

  /// Asynchronous suggestion builder.  Mutually exclusive with
  /// [suggestionsBuilder].
  final VAutoSuggestAsyncBuilder? asyncSuggestionsBuilder;

  /// Debounce duration applied to [asyncSuggestionsBuilder].
  /// Ignored when [suggestionsBuilder] is used.
  final Duration debounceDuration;

  // --- behavior ---

  /// Maximum number of suggestions shown at once before the panel scrolls.
  final int maxSuggestions;

  /// Maximum height of the dropdown panel in logical pixels.
  final double maxDropdownHeight;

  /// When true, matched substrings in item labels are tinted with
  /// [VAutoSuggestTokens.matchHighlight].
  final bool highlightMatch;

  /// Called when the user taps or keyboard-confirms a suggestion.
  final ValueChanged<VAutoSuggestItem>? onSelected;

  /// Called on every keystroke with the current raw text value.
  final ValueChanged<String>? onChanged;

  /// Called when the user presses the submit action key (Enter / Done).
  final ValueChanged<String>? onSubmitted;

  /// Preferred opening direction for the dropdown.
  final VAnchoredOverlayPlacement placement;

  @override
  State<VAutoSuggestBox> createState() => _VAutoSuggestBoxState();
}
