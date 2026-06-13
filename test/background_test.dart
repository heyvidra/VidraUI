import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

void main() {
  group('VBackground', () {
    test('color stores color only and supports value equality', () {
      const color = Color(0xFF123456);
      const background = VBackground.color(color);

      expect(background.color, color);
      expect(background.gradient, isNull);
      expect(background, const VBackground.color(color));
      expect(background.hashCode, const VBackground.color(color).hashCode);
      expect(background.toString(), contains('VBackground'));
    });

    test('gradient stores gradient only and supports value equality', () {
      const gradient = LinearGradient(
        colors: [Color(0xFF111111), Color(0xFF222222)],
      );
      const background = VBackground.gradient(gradient);

      expect(background.color, isNull);
      expect(background.gradient, gradient);
      expect(background, const VBackground.gradient(gradient));
      expect(
          background.hashCode, const VBackground.gradient(gradient).hashCode);
      expect(background.toString(), contains('VBackground'));
    });
  });
}
