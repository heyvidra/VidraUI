import 'package:flutter/widgets.dart';

import 'v_appearance.dart';

/// An [InheritedWidget] that provides a [VAppearance] to its descendants.
///
/// Components that support appearance will check for a [VAppearanceScope]
/// ancestor and apply the found appearance. A per-component `appearance`
/// parameter takes precedence over the scoped one.
class VAppearanceScope extends InheritedWidget {
  const VAppearanceScope({
    super.key,
    required this.appearance,
    required super.child,
  });

  final VAppearance appearance;

  /// Returns the appearance from the nearest [VAppearanceScope], or null
  /// if no scope is found.
  static VAppearance? of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<VAppearanceScope>();
    return scope?.appearance;
  }

  @override
  bool updateShouldNotify(VAppearanceScope oldWidget) =>
      appearance != oldWidget.appearance;
}
