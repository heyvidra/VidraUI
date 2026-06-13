import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';


import '../foundation/foundation.dart';
import '../theme/v_animated_theme.dart';
import '../theme/v_theme.dart';
import '../theme/v_theme_data.dart';
import '../theme/v_theme_mode.dart'
    show VThemeMode; // _VThemeModeResolver is private — defined locally below
import 'v_navigator_adapter.dart';
import 'v_overlay_host.dart';
import 'v_route_adapter.dart';
import 'v_router_config_adapter.dart';

/// The root widget for a VidraUI application.
///
/// Provides theme resolution, animated theme transitions, overlay management,
/// focus traversal, scroll behavior, and either Navigator 1.0 or Router 2.0
/// routing — all built on [WidgetsApp].
///
/// Use [VidraApp.navigator] for simple Navigator-based routing, or
/// [VidraApp.router] for declarative Router-based routing.
class VidraApp extends StatelessWidget {
  // ---------------------------------------------------------------------------
  // Named factories
  // ---------------------------------------------------------------------------

  /// Navigator-based routing (simple apps).
  ///
  /// At least one of [home], [initialRoute], [routes], or [onGenerateRoute]
  /// must be provided. The [VNavigatorAdapter] asserts this.
  factory VidraApp.navigator({
    Widget? home,
    GlobalKey<NavigatorState>? navigatorKey,
    String title = '',
    VThemeData? theme,
    VThemeData? darkTheme,
    VThemeMode themeMode = VThemeMode.system,
    Map<String, WidgetBuilder>? routes,
    RouteFactory? onGenerateRoute,
    RouteFactory? onUnknownRoute,
    String? initialRoute,
    List<NavigatorObserver>? navigatorObservers,
    Locale? locale,
    Iterable<Locale> supportedLocales = const <Locale>[Locale('en')],
    TextDirection textDirection = TextDirection.ltr,
    Map<ShortcutActivator, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
  }) {
    return VidraApp._(
      adapter: VNavigatorAdapter(
        home: home,
        navigatorKey: navigatorKey,
        routes: routes,
        onGenerateRoute: onGenerateRoute,
        onUnknownRoute: onUnknownRoute,
        initialRoute: initialRoute,
        navigatorObservers: navigatorObservers,
      ),
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      title: title,
      locale: locale,
      supportedLocales: supportedLocales,
      textDirection: textDirection,
      shortcuts: shortcuts,
      actions: actions,
    );
  }

  /// Router-based routing (declarative, deep-link support).
  ///
  /// [routerConfig] carries its own back button dispatcher inside
  /// [RouterConfig.backButtonDispatcher] — do not pass a separate one.
  factory VidraApp.router({
    required RouterConfig<Object> routerConfig,
    String title = '',
    VThemeData? theme,
    VThemeData? darkTheme,
    VThemeMode themeMode = VThemeMode.system,
    Locale? locale,
    Iterable<Locale> supportedLocales = const <Locale>[Locale('en')],
    TextDirection textDirection = TextDirection.ltr,
    Map<ShortcutActivator, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
  }) {
    return VidraApp._(
      adapter: VRouterConfigAdapter(
        routerConfig: routerConfig,
      ),
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      title: title,
      locale: locale,
      supportedLocales: supportedLocales,
      textDirection: textDirection,
      shortcuts: shortcuts,
      actions: actions,
    );
  }
  const VidraApp._({
    required this.adapter,
    required this.theme,
    required this.darkTheme,
    required this.themeMode,
    this.title = '',
    this.locale,
    this.supportedLocales = const <Locale>[Locale('en')],
    this.textDirection = TextDirection.ltr,
    this.shortcuts,
    this.actions,
  });

  /// The routing strategy used by this app.
  final VRouteAdapter adapter;

  /// The light theme.
  final VThemeData? theme;

  /// The dark theme.
  final VThemeData? darkTheme;

  /// Determines which theme to use.
  final VThemeMode themeMode;

