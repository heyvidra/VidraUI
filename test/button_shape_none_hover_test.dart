import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

/// Test to verify that VButton with shape.none applies hover colors correctly.
void main() {
  group('VButton shape.none hover colors', () {
    testWidgets('primary variant shows normal color initially', (tester) async {
      final theme = VThemeData.light();
      
      await tester.pumpWidget(
        VidraApp.navigator(
          theme: theme,
          home: VButton(
            shape: VButtonShape.none,
            variant: VButtonVariant.primary,
            onPressed: () {},
            child: const VText('Primary Text'),
          ),
        ),
      );

      await tester.pump();
      
      // Find the DefaultTextStyle that contains the button text with the expected color
      final textStyleWidgets = tester.widgetList<DefaultTextStyle>(find.byType(DefaultTextStyle)).toList();
      
      // Should find the DefaultTextStyle with the action primary color
      final buttonTextStyle = textStyleWidgets.firstWhere(
        (style) => style.style.color == theme.colors.actionPrimary,
      );
      
      expect(buttonTextStyle.style.color, equals(theme.colors.actionPrimary));
    });

    testWidgets('danger variant shows normal danger color initially', (tester) async {
      final theme = VThemeData.light();
      
      await tester.pumpWidget(
        VidraApp.navigator(
          theme: theme,
          home: VButton(
            shape: VButtonShape.none,
            variant: VButtonVariant.danger,
            onPressed: () {},
            child: const VText('Danger Text'),
          ),
        ),
      );

      await tester.pump();
      
      final textStyleWidgets = tester.widgetList<DefaultTextStyle>(find.byType(DefaultTextStyle)).toList();
      final buttonTextStyle = textStyleWidgets.firstWhere(
        (style) => style.style.color == theme.colors.danger,
      );
      
      expect(buttonTextStyle.style.color, equals(theme.colors.danger));
    });

    testWidgets('secondary variant shows text color', (tester) async {
      final theme = VThemeData.light();
      
      await tester.pumpWidget(
        VidraApp.navigator(
          theme: theme,
          home: VButton(
            shape: VButtonShape.none,
            variant: VButtonVariant.secondary,
            onPressed: () {},
            child: const VText('Secondary Text'),
          ),
        ),
      );

      await tester.pump();
      
      final textStyleWidgets = tester.widgetList<DefaultTextStyle>(find.byType(DefaultTextStyle)).toList();
      final buttonTextStyle = textStyleWidgets.firstWhere(
        (style) => style.style.color == theme.colors.text,
      );
      
      expect(buttonTextStyle.style.color, equals(theme.colors.text));
    });

    testWidgets('disabled button shows disabled color', (tester) async {
      final theme = VThemeData.light();
      
      await tester.pumpWidget(
        VidraApp.navigator(
          theme: theme,
          home: const VButton(
            shape: VButtonShape.none,
            variant: VButtonVariant.primary,
            onPressed: null, // disabled
            child: VText('Disabled Text'),
          ),
        ),
      );

      await tester.pump();
      
      final textStyleWidgets = tester.widgetList<DefaultTextStyle>(find.byType(DefaultTextStyle)).toList();
      final buttonTextStyle = textStyleWidgets.firstWhere(
        (style) => style.style.color == theme.colors.textDisabled,
      );
      
      expect(buttonTextStyle.style.color, equals(theme.colors.textDisabled));
    });
  });
}