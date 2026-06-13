import 'package:flutter/widgets.dart';

import '../foundation/v_scroll_behavior.dart';
import '../theme/v_theme_data.dart';
import 'v_route_adapter.dart';

/// A [VRouteAdapter] that uses [WidgetsApp.router] for Router 2.0 routing.
///
/// [routerConfig] carries its own back button dispatcher, route delegate,
/// and parser — do not pass a separate [BackButtonDispatcher].
class VRouterConfigAdapter extends VRouteAdapter {
  const VRouterConfigAdapter({
    required this.routerConfig,
  });

  final RouterConfig<Object> routerConfig;

  @override
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
  }) {
    final mergedShortcuts = <ShortcutActivator, Intent>{
      ...WidgetsApp.defaultShortcuts,
      ...shortcuts,
    };
    final mergedActions = <Type, Action<Intent>>{
      ...WidgetsApp.defaultActions,
      ...actions,
    };

    return WidgetsApp.router(
      routerConfig: routerConfig,
      title: title,
      color: color,
      locale: locale,
      supportedLocales: supportedLocales,
      shortcuts: mergedShortcuts,
      actions: mergedActions,
      textStyle: textStyle,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const VScrollBehavior(),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
    );
  }
}
