import 'package:flutter/widgets.dart';

import 'v_icon_theme_data.dart';
import 'v_theme.dart';
import 'v_token_theme.dart';

/// Provides [VIconThemeData] to descendants.
///
/// [VIcon] reads from the nearest [VIconTheme] before falling back to
/// [VTheme] defaults.
class VIconTheme extends StatelessWidget {
  const VIconTheme({
    super.key,
    required this.data,
    required this.child,
  });

  /// Creates a scoped icon theme by transforming the nearest icon tokens.
  static Widget override({
    Key? key,
    required VScopedTokenOverride<VIconThemeData> data,
    required Widget child,
  }) {
    return VTokenTheme.override<VIconThemeData>(
      key: key,
      data: data,
      fallback: (_) => const VIconThemeData(),
      child: child,
    );
  }

  final VIconThemeData data;
  final Widget child;

  /// Returns the data from the nearest [VIconTheme], or null if none found.
  static VIconThemeData? maybeOf(BuildContext context) {
    return VTokenTheme.maybeOf<VIconThemeData>(context);
  }

  /// Returns the data from the nearest [VIconTheme].
  ///
  /// Asserts in debug mode if no [VIconTheme] ancestor is found.
  static VIconThemeData of(BuildContext context) {
    final data = maybeOf(context);
    assert(data != null, 'No VIconTheme found in context');
    return data!;
  }

  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return VTokenTheme<VIconThemeData>(
      data: data,
      child: IconTheme(
        data: IconThemeData(
          color: data.color,
          size: data.size,
          opacity: data.opacity,
        ),
        child: child,
      ),
    );
  }
}
