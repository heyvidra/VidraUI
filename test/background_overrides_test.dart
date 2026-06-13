import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

final _testTheme = VThemeData.light().copyWith(
  motion: const VMotion(reducedMotion: true),
);

Widget _wrap(Widget child) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: VTheme(
      data: _testTheme,
      child: child,
    ),
  );
}

Widget _wrapWithHost(Widget child) {
  return _wrap(
    VOverlayHost(
      textDirection: TextDirection.ltr,
      child: child,
    ),
  );
}

Iterable<BoxDecoration> _boxDecorations(WidgetTester tester) sync* {
  for (final box
      in tester.widgetList<DecoratedBox>(find.byType(DecoratedBox))) {
    final decoration = box.decoration;
    if (decoration is BoxDecoration) yield decoration;
  }
  for (final container
      in tester.widgetList<Container>(find.byType(Container))) {
    final decoration = container.decoration;
    if (decoration is BoxDecoration) yield decoration;
  }
}

bool _hasColor(WidgetTester tester, Color color) {
  return _boxDecorations(tester).any((decoration) => decoration.color == color);
}

bool _hasGradient(WidgetTester tester, Gradient gradient) {
  return _boxDecorations(tester)
      .any((decoration) => decoration.gradient == gradient);
}

void main() {
  group('background overrides', () {
    testWidgets('VScaffold renders color background', (tester) async {
      const color = Color(0xFF123456);

      await tester.pumpWidget(_wrap(
        const VScaffold(
          background: VBackground.color(color),
          body: SizedBox(width: 20, height: 20),
        ),
      ));

      expect(_hasColor(tester, color), isTrue);
    });

    testWidgets('VScaffold renders gradient background', (tester) async {
      const gradient = LinearGradient(
        colors: [Color(0xFF111111), Color(0xFF222222)],
      );

      await tester.pumpWidget(_wrap(
        const VScaffold(
          background: VBackground.gradient(gradient),
          body: SizedBox(width: 20, height: 20),
        ),
      ));

      expect(_hasGradient(tester, gradient), isTrue);
    });

    testWidgets('VScaffold uses default background without override',
        (tester) async {
      await tester.pumpWidget(_wrap(
        const VScaffold(body: SizedBox(width: 20, height: 20)),
      ));

      expect(_hasColor(tester, _testTheme.colors.background), isTrue);
    });

    testWidgets('VDialog surface background does not affect barrier',
        (tester) async {
      const surface = Color(0xFFABCDEF);

      await tester.pumpWidget(_wrapWithHost(
        Builder(
          builder: (context) {
            return VButton(
              onPressed: () {
                VDialog.show<void>(
                  context,
                  builder: (_) => const VDialogSurface(
                    surfaceBackground: VBackground.color(surface),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Text('Dialog'),
                    ),
                  ),
                );
              },
              child: const Text('Open dialog'),
            );
          },
        ),
      ));

      await tester.tap(find.text('Open dialog'));
      await tester.pumpAndSettle();

      expect(_hasColor(tester, surface), isTrue);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is ColoredBox &&
              widget.color == _testTheme.components.dialog.barrierColor,
        ),
        findsOneWidget,
      );
    });

    testWidgets('VSheet surface renders gradient background on bottom edge',
        (tester) async {
      const gradient = LinearGradient(
        colors: [Color(0xFF334155), Color(0xFF0EA5E9)],
      );

      await tester.pumpWidget(_wrapWithHost(
        Builder(
          builder: (context) {
            return VButton(
              onPressed: () {
                VSheet.show<void>(
                  context,
                  edge: VSheetEdge.bottom,
                  surfaceBackground: const VBackground.gradient(gradient),
                  builder: (_) => const SizedBox(
                    width: 40,
                    height: 40,
                    child: Text('Sheet'),
                  ),
                );
              },
              child: const Text('Open sheet'),
            );
          },
        ),
      ));

      await tester.tap(find.text('Open sheet'));
      await tester.pumpAndSettle();

      expect(_hasGradient(tester, gradient), isTrue);
    });

    testWidgets('VSheet surface background does not affect barrier',
        (tester) async {
      const surface = Color(0xFF0F766E);

      await tester.pumpWidget(_wrapWithHost(
        Builder(
          builder: (context) {
            return VButton(
              onPressed: () {
                VSheet.show<void>(
                  context,
                  edge: VSheetEdge.right,
                  surfaceBackground: const VBackground.color(surface),
                  builder: (_) => const SizedBox(
                    width: 40,
                    height: 40,
                    child: Text('Sheet'),
                  ),
                );
              },
              child: const Text('Open directional sheet'),
            );
          },
        ),
      ));

      await tester.tap(find.text('Open directional sheet'));
      await tester.pumpAndSettle();

      expect(_hasColor(tester, surface), isTrue);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is ColoredBox &&
              widget.color ==
                  _testTheme.colors.surfaceElevated.withValues(alpha: 0.7),
        ),
        findsOneWidget,
      );
    });

    testWidgets('VToast renders background override', (tester) async {
      const color = Color(0xFF312E81);

      await tester.pumpWidget(_wrapWithHost(
        Builder(
          builder: (context) {
            return VButton(
              onPressed: () {
                VToast.show(
                  context,
                  message: 'Saved',
                  duration: const Duration(hours: 1),
                  background: const VBackground.color(color),
                );
              },
              child: const Text('Show toast'),
            );
          },
        ),
      ));

      await tester.tap(find.text('Show toast'));
      await tester.pumpAndSettle();

      expect(_hasColor(tester, color), isTrue);
    });

    testWidgets('VPopover surface renders gradient background', (tester) async {
      const gradient = LinearGradient(
        colors: [Color(0xFF7C3AED), Color(0xFFF97316)],
      );

      await tester.pumpWidget(_wrapWithHost(
        Builder(
          builder: (context) {
            return VButton(
              onPressed: () {
                VPopover.show(
                  context,
                  dismissOnTapOutside: false,
                  surfaceBackground: const VBackground.gradient(gradient),
                  builder: (_) => const Text('Popover'),
                );
              },
              child: const Text('Show popover'),
            );
          },
        ),
      ));

      await tester.tap(find.text('Show popover'));
      await tester.pump();

      expect(_hasGradient(tester, gradient), isTrue);
    });
  });
}
