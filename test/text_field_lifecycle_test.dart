import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

void main() {
  group('VTextField controller/focusNode lifecycle', () {
    testWidgets('switches from internal to external controller preserving text',
        (tester) async {
      final externalController = TextEditingController();
      addTearDown(externalController.dispose);

      // Build with internal controller
      await tester.pumpWidget(
        VidraApp.navigator(
          home: const VTextField(
            key: Key('field'),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byKey(const Key('field')), 'Hello');
      await tester.pump();

      // Switch to external controller
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VTextField(
            key: const Key('field'),
            controller: externalController,
          ),
        ),
      );
      await tester.pump();

      // External controller should receive empty text (its initial state)
      expect(externalController.text, '');
      expect(find.text('Hello'), findsNothing);
    });

    testWidgets('switches from external to internal controller preserving text',
        (tester) async {
      final externalController = TextEditingController(text: 'Initial');
      addTearDown(externalController.dispose);

      // Build with external controller
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VTextField(
            key: const Key('field'),
            controller: externalController,
          ),
        ),
      );

      expect(find.text('Initial'), findsOneWidget);

      // Update external controller text
      externalController.text = 'Updated';
      await tester.pump();

      expect(find.text('Updated'), findsOneWidget);

      // Switch to internal controller - should preserve current text
      await tester.pumpWidget(
        VidraApp.navigator(
          home: const VTextField(
            key: Key('field'),
          ),
        ),
      );
      await tester.pump();

      // Text should be preserved from the moment of switch
      expect(find.text('Updated'), findsOneWidget);

      // Original external controller should still have its text
      expect(externalController.text, 'Updated');
    });

    testWidgets('switches between two external controllers',
        (tester) async {
      final controller1 = TextEditingController(text: 'Controller 1');
      final controller2 = TextEditingController(text: 'Controller 2');
      addTearDown(() {
        controller1.dispose();
        controller2.dispose();
      });

      // Build with controller1
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VTextField(
            key: const Key('field'),
            controller: controller1,
          ),
        ),
      );

      expect(find.text('Controller 1'), findsOneWidget);

      // Switch to controller2
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VTextField(
            key: const Key('field'),
            controller: controller2,
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Controller 2'), findsOneWidget);
      expect(find.text('Controller 1'), findsNothing);
    });

    testWidgets('switches from internal to external focusNode',
        (tester) async {
      final externalFocusNode = FocusNode();
      addTearDown(externalFocusNode.dispose);

      // Build with internal focusNode
      await tester.pumpWidget(
        VidraApp.navigator(
          home: const VTextField(
            key: Key('field'),
            autofocus: true,
          ),
        ),
      );
      await tester.pump();

      // Field should have focus
      expect(find.byKey(const Key('field')), findsOneWidget);

      // Switch to external focusNode (which starts unfocused)
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VTextField(
            key: const Key('field'),
            focusNode: externalFocusNode,
          ),
        ),
      );
      await tester.pump();

      // Focus should be on the external node now
      expect(externalFocusNode.hasFocus, isFalse);

      // Request focus on external node
      externalFocusNode.requestFocus();
      await tester.pump();

      expect(externalFocusNode.hasFocus, isTrue);
    });

    testWidgets('switches from external to internal focusNode',
        (tester) async {
      final externalFocusNode = FocusNode();
      addTearDown(externalFocusNode.dispose);

      // Build with external focusNode
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VTextField(
            key: const Key('field'),
            focusNode: externalFocusNode,
          ),
        ),
      );
      await tester.pump();

      externalFocusNode.requestFocus();
      await tester.pump();

      expect(externalFocusNode.hasFocus, isTrue);

      // Switch to internal focusNode
      await tester.pumpWidget(
        VidraApp.navigator(
          home: const VTextField(
            key: Key('field'),
          ),
        ),
      );
      await tester.pump();

      // External node should no longer have focus
      expect(externalFocusNode.hasFocus, isFalse);
    });

    testWidgets('disposes internal resources correctly', (tester) async {
      // Build with internal controller/focusNode
      await tester.pumpWidget(
        VidraApp.navigator(
          home: const VTextField(
            key: Key('field'),
          ),
        ),
      );

      // Enter text to ensure controller is active
      await tester.enterText(find.byKey(const Key('field')), 'Test');
      await tester.pump();

      // Remove the widget
      await tester.pumpWidget(
        VidraApp.navigator(
          home: const SizedBox(),
        ),
      );

      // Should not throw - internal resources should be disposed
      expect(tester.takeException(), isNull);
    });

    testWidgets('does not dispose external resources', (tester) async {
      final externalController = TextEditingController(text: 'External');
      final externalFocusNode = FocusNode();
      addTearDown(() {
        externalController.dispose();
        externalFocusNode.dispose();
      });

      // Build with external controller/focusNode
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VTextField(
            key: const Key('field'),
            controller: externalController,
            focusNode: externalFocusNode,
          ),
        ),
      );

      expect(find.text('External'), findsOneWidget);

      // Remove the widget
      await tester.pumpWidget(
        VidraApp.navigator(
          home: const SizedBox(),
        ),
      );

      // External resources should still be valid
      expect(externalController.text, 'External');
      expect(() => externalFocusNode.hasFocus, returnsNormally);
    });
  });
}