  /// A one-line description used by the device to identify the app.
  final String title;

  /// The initial locale for the app.
  final Locale? locale;

  /// The locales the app has been localised for.
  final Iterable<Locale> supportedLocales;

  /// The text direction to use. Defaults to [TextDirection.ltr].
  final TextDirection textDirection;

  /// Additional keyboard shortcuts. Merged with [WidgetsApp.defaultShortcuts]
  /// inside the route adapter. User shortcuts override defaults.
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// Additional intent-to-action mappings. Merged with
  /// [WidgetsApp.defaultActions] inside the route adapter.
  /// User actions override defaults.
  final Map<Type, Action<Intent>>? actions;

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? VThemeData.light();
    final effectiveDark = darkTheme ?? VThemeData.dark();
    // Resolve the platform behavior once at the app root.
    // Respect any pre-existing VPlatformScope (e.g. from tests or parent wrappers).
    final parentScope = context.dependOnInheritedWidgetOfExactType<VPlatformScope>();
    final platformBehavior = parentScope?.behavior ?? VPlatformBehavior.resolve(defaultTargetPlatform);

    return VPlatformScope(
      behavior: platformBehavior,
      child: _VThemeModeResolver(
        theme: effectiveTheme,
        darkTheme: effectiveDark,
        themeMode: themeMode,
        builder: (context, resolvedTheme) {
          return VAnimatedTheme(
            data: resolvedTheme,
            child: Builder(
              builder: (context) {
                final vTheme = VTheme.of(context);
                final defaultTextStyle = vTheme.typography.body;

                return VOverlayHost(
                  textDirection: textDirection,
                  child: FocusTraversalGroup(
                    policy: ReadingOrderTraversalPolicy(),
                    child: adapter.buildApp(
                      context: context,
                      theme: vTheme,
                      title: title,
                      color: vTheme.colors.actionPrimary,
                      locale: locale,
                      supportedLocales: supportedLocales,
                      textDirection: textDirection,
                      shortcuts: shortcuts ?? const {},
                      actions: actions ?? const {},
                      textStyle: defaultTextStyle,
                      debugShowCheckedModeBanner: false,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Internal theme mode resolver
// ---------------------------------------------------------------------------

class _VThemeModeResolver extends StatefulWidget {
  const _VThemeModeResolver({
    required this.theme,
    required this.darkTheme,
    required this.themeMode,
    required this.builder,
  });

  final VThemeData theme;
  final VThemeData darkTheme;
  final VThemeMode themeMode;
  final Widget Function(BuildContext context, VThemeData resolvedTheme) builder;

  @override
  State<_VThemeModeResolver> createState() => _VThemeModeResolverState();
}

class _VThemeModeResolverState extends State<_VThemeModeResolver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(_VThemeModeResolver oldWidget) {
    super.didUpdateWidget(oldWidget);
    // React to programmatic theme or mode changes without relying on a
    // full widget-tree rebuild from the parent.
    if (widget.theme != oldWidget.theme ||
        widget.darkTheme != oldWidget.darkTheme ||
        widget.themeMode != oldWidget.themeMode) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {});
  }

  @override
  void didChangeAccessibilityFeatures() {
    setState(() {});
  }

  VThemeData _resolve() {
    final baseTheme = switch (widget.themeMode) {
      VThemeMode.light => widget.theme,
      VThemeMode.dark => widget.darkTheme,
      VThemeMode.system => switch (
            WidgetsBinding.instance.platformDispatcher.platformBrightness) {
          Brightness.dark => widget.darkTheme,
          Brightness.light => widget.theme,
        },
    };

    final systemReduceMotion = WidgetsBinding
        .instance.platformDispatcher.accessibilityFeatures.reduceMotion;

    if (systemReduceMotion) {
      return baseTheme.copyWith(
        motion: baseTheme.motion.copyWith(reducedMotion: true),
      );
    }
    return baseTheme;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _resolve());
  }
}
