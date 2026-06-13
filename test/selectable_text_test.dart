import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child) {
  return VPlatformScope(
    behavior: VPlatformBehavior.desktop(isApple: false),
    child: VTheme(
      data: VThemeData.light(),
      child: VOverlayHost(
        textDirection: TextDirection.ltr,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(child: child),
        ),
      ),
    ),
  );
}

void main() {
  group('VSelectableText', () {
    testWidgets('renders provided text', (tester) async {
      await tester.pumpWidget(
        _wrap(const VSelectableText('This text can be selected.')),
      );

      expect(find.text('This text can be selected.'), findsOneWidget);
    });

    testWidgets('uses variant style from typography', (tester) async {
      final theme = VThemeData.light();

      await tester.pumpWidget(
        _wrap(const VSelectableText('Title', variant: VTextVariant.title)),
      );

      final editable = tester.widget<EditableText>(
        find.byType(EditableText),
      );

      expect(
        editable.style,
        theme.typography.title.copyWith(color: theme.colors.text),
      );
    });

    testWidgets('passes textAlign and maxLines to EditableText',
        (tester) async {
      await tester.pumpWidget(
        _wrap(
          const VSelectableText(
            'Aligned text',
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      );

      final editable = tester.widget<EditableText>(
        find.byType(EditableText),
      );

      expect(editable.textAlign, TextAlign.center);
      expect(editable.maxLines, 2);
    });

    testWidgets('passes contextMenuBuilder to EditableText', (tester) async {
      Widget contextMenuBuilder(
        BuildContext context,
        EditableTextState editableTextState,
      ) {
        return const SizedBox(key: ValueKey('custom-menu'));
      }

      await tester.pumpWidget(
        _wrap(
          VSelectableText(
            'Selectable content',
            contextMenuBuilder: contextMenuBuilder,
          ),
        ),
      );

      final editable = tester.widget<EditableText>(
        find.byType(EditableText),
      );

      expect(editable.contextMenuBuilder, same(contextMenuBuilder));
    });

    testWidgets('preserves default context menu when builder is omitted',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const VSelectableText('Selectable content')),
      );

      final editable = tester.widget<EditableText>(
        find.byType(EditableText),
      );

      expect(editable.contextMenuBuilder, isNotNull);
    });

    testWidgets('double tap keeps a word selected', (tester) async {
      await tester.pumpWidget(
        _wrap(const VSelectableText('Selectable content')),
      );

      final editable = find.byType(EditableText);
      final state = tester.state<EditableTextState>(editable);
      final caret = state.renderEditable.getLocalRectForCaret(
        const TextPosition(offset: 4),
      );
      final tapPosition = state.renderEditable.localToGlobal(caret.center);

      await tester.tapAt(tapPosition, kind: PointerDeviceKind.mouse);
      await tester.pump(const Duration(milliseconds: 80));
      await tester.tapAt(tapPosition, kind: PointerDeviceKind.mouse);
      await tester.pump(const Duration(milliseconds: 80));

      final selection = state.textEditingValue.selection;
      final selectedText = selection.textInside(state.textEditingValue.text);

      expect(selection.isCollapsed, isFalse);
      expect(selectedText, isIn(<String>['Selectable', 'content']));
    });

    testWidgets('long press selects a word and shows toolbar on all platforms', (tester) async {
      try {
        for (final platform in TargetPlatform.values) {
          debugDefaultTargetPlatformOverride = platform;

          await tester.pumpWidget(
            _wrap(const VSelectableText('Selectable content')),
          );

          final editable = find.byType(EditableText);
          final state = tester.state<EditableTextState>(editable);
          final caret = state.renderEditable.getLocalRectForCaret(
            const TextPosition(offset: 4),
          );
          final tapPosition = state.renderEditable.localToGlobal(caret.center);

          await tester.longPressAt(tapPosition);
          await tester.pumpAndSettle();

          final selection = state.textEditingValue.selection;
          final selectedText = selection.textInside(state.textEditingValue.text);

          expect(
            selection.isCollapsed,
            isFalse,
            reason: 'Failed long press selection on $platform',
          );
          expect(
            selectedText,
            isIn(<String>['Selectable', 'content']),
            reason: 'Failed long press selection on $platform',
          );
        }
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });

    testWidgets('default context menu avoids adaptive toolbar', (tester) async {
      await tester.pumpWidget(
        _wrap(const VSelectableText('Selectable content')),
      );

      final state = tester.state<EditableTextState>(find.byType(EditableText));
      state.selectAll(SelectionChangedCause.toolbar);
      state.showToolbar();
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Copy'), findsOneWidget);
      expect(find.text('Select All'), findsOneWidget);
      expect(find.text('Cut'), findsNothing);
      expect(find.text('Paste'), findsNothing);
    });

    testWidgets('default context menu item highlights on hover',
        (tester) async {
      final theme = VThemeData.light();

      await tester.pumpWidget(
        _wrap(const VSelectableText('Selectable content')),
      );

      final state = tester.state<EditableTextState>(find.byType(EditableText));
      state.selectAll(SelectionChangedCause.toolbar);
      state.showToolbar();
      await tester.pumpAndSettle();

      final copy = find.text('Copy');
      final pointer = TestPointer(1, PointerDeviceKind.mouse);
      await tester.sendEventToBinding(pointer.hover(tester.getCenter(copy)));
      await tester.pumpAndSettle();

      final coloredBox = tester.widget<ColoredBox>(
        find.ancestor(
          of: copy,
          matching: find.byType(ColoredBox),
        ),
      );

      expect(coloredBox.color, theme.colors.surfaceHover);
    });

    testWidgets(
      'selection context menu on desktop opens below cursor by default',
      (tester) async {
        await tester.pumpWidget(
          _wrap(const VSelectableText('Selectable content')),
        );

        final state =
            tester.state<EditableTextState>(find.byType(EditableText));
        state.selectAll(SelectionChangedCause.toolbar);
        state.showToolbar();
        await tester.pumpAndSettle();

        final menuFinder = find.byType(CustomPaint).last;
        final menuBox = tester.renderObject(menuFinder) as RenderBox;
        final menuOffset = menuBox.localToGlobal(Offset.zero);

        final textFinder = find.byType(EditableText);
        final textBox = tester.renderObject(textFinder) as RenderBox;
        final textOffset = textBox.localToGlobal(Offset.zero);

        expect(menuOffset.dy, greaterThan(textOffset.dy));
      },
    );
  });
}
