import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../theme/v_component_themes.g.dart';
import '../../theme/v_theme.dart';
import '../basic/v_text.dart';

/// A simple time picker with hour and minute columns.
///
/// Each column scrolls to select the value. Tap to confirm.
class VTimePicker extends StatefulWidget {
  const VTimePicker({
    super.key,
    required this.selected,
    this.onChanged,
  });

  final VTimeOfDay? selected;
  final ValueChanged<VTimeOfDay>? onChanged;

  @override
  State<VTimePicker> createState() => _VTimePickerState();
}

class _VTimePickerState extends State<VTimePicker> {
  late final FixedExtentScrollController _hourCtrl;
  late final FixedExtentScrollController _minuteCtrl;

  @override
  void initState() {
    super.initState();
    _hourCtrl = FixedExtentScrollController(
      initialItem: widget.selected?.hour ?? 12,
    );
    _minuteCtrl = FixedExtentScrollController(
      initialItem: (widget.selected?.minute ?? 0) ~/ 5,
    );
  }

  @override
  void dispose() {
    _hourCtrl.dispose();
    _minuteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VTimePickerTheme.of(context) ?? theme.components.timePicker;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Hour picker
        SizedBox(
          width: tokens.columnWidth,
          height: tokens.wheelHeight,
          child: ListWheelScrollView.useDelegate(
            controller: _hourCtrl,
            itemExtent: tokens.itemHeight,
            diameterRatio: tokens.diameterRatio,
            onSelectedItemChanged: (v) {
              widget.onChanged?.call(
                VTimeOfDay(hour: v, minute: widget.selected?.minute ?? 0),
              );
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, i) {
                final isSelected = i == (widget.selected?.hour ?? 12);
                return _VTimePickerItem(
                  label: 'Hour $i',
                  value: '$i',
                  selected: isSelected,
                  selectedColor: tokens.selectedForeground,
                  foreground: tokens.itemForeground,
                  onSelected: () {
                    widget.onChanged?.call(
                      VTimeOfDay(
                        hour: i,
                        minute: widget.selected?.minute ?? 0,
                      ),
                    );
                  },
                );
              },
              childCount: 24,
            ),
          ),
        ),
        VText(':', variant: VTextVariant.title, color: theme.colors.text),
        // Minute picker (5-min intervals)
        SizedBox(
          width: tokens.columnWidth,
          height: tokens.wheelHeight,
          child: ListWheelScrollView.useDelegate(
            controller: _minuteCtrl,
            itemExtent: tokens.itemHeight,
            diameterRatio: tokens.diameterRatio,
            onSelectedItemChanged: (v) {
              widget.onChanged?.call(
                VTimeOfDay(
                  hour: widget.selected?.hour ?? 12,
                  minute: v * 5,
                ),
              );
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, i) {
                final m = (i * 5).toString().padLeft(2, '0');
                final isSelected = i * 5 == (widget.selected?.minute ?? 0);
                return _VTimePickerItem(
                  label: 'Minute $m',
                  value: m,
                  selected: isSelected,
                  selectedColor: tokens.selectedForeground,
                  foreground: tokens.itemForeground,
                  onSelected: () {
                    widget.onChanged?.call(
                      VTimeOfDay(
                        hour: widget.selected?.hour ?? 12,
                        minute: i * 5,
                      ),
                    );
                  },
                );
              },
              childCount: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _VTimePickerItem extends StatefulWidget {
  const _VTimePickerItem({
    required this.label,
    required this.value,
    required this.selected,
    required this.selectedColor,
    required this.foreground,
    required this.onSelected,
  });

  final String label;
  final String value;
  final bool selected;
  final Color selectedColor;
  final Color foreground;
  final VoidCallback onSelected;

  @override
  State<_VTimePickerItem> createState() => _VTimePickerItemState();
}

class _VTimePickerItemState extends State<_VTimePickerItem> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      focusNode: _focusNode,
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
      },
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<Intent>(
          onInvoke: (intent) {
            widget.onSelected();
            return null;
          },
        ),
      },
      child: Semantics(
        button: true,
        selected: widget.selected,
        label: widget.selected ? '${widget.label}, selected' : widget.label,
        onTap: widget.onSelected,
        child: GestureDetector(
          onTap: () {
            _focusNode.requestFocus();
            widget.onSelected();
          },
          child: Center(
            child: ExcludeSemantics(
              child: VText(
                widget.value,
                variant: VTextVariant.title,
                color:
                    widget.selected ? widget.selectedColor : widget.foreground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A simple time-of-day value.
class VTimeOfDay {
  const VTimeOfDay({required this.hour, required this.minute})
      : assert(hour >= 0 && hour < 24),
        assert(minute >= 0 && minute < 60);

  final int hour;
  final int minute;

  @override
  String toString() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

