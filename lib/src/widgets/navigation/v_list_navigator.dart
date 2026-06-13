import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// A helper class to manage keyboard navigation and highlight state for lists
/// like dropdown menus, select menus, and comboboxes.
class VListNavigator {
  VListNavigator({
    required this.itemCount,
    required this.isItemEnabled,
  });

  /// The number of items in the list.
  final int Function() itemCount;

  /// Whether the item at the given index is enabled/interactive.
  final bool Function(int index) isItemEnabled;

  /// The current highlighted index.
  final ValueNotifier<int> highlightIndex = ValueNotifier<int>(-1);

  /// Resets the highlight to the first enabled item.
  void focusFirst() {
    highlightIndex.value = _firstEnabledIndex();
  }

  /// Clears the highlight.
  void clearFocus() {
    highlightIndex.value = -1;
  }

  /// Disposes the underlying notifier.
  void dispose() {
    highlightIndex.dispose();
  }

  int _firstEnabledIndex() {
    final count = itemCount();
    for (var i = 0; i < count; i++) {
      if (isItemEnabled(i)) return i;
    }
    return -1;
  }

  int _lastEnabledIndex() {
    final count = itemCount();
    for (var i = count - 1; i >= 0; i--) {
      if (isItemEnabled(i)) return i;
    }
    return -1;
  }

  int _nextEnabledIndex(int from, int delta) {
    final count = itemCount();
    if (count == 0) return -1;
    var index = from;
    for (var i = 0; i < count; i++) {
      index = (index + delta) % count;
      if (index < 0) index += count;
      if (isItemEnabled(index)) return index;
    }
    return -1;
  }

  /// Handles standard list keyboard navigation.
  ///
  /// Provide [isOpen], [onOpen], [onClose], and [onSelect] to handle menu
  /// triggers and item activation.
  KeyEventResult handleKey(
    KeyEvent event, {
    required bool isOpen,
    required VoidCallback onOpen,
    required VoidCallback onClose,
    required void Function(int index) onSelect,
  }) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;

    if (!isOpen) {
      if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.space) {
        if (_firstEnabledIndex() != -1) {
          onOpen();
        }
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }

    if (key == LogicalKeyboardKey.escape) {
      onClose();
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowDown) {
      highlightIndex.value = _nextEnabledIndex(highlightIndex.value, 1);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowUp) {
      highlightIndex.value = _nextEnabledIndex(highlightIndex.value, -1);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.home) {
      highlightIndex.value = _firstEnabledIndex();
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.end) {
      highlightIndex.value = _lastEnabledIndex();
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.space) {
      final index = highlightIndex.value;
      if (index >= 0 && index < itemCount()) {
        onSelect(index);
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}
