import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

void main() {
  group('VToast Stack Mode', () {
    testWidgets('replace mode removes existing toasts', (tester) async {
      var counter = 0;
      
      await tester.pumpWidget(
        VidraApp.navigator(
          home: Builder(
            builder: (context) {
              return VScaffold(
                body: VButton(
                  onPressed: () {
                    counter++;
                    VToast.show(
                      context,
                      message: 'Toast $counter',
                      stackMode: VToastStackMode.replace,
                    );
                  },
                  child: const VText('Show Toast'),
                ),
              );
            },
          ),
        ),
      );

      final button = find.byType(VButton);
      
      // Show first toast
      await tester.tap(button);
      await tester.pump();
      expect(find.text('Toast 1'), findsOneWidget);

      // Show second toast with replace mode
      await tester.tap(button);
      await tester.pump();
      
      // First toast should be replaced by second
      expect(find.text('Toast 1'), findsNothing);
      expect(find.text('Toast 2'), findsOneWidget);
    });

    testWidgets('stack mode allows multiple toasts', (tester) async {
      var counter = 0;
      
      await tester.pumpWidget(
        VidraApp.navigator(
          home: Builder(
            builder: (context) {
              return VScaffold(
                body: VButton(
                  onPressed: () {
                    counter++;
                    VToast.show(
                      context,
                      message: 'Toast $counter',
                      stackMode: VToastStackMode.stack,
                    );
                  },
                  child: const VText('Show Toast'),
                ),
              );
            },
          ),
        ),
      );

      final button = find.byType(VButton);
      
      // Show first toast
      await tester.tap(button);
      await tester.pump();
      expect(find.text('Toast 1'), findsOneWidget);
      
      // Show second toast
      await tester.tap(button);
      await tester.pump();

      // Both toasts should be visible
      expect(find.text('Toast 1'), findsOneWidget);
      expect(find.text('Toast 2'), findsOneWidget);
    });
  });
}