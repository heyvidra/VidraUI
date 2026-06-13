import 'package:flutter/widgets.dart';

import '../../foundation/state.dart';

Color lerpComponentTokenColor(Color a, Color b, double t) {
  return Color.lerp(a, b, t)!;
}

double lerpComponentTokenDouble(double a, double b, double t) {
  return a + (b - a) * t;
}

WidgetStateProperty<Color> lerpComponentTokenStateColor(
  WidgetStateProperty<Color> a,
  WidgetStateProperty<Color> b,
  double t,
) {
  return VStateProperty((states) {
    return lerpComponentTokenColor(a.resolve(states), b.resolve(states), t);
  });
}
