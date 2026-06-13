import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

void main() {
  group('VStateProperty', () {
    test('all returns same value for any state', () {
      final prop = VStateProperty.all(const Color(0xFF0000FF));
      expect(prop.resolve({WidgetState.disabled}), const Color(0xFF0000FF));
      expect(prop.resolve({WidgetState.hovered}), const Color(0xFF0000FF));
      expect(prop.resolve({WidgetState.pressed}), const Color(0xFF0000FF));
      expect(prop.resolve(<WidgetState>{}), const Color(0xFF0000FF));
    });

    test('resolveWith — disabled has highest priority', () {
      final prop = VStateProperty<Color>.resolveWith(
        normal: const Color(0xFFAAAAAA),
        disabled: const Color(0xFF000000),
        pressed: const Color(0xFFFF0000),
        hovered: const Color(0xFF00FF00),
      );
      expect(
        prop.resolve({WidgetState.disabled, WidgetState.pressed}),
        const Color(0xFF000000),
      );
    });

    test('resolveWith — error beats pressed', () {
      final prop = VStateProperty<Color>.resolveWith(
        normal: const Color(0xFFAAAAAA),
        error: const Color(0xFFFF0000),
        pressed: const Color(0xFF0000FF),
      );
      expect(
        prop.resolve({WidgetState.error, WidgetState.pressed}),
        const Color(0xFFFF0000),
      );
    });

    test('resolveWith — pressed beats hovered', () {
      final prop = VStateProperty<Color>.resolveWith(
        normal: const Color(0xFFAAAAAA),
        pressed: const Color(0xFFFF0000),
        hovered: const Color(0xFF00FF00),
      );
      expect(
        prop.resolve({WidgetState.pressed, WidgetState.hovered}),
        const Color(0xFFFF0000),
      );
    });

    test('resolveWith — hovered beats focused', () {
      final prop = VStateProperty<Color>.resolveWith(
        normal: const Color(0xFFAAAAAA),
        hovered: const Color(0xFF00FF00),
        focused: const Color(0xFFFF0000),
      );
      expect(
        prop.resolve({WidgetState.hovered, WidgetState.focused}),
        const Color(0xFF00FF00),
      );
    });

    test('resolveWith — focused beats selected', () {
      final prop = VStateProperty<Color>.resolveWith(
        normal: const Color(0xFFAAAAAA),
        focused: const Color(0xFFFF0000),
        selected: const Color(0xFF00FF00),
      );
      expect(
        prop.resolve({WidgetState.focused, WidgetState.selected}),
        const Color(0xFFFF0000),
      );
    });

    test('resolveWith — selected beats normal', () {
      final prop = VStateProperty<Color>.resolveWith(
        normal: const Color(0xFFAAAAAA),
        selected: const Color(0xFF00FF00),
      );
      expect(prop.resolve({WidgetState.selected}), const Color(0xFF00FF00));
    });

    test('resolveWith — normal fallback', () {
      final prop = VStateProperty<Color>.resolveWith(
        normal: const Color(0xFFAAAAAA),
      );
      expect(prop.resolve(<WidgetState>{}), const Color(0xFFAAAAAA));
    });

    test('resolveWith — missing optional states fall back to normal', () {
      final prop = VStateProperty<Color>.resolveWith(
        normal: const Color(0xFFAAAAAA),
        disabled: const Color(0xFF000000),
      );
      // 'error' is not provided — should fall back to normal
      expect(prop.resolve({WidgetState.error}), const Color(0xFFAAAAAA));
    });

    test('states matches resolveWith behavior', () {
      final prop = VStateProperty<Color>.states(
        normal: const Color(0xFFAAAAAA),
        hovered: const Color(0xFF00FF00),
        pressed: const Color(0xFFFF0000),
      );

      expect(prop.resolve(<WidgetState>{}), const Color(0xFFAAAAAA));
      expect(prop.resolve({WidgetState.hovered}), const Color(0xFF00FF00));
      expect(
        prop.resolve({WidgetState.pressed, WidgetState.hovered}),
        const Color(0xFFFF0000),
      );
    });
  });
}
