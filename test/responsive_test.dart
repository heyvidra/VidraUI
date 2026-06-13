import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

void main() {
  group('VBreakpointValues', () {
    test('defaults are valid', () {
      const v = VBreakpointValues();
      expect(v.sm, 600);
      expect(v.md, 840);
      expect(v.lg, 1200);
    });

    test('resolve returns xs for width < sm', () {
      const v = VBreakpointValues();
      expect(v.resolve(300), VBreakpoint.xs);
    });

    test('resolve returns sm for width in [sm, md)', () {
      const v = VBreakpointValues();
      expect(v.resolve(600), VBreakpoint.sm);
      expect(v.resolve(700), VBreakpoint.sm);
    });

    test('resolve returns md', () {
      const v = VBreakpointValues();
      expect(v.resolve(900), VBreakpoint.md);
    });

    test('resolve returns lg', () {
      const v = VBreakpointValues();
      expect(v.resolve(1200), VBreakpoint.lg);
    });

    test('resolve returns xl', () {
      const v = VBreakpointValues();
      expect(v.resolve(1500), VBreakpoint.xl);
    });

    test('resolve returns xxl', () {
      const v = VBreakpointValues();
      expect(v.resolve(2000), VBreakpoint.xxl);
    });

    test('copyWith preserves unspecified', () {
      const v = VBreakpointValues();
      final modified = v.copyWith(md: 900);
      expect(modified.sm, 600);
      expect(modified.md, 900);
      expect(modified.lg, 1200);
    });

    test('lerp interpolates values', () {
      const a = VBreakpointValues(sm: 400, md: 600);
      const b = VBreakpointValues(sm: 800, md: 1000);
      final r = VBreakpointValues.lerp(a, b, 0.5);
      expect(r.sm, 600);
      expect(r.md, 800);
    });
  });

  group('VResponsive.value', () {
    testWidgets('returns xs for narrow screen', (tester) async {
      await tester.pumpWidget(_wrap(child: const SizedBox(), width: 400));
      final context = tester.element(find.byType(SizedBox));
      final result = VResponsive.value<int>(context, xs: 1, md: 2, lg: 3);
      expect(result, 1);
    });

    testWidgets('falls back to nearest provided value', (tester) async {
      await tester.pumpWidget(_wrap(child: const SizedBox(), width: 1000));
      final context = tester.element(find.byType(SizedBox));
      // md provided but not lg; should use md
      final result =
          VResponsive.value<int>(context, xs: 1, md: 2, xxl: 3);
      expect(result, 2);
    });
  });
}

Widget _wrap({required Widget child, double width = 400}) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: VTheme(
      data: VThemeData.light(),
      child: MediaQuery(
        data: MediaQueryData(size: Size(width, 800)),
        child: child,
      ),
    ),
  );
}
