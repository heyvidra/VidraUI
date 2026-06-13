import 'package:flutter/widgets.dart';

/// A [WidgetStateProperty] implementation that resolves state → value
/// using a priority-ordered fallback chain.
///
/// Resolution priority (highest to lowest):
///
/// ```
/// disabled > error > pressed > hovered > focused > selected > normal
/// ```
///
/// This wraps the standard Flutter [WidgetState] / [WidgetStateProperty]
/// system — no custom enum is defined.
class VStateProperty<T> implements WidgetStateProperty<T> {
  /// Returns a property that always resolves to [value].
  factory VStateProperty.all(T value) => VStateProperty((_) => value);

  /// Returns a property that resolves using a priority chain.
  ///
  /// This is a shorter alias for [VStateProperty.resolveWith].
  factory VStateProperty.states({
    required T normal,
    T? hovered,
    T? pressed,
    T? focused,
    T? disabled,
    T? selected,
    T? error,
  }) {
    return VStateProperty.resolveWith(
      normal: normal,
      hovered: hovered,
      pressed: pressed,
      focused: focused,
      disabled: disabled,
      selected: selected,
      error: error,
    );
  }

  /// Returns a property that resolves using a priority chain.
  ///
  /// [normal] is required. All other states fall back to [normal] when
  /// not provided.
  factory VStateProperty.resolveWith({
    required T normal,
    T? hovered,
    T? pressed,
    T? focused,
    T? disabled,
    T? selected,
    T? error,
  }) {
    return VStateProperty((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return disabled ?? normal;
      }
      if (states.contains(WidgetState.error)) {
        return error ?? normal;
      }
      if (states.contains(WidgetState.pressed)) {
        return pressed ?? hovered ?? normal;
      }
      if (states.contains(WidgetState.hovered)) {
        return hovered ?? normal;
      }
      if (states.contains(WidgetState.focused)) {
        return focused ?? normal;
      }
      if (states.contains(WidgetState.selected)) {
        return selected ?? normal;
      }
      return normal;
    });
  }
  const VStateProperty(this._resolver);

  final T Function(Set<WidgetState> states) _resolver;

  @override
  T resolve(Set<WidgetState> states) => _resolver(states);
}
