import 'package:flutter/widgets.dart';

import 'v_theme.dart';
import 'v_theme_data.dart';

/// Generic scoped token provider used by component-specific theme widgets.
class VTokenTheme<T extends Object> extends InheritedWidget {
  const VTokenTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Creates scoped tokens by transforming the nearest token of the same type.
  static Widget override<T extends Object>({
    Key? key,
    required VScopedTokenOverride<T> data,
    required T Function(VThemeData theme) fallback,
    required Widget child,
  }) {
    return _VTokenThemeOverride<T>(
      key: key,
      data: data,
      fallback: fallback,
      child: child,
    );
  }

  final T data;

  /// Returns the nearest scoped token of type [T], if one exists.
  static T? maybeOf<T extends Object>(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<VTokenTheme<T>>();
    return widget?.data;
  }

  // InheritedWidget.updateShouldNotify uses a covariant parameter. When the
  // class is generic (VTokenTheme<T>), the analyzer incorrectly rejects
  // @override because the inferred signature differs. The behavior is correct.
  // ignore: annotate_overrides
  bool updateShouldNotify(VTokenTheme<T> oldWidget) => data != oldWidget.data;
}

class _VTokenThemeOverride<T extends Object> extends StatelessWidget {
  const _VTokenThemeOverride({
    super.key,
    required this.data,
    required this.fallback,
    required this.child,
  });

  final VScopedTokenOverride<T> data;
  final T Function(VThemeData theme) fallback;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final base = VTokenTheme.maybeOf<T>(context) ?? fallback(theme);
    return VTokenTheme<T>(
      data: data(theme, base),
      child: child,
    );
  }
}

/// Base class for standard component theme wrappers.
///
/// Eliminates the repeated [build], [data], and [child] boilerplate
/// that every `V<Component>Theme` widget previously duplicated.
///
/// Subclasses only need to provide:
/// - A `static Widget override(...)` with the component-specific fallback.
/// - A `static T? of(BuildContext context)` forwarding to [ofToken].
class VComponentThemeWrapper<T extends Object> extends StatelessWidget {
  /// Creates a component theme wrapper that provides [data] to the subtree.
  const VComponentThemeWrapper({
    super.key,
    required this.data,
    required this.child,
  });

  /// The token data to provide to descendants.
  final T data;

  /// The child widget.
  final Widget child;

  /// Returns the nearest scoped token of type [T], or `null`.
  ///
  /// Subclass `of` methods should forward to this.
  static T? ofToken<T extends Object>(BuildContext context) {
    return VTokenTheme.maybeOf<T>(context);
  }

  @override
  Widget build(BuildContext context) {
    return VTokenTheme<T>(data: data, child: child);
  }
}

