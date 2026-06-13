import 'dart:ui';

import 'package:flutter/foundation.dart';

/// Raw color constants with no product or component meaning.
///
/// These values are referenced by [VColors] (semantic tokens) but should
/// never be used directly from widget code.
///
/// Hallmark Discipline: All colors are defined with OKLCH equivalents.
/// Pure black and pure white are prohibited; all extremes are tinted toward
/// the Signal Blue anchor (Hue: 261).
@immutable
class VPrimitiveColors {
  const VPrimitiveColors._();

  // Blue (Anchor Hue: 261)
  static const Color blue50  = Color(0xFFEFF6FF); // oklch(96.5% 0.021 261.2)
  static const Color blue400 = Color(0xFF60A5FA); // oklch(72.7% 0.147 261.2)
  static const Color blue500 = Color(0xFF3B82F6); // oklch(62.3% 0.186 261.2)
  static const Color blue600 = Color(0xFF2563EB); // oklch(55.2% 0.195 261.2)
  static const Color blue700 = Color(0xFF1D4ED8); // oklch(47.3% 0.195 261.2)
  static const Color blue800 = Color(0xFF1E40AF); // oklch(37.5% 0.158 261.2)

  // Gray (Tinted Neutrals · Hue: 261 · Chroma: 0.006)
  static const Color gray50  = Color(0xFFF9FAFB); // oklch(98.1% 0.006 261)
  static const Color gray100 = Color(0xFFF3F4F6); // oklch(96.2% 0.006 261)
  static const Color gray200 = Color(0xFFE5E7EB); // oklch(91.7% 0.006 261)
  static const Color gray300 = Color(0xFFD1D5DB); // oklch(85.4% 0.006 261)
  static const Color gray400 = Color(0xFF9CA3AF); // oklch(68.5% 0.006 261)
  static const Color gray500 = Color(0xFF6B7280); // oklch(52.7% 0.006 261)
  static const Color gray600 = Color(0xFF4B5563); // oklch(42.5% 0.006 261)
  static const Color gray700 = Color(0xFF374151); // oklch(34.8% 0.006 261)
  static const Color gray800 = Color(0xFF1F2937); // oklch(25.4% 0.006 261)
  static const Color gray900 = Color(0xFF111827); // oklch(18.5% 0.006 261)
  static const Color gray950 = Color(0xFF030712); // oklch(11.2% 0.006 261)

  // Red (Semantic Danger · Hue: 25)
  static const Color red50  = Color(0xFFFEF2F2); // oklch(96.5% 0.015 25)
  static const Color red200 = Color(0xFFFECACA); // oklch(83.2% 0.085 25)
  static const Color red300 = Color(0xFFF87171); // oklch(65.4% 0.170 25)
  static const Color red500 = Color(0xFFEF4444); // oklch(57.1% 0.220 25)
  static const Color red600 = Color(0xFFDC2626); // oklch(49.8% 0.210 25)
  static const Color red950 = Color(0xFF450A0A); // oklch(16.5% 0.080 25)

  // Green (Semantic Success · Hue: 145)
  static const Color green50  = Color(0xFFF0FDF4); // oklch(97.2% 0.015 145)
  static const Color green400 = Color(0xFF4ADE80); // oklch(79.5% 0.170 145)
  static const Color green500 = Color(0xFF22C55E); // oklch(69.8% 0.200 145)
  static const Color green600 = Color(0xFF16A34A); // oklch(60.2% 0.180 145)
  static const Color green700 = Color(0xFF15803D); // oklch(49.1% 0.150 145)
  static const Color green950 = Color(0xFF052E16); // oklch(18.5% 0.070 145)

  // Amber (Semantic Warning · Hue: 75)
  static const Color amber50  = Color(0xFFFFFBEB); // oklch(98.2% 0.015 75)
  static const Color amber300 = Color(0xFFFCD34D); // oklch(84.1% 0.150 75)
  static const Color amber400 = Color(0xFFFBBF24); // oklch(78.5% 0.180 75)
  static const Color amber600 = Color(0xFFD97706); // oklch(60.2% 0.160 75)
  static const Color amber700 = Color(0xFFB45309); // oklch(49.1% 0.140 75)
  static const Color amber950 = Color(0xFF451A03); // oklch(20.5% 0.070 75)

  // Tinted Extremes (Never Pure #000 or #FFF)
  static const Color white = Color(0xFFFEFBFF); // oklch(100% 0.005 261)
  static const Color black = Color(0xFF0A0B0D); // oklch(8% 0.01 261)
  static const Color transparent = Color(0x00000000);
}
