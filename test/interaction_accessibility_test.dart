import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: VTheme(
      data: VThemeData.light(),
      child: child,
    ),
  );
}

Widget _wrapWithOverlay(Widget child) {
  return _wrap(
    Overlay(
      initialEntries: [
        OverlayEntry(builder: (_) => child),
      ],
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

void main() {
  group('interaction accessibility', () {
    testWidgets('VRadio activates with Space', (tester) async {
      var fired = false;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(_wrap(
        VRadio(
          selected: false,
          focusNode: focusNode,
          onSelected: () => fired = true,
        ),
      ));

      focusNode.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.space);

      expect(fired, isTrue);
    });

    testWidgets('VSlider responds to keyboard controls', (tester) async {
      var value = 0.5;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(_wrap(
        VSlider(
          value: value,
          min: 0,
          max: 1,
          step: 0.1,
          focusNode: focusNode,
          onChanged: (next) => value = next,
        ),
      ));

      focusNode.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      expect(value, closeTo(0.6, 0.001));

      await tester.sendKeyEvent(LogicalKeyboardKey.home);
      expect(value, 0);

      await tester.sendKeyEvent(LogicalKeyboardKey.end);
      expect(value, 1);
    });

    testWidgets('VSelect single selection uses typed callback from keyboard',
        (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      try {
        String? selected;
        final options = [
          const VSelectOption(value: 'a', label: 'Disabled', enabled: false),
          const VSelectOption(value: 'b', label: 'Enabled'),
        ];

        await tester.pumpWidget(_wrapWithOverlay(
          Center(
            child: SizedBox(
              width: 240,
              child: VSelect<String>(
                options: options,
                placeholder: 'Choose',
                onChanged: (value) => selected = value,
              ),
            ),
          ),
        ));

        await tester.tap(find.byType(VSelect<String>));
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pump();

        expect(selected, 'b');
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });

    testWidgets('VSelect multiple selection uses typed callback',
        (tester) async {
      Set<String>? selected;
      const options = [
        VSelectOption(value: 'a', label: 'Option A'),
        VSelectOption(value: 'b', label: 'Option B'),
      ];

      await tester.pumpWidget(_wrapWithOverlay(
        Center(
          child: SizedBox(
            width: 240,
            child: VSelect<String>.multiple(
              options: options,
              values: const {},
              onChangedMultiple: (value) => selected = value,
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(VSelect<String>));
      await tester.pump();
      await tester.tap(find.text('Option A').last);
      await tester.pump();

      expect(selected, {'a'});
    });

    testWidgets('VSelect uses VidraUI overlay host when available',
        (tester) async {
      String? selected;

      await tester.pumpWidget(_wrapWithHost(
        StatefulBuilder(
          builder: (context, setState) {
            return Center(
              child: SizedBox(
                width: 240,
                child: VSelect<String>(
                  options: const [
                    VSelectOption(value: 'a', label: 'Option A'),
                    VSelectOption(value: 'b', label: 'Option B'),
                  ],
                  value: selected,
                  placeholder: 'Choose',
                  onChanged: (value) {
                    setState(() => selected = value);
                  },
                ),
              ),
            );
          },
        ),
      ));

      await tester.tap(find.byType(VSelect<String>));
      await tester.pump();

      expect(find.text('Option B'), findsOneWidget);

      await tester.tap(find.text('Option B').last);
      await tester.pump();

      expect(selected, 'b');
      expect(find.text('Option B'), findsOneWidget);
    });

    testWidgets('VSelect defers overlay rebuild when theme changes while open',
        (tester) async {
      var dark = false;

      await tester.pumpWidget(StatefulBuilder(
        builder: (context, setState) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: VTheme(
              data: dark ? VThemeData.dark() : VThemeData.light(),
              child: VOverlayHost(
                textDirection: TextDirection.ltr,
                child: Center(
                  child: SizedBox(
                    width: 240,
                    child: VSelect<String>(
                      options: const [
                        VSelectOption(value: 'a', label: 'Option A'),
                        VSelectOption(value: 'b', label: 'Option B'),
                      ],
                      placeholder: 'Choose',
                      onChanged: (_) {},
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ));

      await tester.tap(find.byType(VSelect<String>));
      await tester.pump();
      expect(find.text('Option B'), findsOneWidget);

      dark = true;
      await tester.pumpWidget(StatefulBuilder(
        builder: (context, setState) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: VTheme(
              data: dark ? VThemeData.dark() : VThemeData.light(),
              child: VOverlayHost(
                textDirection: TextDirection.ltr,
                child: Center(
                  child: SizedBox(
                    width: 240,
                    child: VSelect<String>(
                      options: const [
                        VSelectOption(value: 'a', label: 'Option A'),
                        VSelectOption(value: 'b', label: 'Option B'),
                      ],
                      placeholder: 'Choose',
                      onChanged: (_) {},
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('Option B'), findsOneWidget);
    });

    testWidgets('VSelect opens upward near bottom when placement is auto',
        (tester) async {
      await tester.pumpWidget(_wrapWithOverlay(
        const SizedBox(
          width: 800,
          height: 600,
          child: Stack(
            children: [
              Positioned(
                left: 100,
                top: 520,
                width: 240,
                child: VSelect<int>(
                  options: [
                    VSelectOption(value: 0, label: 'Boundary option 0'),
                    VSelectOption(value: 1, label: 'Boundary option 1'),
                    VSelectOption(value: 2, label: 'Boundary option 2'),
                  ],
                  placeholder: 'Boundary pick',
                ),
              ),
            ],
          ),
        ),
      ));

      final triggerTop = tester.getTopLeft(find.text('Boundary pick')).dy;

      await tester.tap(find.byType(VSelect<int>));
      await tester.pump();

      expect(
        tester.getTopLeft(find.text('Boundary option 0')).dy,
        lessThan(triggerTop),
      );
    });

    testWidgets('VSelect opens downward near top when placement is auto',
        (tester) async {
      await tester.pumpWidget(_wrapWithOverlay(
        const SizedBox(
          width: 800,
          height: 600,
          child: Stack(
            children: [
              Positioned(
                left: 100,
                top: 20,
                width: 240,
                child: VSelect<int>(
                  options: [
                    VSelectOption(value: 0, label: 'Top option 0'),
                    VSelectOption(value: 1, label: 'Top option 1'),
                  ],
                  placeholder: 'Top pick',
                ),
              ),
            ],
          ),
        ),
      ));

      final triggerTop = tester.getTopLeft(find.text('Top pick')).dy;

      await tester.tap(find.byType(VSelect<int>));
      await tester.pump();

      expect(
        tester.getTopLeft(find.text('Top option 0')).dy,
        greaterThan(triggerTop),
      );
    });

    testWidgets('VSelect respects forced upward placement', (tester) async {
      await tester.pumpWidget(_wrapWithOverlay(
        const SizedBox(
          width: 800,
          height: 600,
          child: Center(
            child: SizedBox(
              width: 240,
              child: VSelect<int>(
                menuPlacement: VAnchoredOverlayPlacement.up,
                options: [
                  VSelectOption(value: 0, label: 'Forced up option'),
                ],
                placeholder: 'Forced up pick',
              ),
            ),
          ),
        ),
      ));

      final triggerTop = tester.getTopLeft(find.text('Forced up pick')).dy;

      await tester.tap(find.byType(VSelect<int>));
      await tester.pump();

      expect(
        tester.getTopLeft(find.text('Forced up option')).dy,
        lessThan(triggerTop),
      );
    });

    testWidgets('VSelect respects forced downward placement', (tester) async {
      await tester.pumpWidget(_wrapWithOverlay(
        const SizedBox(
          width: 800,
          height: 600,
          child: Center(
            child: SizedBox(
              width: 240,
              child: VSelect<int>(
                menuPlacement: VAnchoredOverlayPlacement.down,
                options: [
                  VSelectOption(value: 0, label: 'Forced down option'),
                ],
                placeholder: 'Forced down pick',
              ),
            ),
          ),
        ),
      ));

      final triggerTop = tester.getTopLeft(find.text('Forced down pick')).dy;

      await tester.tap(find.byType(VSelect<int>));
      await tester.pump();

      expect(
        tester.getTopLeft(find.text('Forced down option')).dy,
        greaterThan(triggerTop),
      );
    });

    testWidgets('VSelect clamps menu height to available space',
        (tester) async {
      await tester.pumpWidget(_wrapWithOverlay(
        SizedBox(
          width: 800,
          height: 600,
          child: Stack(
            children: [
              Positioned(
                left: 100,
                top: 520,
                width: 240,
                child: VSelect<int>(
                  menuPlacement: VAnchoredOverlayPlacement.down,
                  maxMenuHeight: 280,
                  options: List.generate(
                    20,
                    (i) => VSelectOption(
                      value: i,
                      label: 'Clamped option $i',
                    ),
                  ),
                  placeholder: 'Clamped pick',
                ),
              ),
            ],
          ),
        ),
      ));

      await tester.tap(find.byType(VSelect<int>));
      await tester.pump();

      expect(tester.getSize(find.byType(ListView)).height, lessThan(280));
      expect(tester.getBottomRight(find.byType(ListView)).dy,
          lessThanOrEqualTo(600));
    });

    testWidgets('VDialog.show renders VDialogSurface correctly',
        (tester) async {
      late BuildContext dialogContext;

      await tester.pumpWidget(_wrapWithHost(
        Builder(
          builder: (context) {
            dialogContext = context;
            return const SizedBox.shrink();
          },
        ),
      ));

      unawaited(VDialog.show<void>(
        dialogContext,
        builder: (_) => const VDialogSurface(
          child: Text('Plain body'),
        ),
      ));
      await tester.pump();

      expect(find.byType(VDialogSurface), findsOneWidget);
      expect(find.text('Plain body'), findsOneWidget);
    });

    testWidgets('VDialog.show does not double-wrap VAlertDialog',
        (tester) async {
      late BuildContext dialogContext;

      await tester.pumpWidget(_wrapWithHost(
        Builder(
          builder: (context) {
            dialogContext = context;
            return const SizedBox.shrink();
          },
        ),
      ));

      unawaited(VDialog.show<void>(
        dialogContext,
        builder: (_) => const VAlertDialog(
          title: 'Alert Title',
          body: 'Alert Body',
        ),
      ));
      await tester.pump();

      expect(find.byType(VDialogSurface), findsOneWidget);
      expect(find.text('Alert Title'), findsOneWidget);
      expect(find.text('Alert Body'), findsOneWidget);
    });

    testWidgets('VDialog.show completes if host is disposed', (tester) async {
      late BuildContext dialogContext;

      await tester.pumpWidget(_wrapWithHost(
        Builder(
          builder: (context) {
            dialogContext = context;
            return const SizedBox.shrink();
          },
        ),
      ));

      final result = VDialog.show<String>(
        dialogContext,
        builder: (_) => const VDialogSurface(
          child: Text('Disposable dialog'),
        ),
      );
      await tester.pump();

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await expectLater(result, completion(isNull));
    });

    testWidgets('VToast uses component tokens for visual styling',
        (tester) async {
      const customBackground = Color(0xFF123456);
      const customForeground = Color(0xFFABCDEF);
      final base = VThemeData.light();
      final theme = base.copyWith(
        components: base.components.copyWith(
          toast: base.components.toast.copyWith(
            infoBackground: customBackground,
            infoForeground: customForeground,
            paddingHorizontal: 30,
            paddingVertical: 14,
            radius: 18,
            iconSize: 22,
            textSize: 17,
            spacing: 11,
            horizontalInset: 40,
            verticalInset: 32,
          ),
        ),
      );
      late BuildContext toastContext;

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: VTheme(
          data: theme,
          child: VOverlayHost(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (context) {
                toastContext = context;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ));

      VToast.show(
        toastContext,
        message: 'Tokenized toast',
        duration: const Duration(seconds: 30),
      );
      await tester.pump();

      final decorated = tester.widgetList<DecoratedBox>(
        find.byType(DecoratedBox),
      );
      final toastDecoration = decorated
          .map((box) => box.decoration)
          .whereType<BoxDecoration>()
          .firstWhere((decoration) => decoration.color == customBackground);

      expect(toastDecoration.borderRadius, BorderRadius.circular(18));
      expect(
        tester.widget<Text>(find.text('Tokenized toast')).style?.color,
        customForeground,
      );
      expect(
        tester.widget<Text>(find.text('Tokenized toast')).style?.fontSize,
        17,
      );
      expect(tester.getTopLeft(find.byType(FadeTransition)).dx, 40);
    });

    testWidgets('VTooltip renders in overlay on pointer hover', (tester) async {
      await tester.pumpWidget(_wrapWithHost(
        const Center(
          child: VTooltip(
            message: 'Helpful tooltip',
            waitDuration: Duration.zero,
            child: SizedBox(
              key: ValueKey('hover-target'),
              width: 80,
              height: 40,
            ),
          ),
        ),
      ));

      await tester.sendEventToBinding(PointerHoverEvent(
        kind: PointerDeviceKind.mouse,
        position: tester.getCenter(find.byKey(const ValueKey('hover-target'))),
      ));
      await tester.pump();

      expect(find.text('Helpful tooltip'), findsOneWidget);
    });

    testWidgets('VTooltip renders in overlay on long press', (tester) async {
      await tester.pumpWidget(_wrapWithHost(
        const Center(
          child: VTooltip(
            message: 'Touch tooltip',
            waitDuration: Duration.zero,
            child: SizedBox(
              key: ValueKey('touch-target'),
              width: 80,
              height: 40,
            ),
          ),
        ),
      ));

      await tester.longPress(
        find.byKey(const ValueKey('touch-target')),
        warnIfMissed: false,
      );
      await tester.pump();

      expect(find.text('Touch tooltip'), findsOneWidget);
    });

    testWidgets('VTooltip replaces the active touch tooltip', (tester) async {
      await tester.pumpWidget(_wrapWithHost(
        const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              VTooltip(
                message: 'First tooltip',
                waitDuration: Duration.zero,
                showDuration: Duration(seconds: 2),
                child: SizedBox(
                  key: ValueKey('first-tooltip-target'),
                  width: 80,
                  height: 40,
                ),
              ),
              SizedBox(width: 16),
              VTooltip(
                message: 'Second tooltip',
                waitDuration: Duration.zero,
                showDuration: Duration(seconds: 2),
                child: SizedBox(
                  key: ValueKey('second-tooltip-target'),
                  width: 80,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ));

      await tester.longPress(
        find.byKey(const ValueKey('first-tooltip-target')),
        warnIfMissed: false,
      );
      await tester.pump();
      expect(find.text('First tooltip'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 1900));
      await tester.longPress(
        find.byKey(const ValueKey('second-tooltip-target')),
        warnIfMissed: false,
      );
      await tester.pump();

      expect(find.text('First tooltip'), findsNothing);
      expect(find.text('Second tooltip'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('First tooltip'), findsNothing);
      expect(find.text('Second tooltip'), findsOneWidget);
    });
  });
}
