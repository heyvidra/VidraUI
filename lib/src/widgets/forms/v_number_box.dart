import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/v_theme.dart';
import '../basic/v_text.dart';
import '../buttons/v_button.dart';

/// A compact stepper control — minus / value / plus.
///
/// Supports long-press acceleration, haptic feedback on mobile, and
/// keyboard arrow-key stepping.
class VNumberBox extends StatefulWidget {
  const VNumberBox({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max,
    this.step = 1,
    this.size = VControlSize.md,
    this.enabled = true,
    this.semanticLabel,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int? max;
  final int step;
  final VControlSize size;
  final bool enabled;
  final String? semanticLabel;

  @override
  State<VNumberBox> createState() => _VNumberBoxState();
}

class _VNumberBoxState extends State<VNumberBox> {
  static const _initialInterval = Duration(milliseconds: 400);
  static const _acceleratedInterval = Duration(milliseconds: 80);
  static const _accelerationAfter = 4; // steps before ramping up

  final FocusNode _focus = FocusNode();
  Timer? _repeatTimer;
  int _repeatCount = 0;
  int _direction = 0; // -1 or +1

  bool get _canDecrement => widget.enabled && widget.value > widget.min;
  bool get _canIncrement {
    final m = widget.max;
    return widget.enabled && (m == null || widget.value < m);
  }

  @override
  void dispose() {
    _focus.dispose();
    _repeatTimer?.cancel();
    super.dispose();
  }

  // ── Change ────────────────────────────────────────────────────

  void _apply(int delta) {
    final next =
        (widget.value + delta).clamp(widget.min, widget.max ?? 0x7FFFFFFF);
    if (next != widget.value) widget.onChanged(next);
  }

  void _haptic() {
    if (VPlatformScope.of(context).hasHapticFeedback) {
      HapticFeedback.lightImpact();
    }
  }

  // ── Press handling ────────────────────────────────────────────

  void _onTapDown(int dir) {
    _direction = dir;
    _repeatCount = 0;
    _apply(dir * widget.step);
    _haptic();
    _repeatTimer?.cancel();
    _repeatTimer = Timer(_initialInterval, _repeatTick);
  }

  void _onTapUp(_) {
    _repeatTimer?.cancel();
  }

  void _repeatTick() {
    if (!mounted) return;
    _repeatCount++;
    _apply(_direction * widget.step);
    _haptic();
    final interval = _repeatCount >= _accelerationAfter
        ? _acceleratedInterval
        : _initialInterval;
    _repeatTimer = Timer(interval, _repeatTick);
  }

  // ── Keyboard ──────────────────────────────────────────────────

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _apply(widget.step);
      _haptic();
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _apply(-widget.step);
      _haptic();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  // ── Build ─────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    final buttonSize = switch (widget.size) {
      VControlSize.sm || VControlSize.md => VControlSize.sm,
      VControlSize.lg => VControlSize.md,
    };
    final numberWidth = switch (widget.size) {
      VControlSize.sm => 32.0,
      VControlSize.md => 40.0,
      VControlSize.lg => 48.0,
    };
    final fg = !widget.enabled ? theme.colors.textDisabled : theme.colors.text;

    return Semantics(
      label: widget.semanticLabel ?? 'Number input',
      value: '${widget.value}',
      child: Focus(
        focusNode: _focus,
        onKeyEvent: _onKey,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _StepButton(
              label: '−',
              enabled: _canDecrement,
              size: buttonSize,
              onTapDown: () => _onTapDown(-1),
              onTapUp: _onTapUp,
            ),
            SizedBox(
              width: numberWidth,
              height: buttonSize == VControlSize.md ? 48 : 36,
              child: Center(
                child: VText(
                  '${widget.value}',
                  variant: VTextVariant.label,
                  color: fg,
                ),
              ),
            ),
            _StepButton(
              label: '+',
              enabled: _canIncrement,
              size: buttonSize,
              onTapDown: () => _onTapDown(1),
              onTapUp: _onTapUp,
            ),
          ],
        ),
      ),
    );
  }
}

/// A square button that fires [onTapDown] immediately (no waiting for tap-up).
class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.label,
    required this.enabled,
    required this.size,
    required this.onTapDown,
    required this.onTapUp,
  });

  final String label;
  final bool enabled;
  final VControlSize size;
  final VoidCallback onTapDown;
  final ValueChanged<PointerUpEvent>? onTapUp;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: enabled ? (_) => onTapDown() : null,
      onPointerUp: enabled ? onTapUp : null,
      child: VButton(
        variant: VButtonVariant.secondary,
        size: size,
        onPressed: enabled ? () {} : null, // no-op; real handling via Listener
        child: VText(label, variant: VTextVariant.label),
      ),
    );
  }
}
