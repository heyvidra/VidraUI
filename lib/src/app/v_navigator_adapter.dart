import 'package:flutter/widgets.dart';

import '../foundation/v_scroll_behavior.dart';
import '../theme/v_theme_data.dart';
import 'v_page_route.dart';
import 'v_route_adapter.dart';

/// A [VRouteAdapter] that uses [WidgetsApp] for Navigator 1.0 routing.
///
/// Provide at least one of [home], [initialRoute], [routes], or
/// [onGenerateRoute] — the constructor asserts this.
class VNavigatorAdapter extends VRouteAdapter {
  const VNavigatorAdapter({
    this.home,
    this.navigatorKey,
    this.initialRoute,
    this.routes,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers,
  }) : assert(
          home != null ||
              initialRoute != null ||
              routes != null ||
              onGenerateRoute != null,
          'VNavigatorAdapter: provide home, initialRoute, routes, or onGenerateRoute.',
        );

  final Widget? home;
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? initialRoute;
  final Map<String, WidgetBuilder>? routes;
  final RouteFactory? onGenerateRoute;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;

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

    final motion = theme.motion;

    return _VNavigatorApp(
      navigatorKey: navigatorKey,
      initialRoute: initialRoute,
      routes: routes ?? const <String, WidgetBuilder>{},
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
      navigatorObservers: navigatorObservers,
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
        return VPageRoute<T>(
          settings: settings,
          builder: builder,
          motion: motion,
        );
      },
      title: title,
      color: color,
      locale: locale,
      supportedLocales: supportedLocales,
      shortcuts: mergedShortcuts,
      actions: mergedActions,
      textStyle: textStyle,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      home: home != null
          ? Directionality(
              textDirection: textDirection,
              child: DefaultTextStyle(
                style: textStyle,
                child: home!,
              ),
            )
          : null,
    );
  }
}

class _VNavigatorApp extends StatefulWidget {
  const _VNavigatorApp({
    required this.navigatorKey,
    required this.initialRoute,
    required this.routes,
    required this.onGenerateRoute,
    required this.onUnknownRoute,
    required this.navigatorObservers,
    required this.pageRouteBuilder,
    required this.title,
    required this.color,
    required this.locale,
    required this.supportedLocales,
    required this.shortcuts,
    required this.actions,
    required this.textStyle,
    required this.debugShowCheckedModeBanner,
    required this.home,
  });

  final GlobalKey<NavigatorState>? navigatorKey;
  final String? initialRoute;
  final Map<String, WidgetBuilder> routes;
  final RouteFactory? onGenerateRoute;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final PageRouteFactory pageRouteBuilder;
  final String title;
  final Color color;
  final Locale? locale;
  final Iterable<Locale> supportedLocales;
  final Map<ShortcutActivator, Intent> shortcuts;
  final Map<Type, Action<Intent>> actions;
  final TextStyle textStyle;
  final bool debugShowCheckedModeBanner;
  final Widget? home;

  @override
  State<_VNavigatorApp> createState() => _VNavigatorAppState();
}

class _VNavigatorAppState extends State<_VNavigatorApp> {
  late final HeroController _heroController;

  @override
  void initState() {
    super.initState();
    _heroController = HeroController();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      navigatorKey: widget.navigatorKey,
      initialRoute: widget.initialRoute,
      routes: widget.routes,
      onGenerateRoute: widget.onGenerateRoute,
      onUnknownRoute: widget.onUnknownRoute,
      navigatorObservers: <NavigatorObserver>[
        _heroController,
        ...?widget.navigatorObservers,
      ],
      pageRouteBuilder: widget.pageRouteBuilder,
      title: widget.title,
      color: widget.color,
      locale: widget.locale,
      supportedLocales: widget.supportedLocales,
      shortcuts: widget.shortcuts,
      actions: widget.actions,
      textStyle: widget.textStyle,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const VScrollBehavior(),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      home: widget.home,
    );
  }
}
