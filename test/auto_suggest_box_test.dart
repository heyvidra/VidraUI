import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: VTheme(
      data: VThemeData.light(),
      child: VOverlayHost(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 320,
            child: child,
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('VAutoSuggestBox', () {
    testWidgets('renders basic VAutoSuggestBox and shows input',
        (tester) async {
      await tester.pumpWidget(
        _wrap(
          VAutoSuggestBox(
            label: 'Country',
            hint: 'Search...',
            suggestionsBuilder: (query) => const [],
          ),
        ),
      );

      expect(find.byType(VTextField), findsOneWidget);
      expect(find.text('Country'), findsOneWidget);
    });

    testWidgets('shows suggestions on typing', (tester) async {
      final builderCalled = <String>[];
      await tester.pumpWidget(
        _wrap(
          VAutoSuggestBox(
            label: 'Country',
            suggestionsBuilder: (query) {
              builderCalled.add(query);
              if (query == 'Can') {
                return [
                  const VAutoSuggestItem(value: 'CA', label: 'Canada'),
                ];
              }
              return const [];
            },
          ),
        ),
      );

      // Focus the input
      await tester.tap(find.byType(EditableText));
      await tester.pump();

      // Type 'Can'
      tester.testTextInput.enterText('Can');
      await tester.pumpAndSettle();

      expect(builderCalled.contains('Can'), isTrue);
      expect(find.text('Canada'), findsOneWidget);
    });

    testWidgets('selects item on tap', (tester) async {
      final selectedItems = <VAutoSuggestItem>[];
      final controller = TextEditingController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _wrap(
          VAutoSuggestBox(
            controller: controller,
            suggestionsBuilder: (query) {
              if (query == 'U') {
                return [
                  const VAutoSuggestItem(value: 'US', label: 'United States'),
                ];
              }
              return const [];
            },
            onSelected: (item) {
              selectedItems.add(item);
            },
          ),
        ),
      );

      // Focus & type 'U'
      await tester.tap(find.byType(EditableText));
      await tester.pump();
      tester.testTextInput.enterText('U');
      await tester.pumpAndSettle();

      // Verify suggestion is visible
      expect(find.text('United States'), findsOneWidget);

      // Tap on the suggestion
      await tester.tap(find.text('United States'));
      await tester.pumpAndSettle();

      // Dropdown should close, selected item should be updated
      expect(selectedItems.length, 1);
      expect(selectedItems.first.value, 'US');
      expect(controller.text, 'United States');
      expect(find.text('United States'),
          findsOneWidget); // still inside the input controller
    });

    testWidgets('supports keyboard navigation (ArrowDown, Enter, Esc)',
        (tester) async {
      final selectedItems = <VAutoSuggestItem>[];
      final controller = TextEditingController();
      final focusNode = FocusNode();
      addTearDown(controller.dispose);
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(
        _wrap(
          VAutoSuggestBox(
            controller: controller,
            focusNode: focusNode,
            suggestionsBuilder: (query) {
              if (query == 'A') {
                return [
                  const VAutoSuggestItem(value: 'AU', label: 'Australia'),
                  const VAutoSuggestItem(value: 'AT', label: 'Austria'),
                ];
              }
              return const [];
            },
            onSelected: (item) {
              selectedItems.add(item);
            },
          ),
        ),
      );

      // Focus & type 'A'
      focusNode.requestFocus();
      await tester.pump();
      tester.testTextInput.enterText('A');
      await tester.pumpAndSettle();

      expect(find.text('Australia'), findsOneWidget);
      expect(find.text('Austria'), findsOneWidget);

      // Press ArrowDown to highlight 'Australia'
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();

      // Press ArrowDown again to highlight 'Austria'
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();

      // Press Enter to select highlighted item ('Austria')
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(selectedItems.length, 1);
      expect(selectedItems.first.value, 'AT');
      expect(controller.text, 'Austria');
    });

    testWidgets('respects custom maxDropdownHeight', (tester) async {
      await tester.pumpWidget(
        _wrap(
          VAutoSuggestBox(
            maxDropdownHeight: 72,
            suggestionsBuilder: (query) {
              return List.generate(
                8,
                (index) => VAutoSuggestItem(
                  value: 'item-$index',
                  label: 'Item $index',
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(EditableText));
      await tester.pump();
      tester.testTextInput.enterText('I');
      await tester.pumpAndSettle();

      final listView = find.byType(ListView).last;
      expect(tester.getSize(listView).height, lessThanOrEqualTo(72));
    });
  });
}
