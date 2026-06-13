import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

void main() {
  group('VScrollbar & VScrollArea Tests', () {
    testWidgets('renders children and wraps in ScrollConfiguration', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: VThemeData.light(),
            child: const VScrollArea(
              child: SizedBox(
                height: 1000,
                width: 200,
                key: Key('scroll_content'),
              ),
            ),
          ),
        ),
      );

      // Verify that children are rendered
      expect(find.byKey(const Key('scroll_content')), findsOneWidget);

      // Verify ScrollConfiguration is present
      expect(find.byType(ScrollConfiguration), findsOneWidget);
    });

    testWidgets('shows scrollbar by default and respects showScrollbar: false', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: VThemeData.light(),
            child: const VScrollArea(
              showScrollbar: true,
              child: SizedBox(
                height: 1000,
                width: 200,
              ),
            ),
          ),
        ),
      );

      // Should find VScrollbar when showScrollbar is true
      expect(find.byType(VScrollbar), findsOneWidget);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: VThemeData.light(),
            child: const VScrollArea(
              showScrollbar: false,
              child: SizedBox(
                height: 1000,
                width: 200,
              ),
            ),
          ),
        ),
      );

      // Should not find VScrollbar when showScrollbar is false
      expect(find.byType(VScrollbar), findsNothing);
    });

    testWidgets('uses provided ScrollController and creates internal one if null', (tester) async {
      final customController = ScrollController();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: VThemeData.light(),
            child: VScrollArea(
              controller: customController,
              child: const SizedBox(
                height: 1000,
                width: 200,
              ),
            ),
          ),
        ),
      );

      final singleScrollView = tester.widget<SingleChildScrollView>(
        find.byType(SingleChildScrollView),
      );

      expect(singleScrollView.controller, same(customController));

      // Test with null controller (should use managed internal controller)
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: VThemeData.light(),
            child: const VScrollArea(
              child: SizedBox(
                height: 1000,
                width: 200,
              ),
            ),
          ),
        ),
      );

      final singleScrollViewWithInternal = tester.widget<SingleChildScrollView>(
        find.byType(SingleChildScrollView),
      );

      expect(singleScrollViewWithInternal.controller, isNotNull);
    });

    testWidgets('extension method scrollable() wraps widget in VScrollArea correctly', (tester) async {
      final controller = ScrollController();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: VThemeData.light(),
            child: const SizedBox(
              height: 1000,
              width: 200,
              key: Key('extension_child'),
            ).scrollable(
              controller: controller,
              showScrollbar: true,
            ),
          ),
        ),
      );

      expect(find.byType(VScrollArea), findsOneWidget);
      expect(find.byKey(const Key('extension_child')), findsOneWidget);

      final scrollArea = tester.widget<VScrollArea>(find.byType(VScrollArea));
      expect(scrollArea.controller, same(controller));
      expect(scrollArea.showScrollbar, isTrue);
    });

    testWidgets('VScrollbar reads styling from VTheme', (tester) async {
      final customTheme = VThemeData.light().copyWith(
        components: VComponentTokens.fromColors(VColors.light()).copyWith(
          scrollbar: const VScrollbarTokens(
            thickness: 12.0,
            radius: 6.0,
            thumbColor: Color(0xFFFF0000), // Red thumb
          ),
        ),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: customTheme,
            child: const VScrollArea(
              child: SizedBox(
                height: 1000,
                width: 200,
              ),
            ),
          ),
        ),
      );

      final rawScrollbar = tester.widget<RawScrollbar>(find.byType(RawScrollbar));

      expect(rawScrollbar.thickness, 12.0);
      expect(rawScrollbar.radius, const Radius.circular(6.0));
      expect(rawScrollbar.thumbColor, const Color(0xFFFF0000));
    });

    testWidgets('only builds one scrollbar in macOS/desktop environment', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      try {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: VTheme(
              data: VThemeData.light(),
              child: const VScrollArea(
                showScrollbar: true,
                child: SizedBox(
                  height: 1000,
                  width: 200,
                ),
              ),
            ),
          ),
        );

        // In macOS, the default ScrollBehavior would normally add its own Scrollbar.
        // But VScrollArea uses VScrollBehavior which should suppress it, leaving only VScrollbar's RawScrollbar.
        expect(find.byType(RawScrollbar), findsOneWidget);
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });
  });
}
