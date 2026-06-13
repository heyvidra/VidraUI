import 'package:flutter/widgets.dart';

import '../theme/v_theme_data.dart';

/// Abstract routing strategy for [VidraApp].
///
/// Subclasses implement [buildApp] to return either [WidgetsApp] (Navigator 1.0)
/// or [WidgetsApp.router] (Router 2.0).
///
/// See also:
/// - [VNavigatorAdapter] for Navigator 1.0 routing.
/// - [VRouterConfigAdapter] for Router 2.0 routing.
abstract class VRouteAdapter {
  const VRouteAdapter();

  /// Build the inner Flutter app widget.
  Widget buildApp({
    required BuildContext context,
    required VThemeData theme,
    required String title,
    required Color color,
    required Locale? locale,
    required Iterable<Locale> supportedLocales,
    required TextDirection textDirection,
    required Map<ShortcutActivator, Intent> shortcuts,
    required Map<Type, Action<Intent>> actions,
    required TextStyle textStyle,
    required bool debugShowCheckedModeBanner,
  });
}
