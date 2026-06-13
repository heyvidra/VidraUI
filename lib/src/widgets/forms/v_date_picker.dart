import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/component_tokens.dart';
import '../../theme/v_component_themes.g.dart';
import '../../theme/v_theme.dart';
import '../basic/v_text.dart';
import '../buttons/v_button.dart';

part 'v_date_picker_state.dart';

/// A simple calendar date picker.
///
/// Shows a month grid. Tap a day to select it. Arrows navigate months.
class VDatePicker extends StatefulWidget {
  const VDatePicker({
    super.key,
    required this.selected,
    this.onChanged,
    this.firstDate,
    this.lastDate,
  });

  final DateTime? selected;
  final ValueChanged<DateTime>? onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  State<VDatePicker> createState() => _VDatePickerState();
}
