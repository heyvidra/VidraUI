import 'package:flutter/widgets.dart';

import '../../foundation/radii.dart';
import '../../foundation/semantic_tokens.dart';
import '../../foundation/sizes.dart';
import '../../foundation/spacing.dart';
import 'v_accordion_tokens.dart';
import 'v_app_bar_tokens.dart';
import 'v_auto_suggest_tokens.dart';
import 'v_button_tokens.dart';
import 'v_checkbox_tokens.dart';
import 'v_chip_tokens.dart';
import 'v_date_picker_tokens.dart';
import 'v_dialog_tokens.dart';
import 'v_divider_tokens.dart';
import 'v_input_tokens.dart';
import 'v_menu_tokens.dart';
import 'v_navigation_bar_tokens.dart';
import 'v_radio_tokens.dart';
import 'v_scrollbar_tokens.dart';
import 'v_segmented_control_tokens.dart';
import 'v_select_tokens.dart';
import 'v_slider_tokens.dart';
import 'v_steps_tokens.dart';
import 'v_surface_tokens.dart';
import 'v_switch_tokens.dart';
import 'v_table_tokens.dart';
import 'v_teaching_tip_tokens.dart';
import 'v_time_picker_tokens.dart';
import 'v_timeline_tokens.dart';
import 'v_toast_tokens.dart';

part 'v_component_tokens.g.dart';

/// All component-level tokens, keyed by widget type.
@immutable
class VComponentTokens {
  factory VComponentTokens.fromColors(VColors colors) =>
      _$fromColors(colors);

  /// Create component tokens from complete theme data.
  /// 
  /// Uses foundation tokens (sizes, radii, spacing) for proper token flow
  /// instead of hardcoding values in individual component factories.
  factory VComponentTokens.fromTheme({
    required VColors colors,
    required VSizes sizes,
    required VRadii radii,
    required VSpacing spacing,
  }) {
    return VComponentTokens(
      appBar: VAppBarTokens.fromColors(colors),
      button: VButtonTokens.fromTheme(colors, sizes, radii),
      checkbox: VCheckboxTokens.fromColors(colors),
      chip: VChipTokens.fromColors(colors),
      menu: VMenuTokens.fromColors(colors),
      radio: VRadioTokens.fromColors(colors),
      select: VSelectTokens.fromColors(colors),
      switch_: VSwitchTokens.fromColors(colors),
      surface: VSurfaceTokens.fromColors(colors),
      dialog: VDialogTokens.fromColors(colors),
      input: VInputTokens.fromColors(colors),
      toast: const VToastTokens(),
      datePicker: const VDatePickerTokens(),
      timePicker: const VTimePickerTokens(),
      table: const VTableTokens(),
      scrollbar: const VScrollbarTokens(),
      segmentedControl: VSegmentedControlTokens.fromColors(colors),
      accordion: VAccordionTokens.fromTheme(
        colors: colors,
        spacing: spacing,
        radii: radii,
      ),
      autoSuggest: const VAutoSuggestTokens(),
      teachingTip: const VTeachingTipTokens(),
      navigationBar: VNavigationBarTokens.fromColors(colors),
      steps: VStepsTokens.fromColors(colors),
      timeline: VTimeLineTokens.fromColors(colors),
      divider: VDividerTokens.fromColors(colors),
      slider: VSliderTokens.fromColors(colors),
    );
  }

  const VComponentTokens({
    required this.appBar,
    required this.button,
    required this.checkbox,
    required this.chip,
    required this.menu,
    required this.radio,
    required this.select,
    required this.switch_,
    required this.surface,
    required this.dialog,
    required this.input,
    this.toast = const VToastTokens(),
    this.datePicker = const VDatePickerTokens(),
    this.timePicker = const VTimePickerTokens(),
    this.table = const VTableTokens(),
    this.scrollbar = const VScrollbarTokens(),
    required this.segmentedControl,
    required this.accordion,
    this.autoSuggest = const VAutoSuggestTokens(),
    this.teachingTip = const VTeachingTipTokens(),
    required this.navigationBar,
    required this.steps,
    required this.timeline,
    required this.divider,
    required this.slider,
  });

  final VAppBarTokens appBar;
  final VButtonTokens button;
  final VCheckboxTokens checkbox;
  final VChipTokens chip;
  final VMenuTokens menu;
  final VRadioTokens radio;
  final VSelectTokens select;
  final VSwitchTokens switch_;
  final VSurfaceTokens surface;
  final VDialogTokens dialog;
  final VInputTokens input;
  final VToastTokens toast;
  final VDatePickerTokens datePicker;
  final VTimePickerTokens timePicker;
  final VTableTokens table;
  final VScrollbarTokens scrollbar;
  final VSegmentedControlTokens segmentedControl;
  final VAccordionTokens accordion;
  final VAutoSuggestTokens autoSuggest;
  final VTeachingTipTokens teachingTip;
  final VNavigationBarTokens navigationBar;
  final VStepsTokens steps;
  final VTimeLineTokens timeline;
  final VDividerTokens divider;
  final VSliderTokens slider;

  static VComponentTokens lerp(
    VComponentTokens a,
    VComponentTokens b,
    double t,
  ) =>
      _$lerp(a, b, t);

  VComponentTokens copyWith({
    VAppBarTokens? appBar,
    VButtonTokens? button,
    VCheckboxTokens? checkbox,
    VChipTokens? chip,
    VMenuTokens? menu,
    VRadioTokens? radio,
    VSelectTokens? select,
    VSwitchTokens? switch_,
    VSurfaceTokens? surface,
    VDialogTokens? dialog,
    VInputTokens? input,
    VToastTokens? toast,
    VDatePickerTokens? datePicker,
    VTimePickerTokens? timePicker,
    VTableTokens? table,
    VScrollbarTokens? scrollbar,
    VSegmentedControlTokens? segmentedControl,
    VAccordionTokens? accordion,
    VAutoSuggestTokens? autoSuggest,
    VTeachingTipTokens? teachingTip,
    VNavigationBarTokens? navigationBar,
    VStepsTokens? steps,
    VTimeLineTokens? timeline,
    VDividerTokens? divider,
    VSliderTokens? slider,
  }) =>
      _$copyWith(this,
          appBar: appBar,
          button: button,
          checkbox: checkbox,
          chip: chip,
          menu: menu,
          radio: radio,
          select: select,
          switch_: switch_,
          surface: surface,
          dialog: dialog,
          input: input,
          toast: toast,
          datePicker: datePicker,
          timePicker: timePicker,
          table: table,
          scrollbar: scrollbar,
          segmentedControl: segmentedControl,
          accordion: accordion,
          autoSuggest: autoSuggest,
          teachingTip: teachingTip,
          navigationBar: navigationBar,
          steps: steps,
          timeline: timeline,
          divider: divider,
          slider: slider,
      );
}
