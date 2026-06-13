import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child) {
  final theme = VThemeData.light().copyWith(
    motion: const VMotion(reducedMotion: true),
  );

  return Directionality(
    textDirection: TextDirection.ltr,
    child: VTheme(
      data: theme,
      child: child,
    ),
  );
}

Widget _wrapWithMediaPadding(
  Widget child, {
  EdgeInsets padding = EdgeInsets.zero,
}) {
  return MediaQuery(
    data: MediaQueryData(
      size: const Size(300, 400),
      padding: padding,
    ),
    child: _wrap(child),
  );
}

Widget _wrapWithHost(Widget child) {
  return _wrap(
    VOverlayHost(
      key: UniqueKey(),
      textDirection: TextDirection.ltr,
      child: child,
    ),
  );
}

Widget _fixedHeightFrame(Widget child) {
  return Center(
    child: SizedBox(
      height: 400,
      child: child,
    ),
  );
}

Widget _topFixedHeightFrame(Widget child) {
  return Align(
    alignment: Alignment.topCenter,
    child: SizedBox(
      height: 400,
      child: child,
    ),
  );
}

Future<void> _openSheet(
  WidgetTester tester, {
  required Widget child,
  VSheetSize size = VSheetSize.auto,
  double? minExtent,
  double? maxExtentFactor,
}) async {
  await tester.pumpWidget(_wrapWithHost(
    Builder(
      builder: (context) {
        return VButton(
          onPressed: () {
            VSheet.show<void>(
              context,
              edge: VSheetEdge.bottom,
              size: size,
              minExtent: minExtent,
              maxExtentFactor: maxExtentFactor,
              builder: (_) => VSheetSurface(
                edge: VSheetEdge.bottom,
                key: const ValueKey('sheet'),
                child: child,
              ),
            );
          },
          child: const Text('Open'),
        );
      },
    ),
  ));

  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

Future<void> _openDirectionalSheet(
  WidgetTester tester, {
  required VSheetEdge edge,
  VSheetSize size = VSheetSize.auto,
  double? minExtent,
  double? maxExtentFactor,
  Widget? child,
}) async {
  await tester.pumpWidget(_wrapWithHost(
    Builder(
      builder: (context) {
        return VButton(
          onPressed: () {
            VSheet.show<void>(
              context,
              edge: edge,
              size: size,
              minExtent: minExtent,
              maxExtentFactor: maxExtentFactor,
              builder: (_) => VSheetSurface(
                key: const ValueKey('sheet'),
                child: child ??
                    const SizedBox(
                      width: 80,
                      height: 80,
                      child: Text('Content'),
                    ),
              ),
            );
          },
          child: const Text('Open'),
        );
      },
    ),
  ));

  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

void main() {
  group('VSheet edges', () {
    testWidgets('positions vertical and horizontal sheets on each edge',
        (tester) async {
      await _openDirectionalSheet(tester, edge: VSheetEdge.bottom);
      expect(tester.getBottomLeft(find.byKey(const ValueKey('sheet'))).dy, 600);

      await _openDirectionalSheet(tester, edge: VSheetEdge.top);
      expect(tester.getTopLeft(find.byKey(const ValueKey('sheet'))).dy, 0);

      await _openDirectionalSheet(tester, edge: VSheetEdge.left);
      expect(tester.getTopLeft(find.byKey(const ValueKey('sheet'))).dx, 0);

      await _openDirectionalSheet(tester, edge: VSheetEdge.right);
      expect(tester.getTopRight(find.byKey(const ValueKey('sheet'))).dx, 800);
    });

    testWidgets('drag dismisses in the correct direction for each edge',
        (tester) async {
      Future<void> expectDismissed(VSheetEdge edge, Offset drag) async {
        await _openDirectionalSheet(tester, edge: edge);
        await tester.drag(find.byKey(const ValueKey('sheet')), drag);
        await tester.pumpAndSettle();
        expect(find.byKey(const ValueKey('sheet')), findsNothing);
      }

      await expectDismissed(VSheetEdge.bottom, const Offset(0, 120));
      await expectDismissed(VSheetEdge.top, const Offset(0, -120));
      await expectDismissed(VSheetEdge.left, const Offset(-120, 0));
      await expectDismissed(VSheetEdge.right, const Offset(120, 0));
    });

    testWidgets('barrier tap and escape close the sheet', (tester) async {
      Future<void> openAndClose({
        required Future<void> Function(WidgetTester tester) close,
      }) async {
        Future<void>? result;
        await tester.pumpWidget(_wrapWithHost(
          Builder(
            builder: (context) {
              return VButton(
                onPressed: () {
                  result = VSheet.show<void>(
                    context,
                    builder: (_) => const VSheetSurface(
                      key: ValueKey('sheet'),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Text('Content'),
                      ),
                    ),
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ));

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();
        await close(tester);
        await tester.pumpAndSettle();
        await expectLater(result, completion(isNull));
      }

      await openAndClose(
        close: (tester) => tester.tapAt(const Offset(20, 20)),
      );
      await openAndClose(
        close: (tester) => tester.sendKeyEvent(LogicalKeyboardKey.escape),
      );
    });

    testWidgets('VSheetScope closes with a typed result', (tester) async {
      Future<String?>? result;

      await tester.pumpWidget(_wrapWithHost(
        Builder(
          builder: (context) {
            return VButton(
              onPressed: () {
                result = VSheet.show<String>(
                  context,
                  builder: (ctx) => VSheetSurface(
                    child: VButton(
                      onPressed: () => VSheetScope.of<String>(ctx)('done'),
                      child: const Text('Choose'),
                    ),
                  ),
                );
              },
              child: const Text('Open'),
            );
          },
        ),
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Choose'));
      await tester.pumpAndSettle();

      await expectLater(result, completion('done'));
    });

    testWidgets('uses height constraints for vertical sheets', (tester) async {
      await _openDirectionalSheet(
        tester,
        edge: VSheetEdge.bottom,
        maxExtentFactor: 0.25,
        child: const SizedBox(height: 500, child: Text('Content')),
      );

      final size = tester.getSize(find.byKey(const ValueKey('sheet')));

      expect(size.height, lessThanOrEqualTo(151));
    });

    testWidgets('uses width constraints for horizontal sheets', (tester) async {
      await _openDirectionalSheet(
        tester,
        edge: VSheetEdge.left,
        maxExtentFactor: 0.25,
        child: const SizedBox(width: 500, child: Text('Content')),
      );

      final size = tester.getSize(find.byKey(const ValueKey('sheet')));

      expect(size.width, lessThanOrEqualTo(201));
    });
  });

  group('VSheet sizing', () {
    testWidgets('auto sheet sizes to content', (tester) async {
      await _openSheet(
        tester,
        child: const SizedBox(height: 80, child: Text('Content')),
      );

      final size = tester.getSize(find.byKey(const ValueKey('sheet')));

      expect(size.height, greaterThanOrEqualTo(80));
      expect(size.height, lessThan(180));
    });

    testWidgets('auto sheet shrink-wraps max-axis flex content',
        (tester) async {
      await _openSheet(
        tester,
        child: VFlex.vertical(
          gap: 12,
          children: const [
            SizedBox(height: 40, child: Text('Title')),
            SizedBox(height: 40, child: Text('Body')),
          ],
        ),
      );

      final size = tester.getSize(find.byKey(const ValueKey('sheet')));

      expect(size.height, lessThan(180));
    });

    testWidgets('minHeight forces a taller auto sheet', (tester) async {
      await _openSheet(
        tester,
        minExtent: 240,
        child: const SizedBox(height: 40, child: Text('Content')),
      );

      final size = tester.getSize(find.byKey(const ValueKey('sheet')));

      expect(size.height, greaterThanOrEqualTo(240));
    });

    testWidgets('maxHeightFactor caps auto sheet height', (tester) async {
      await _openSheet(
        tester,
        maxExtentFactor: 0.25,
        child: const SizedBox(height: 500, child: Text('Content')),
      );

      final size = tester.getSize(find.byKey(const ValueKey('sheet')));

      expect(size.height, lessThanOrEqualTo(151));
    });

    testWidgets('overlay sheet does not resize scaffold body', (tester) async {
      const bodyKey = ValueKey('body');

      await tester.pumpWidget(_wrapWithHost(
        _fixedHeightFrame(
          Builder(
            builder: (context) {
              return VScaffold(
                body: SizedBox(
                  key: bodyKey,
                  child: Center(
                    child: VButton(
                      onPressed: () {
                        VSheet.show<void>(
                          context,
                          edge: VSheetEdge.bottom,
                          size: VSheetSize.auto,
                          builder: (_) => const VSheetSurface(
                            edge: VSheetEdge.bottom,
                            child: SizedBox(height: 120, child: Text('Sheet')),
                          ),
                        );
                      },
                      child: const Text('Open'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ));

      final before = tester.getSize(find.byKey(bodyKey)).height;

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final after = tester.getSize(find.byKey(bodyKey)).height;

      expect(after, before);
    });
  });

  group('VScaffold bottomSheet', () {
    testWidgets('bottomSheet consumes body space and can be removed',
        (tester) async {
      const bodyKey = ValueKey('body');
      var open = false;

      Widget build() {
        return _wrap(
          _fixedHeightFrame(
            VScaffold(
              body: const SizedBox(key: bodyKey),
              bottomSheet: open
                  ? const SizedBox(height: 120, child: Text('Sheet'))
                  : null,
            ),
          ),
        );
      }

      await tester.pumpWidget(build());
      final closedHeight = tester.getSize(find.byKey(bodyKey)).height;

      open = true;
      await tester.pumpWidget(build());
      await tester.pumpAndSettle();
      final openHeight = tester.getSize(find.byKey(bodyKey)).height;

      open = false;
      await tester.pumpWidget(build());
      await tester.pumpAndSettle();
      final reopenedHeight = tester.getSize(find.byKey(bodyKey)).height;

      expect(closedHeight, 400);
      expect(openHeight, 280);
      expect(reopenedHeight, closedHeight);
    });

    testWidgets('footer remains above pushed bottomSheet', (tester) async {
      const footerKey = ValueKey('footer');
      const sheetKey = ValueKey('sheet');

      await tester.pumpWidget(_wrap(
        _fixedHeightFrame(
          const VScaffold(
            body: SizedBox(),
            footer: SizedBox(
              key: footerKey,
              height: 40,
              child: Text('Footer'),
            ),
            bottomSheet: SizedBox(
              key: sheetKey,
              height: 120,
              child: Text('Sheet'),
            ),
          ),
        ),
      ));

      final footerBottom = tester.getBottomLeft(find.byKey(footerKey)).dy;
      final sheetTop = tester.getTopLeft(find.byKey(sheetKey)).dy;

      expect(footerBottom, sheetTop);
    });
  });

  group('VScaffold safeArea', () {
    testWidgets('does not apply safe area by default', (tester) async {
      const headerKey = ValueKey('header');

      await tester.pumpWidget(_wrapWithMediaPadding(
        _topFixedHeightFrame(
          const VScaffold(
            header: SizedBox(
              key: headerKey,
              height: 40,
              child: Text('Header'),
            ),
            body: SizedBox(),
          ),
        ),
        padding: const EdgeInsets.only(top: 24),
      ));

      expect(tester.getTopLeft(find.byKey(headerKey)).dy, 0);
    });

    testWidgets('applies top safe area to header when enabled', (tester) async {
      const headerKey = ValueKey('header');

      await tester.pumpWidget(_wrapWithMediaPadding(
        _topFixedHeightFrame(
          const VScaffold(
            safeArea: true,
            header: SizedBox(
              key: headerKey,
              height: 40,
              child: Text('Header'),
            ),
            body: SizedBox(),
          ),
        ),
        padding: const EdgeInsets.only(top: 24),
      ));

      expect(tester.getTopLeft(find.byKey(headerKey)).dy, 24);
    });

    testWidgets('applies bottom safe area to footer without bottomSheet',
        (tester) async {
      const footerKey = ValueKey('footer');

      await tester.pumpWidget(_wrapWithMediaPadding(
        _topFixedHeightFrame(
          const VScaffold(
            safeArea: true,
            body: SizedBox(),
            footer: SizedBox(
              key: footerKey,
              height: 40,
              child: Text('Footer'),
            ),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 20),
      ));

      expect(tester.getBottomLeft(find.byKey(footerKey)).dy, 380);
    });

    testWidgets('applies bottom safe area to bottomSheet instead of footer',
        (tester) async {
      const footerKey = ValueKey('footer');
      const sheetKey = ValueKey('sheet');

      await tester.pumpWidget(_wrapWithMediaPadding(
        _topFixedHeightFrame(
          const VScaffold(
            safeArea: true,
            body: SizedBox(),
            footer: SizedBox(
              key: footerKey,
              height: 40,
              child: Text('Footer'),
            ),
            bottomSheet: SizedBox(
              key: sheetKey,
              height: 80,
              child: Text('Sheet'),
            ),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 20),
      ));

      final footerBottom = tester.getBottomLeft(find.byKey(footerKey)).dy;
      final sheetTop = tester.getTopLeft(find.byKey(sheetKey)).dy;
      final sheetBottom = tester.getBottomLeft(find.byKey(sheetKey)).dy;

      expect(footerBottom, sheetTop);
      expect(sheetBottom, 380);
    });
  });
}
