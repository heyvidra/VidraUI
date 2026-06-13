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

void main() {
  group('VText', () {
    testWidgets('merges one-off style overrides with variant style',
        (tester) async {
      await tester.pumpWidget(_wrap(
        const VText(
          'Styled',
          variant: VTextVariant.label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ));

      final text = tester.widget<Text>(find.text('Styled'));
      expect(text.style!.fontSize, 18);
      expect(text.style!.fontWeight, FontWeight.w700);
      expect(text.style!.letterSpacing, 0.4);
      expect(text.style!.height, VThemeData.light().typography.label.height);
      expect(text.style!.color, VThemeData.light().colors.text);
    });

    testWidgets('color parameter takes precedence over style color',
        (tester) async {
      const overrideColor = Color(0xFF123456);

      await tester.pumpWidget(_wrap(
        const VText(
          'Colored',
          color: overrideColor,
          style: TextStyle(color: Color(0xFFABCDEF)),
        ),
      ));

      final text = tester.widget<Text>(find.text('Colored'));
      expect(text.style!.color, overrideColor);
    });
  });
}
