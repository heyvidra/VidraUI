part of '../../main.dart';

class _TextFieldDemo extends StatelessWidget {
  const _TextFieldDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Text Field', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    const VTextField(label: 'Name', hint: 'Enter your name'),
                    const VTextField(
                      label: 'Email',
                      hint: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      errorText: 'Invalid email address',
                    ),
                    const VTextField(
                      label: 'Password',
                      hint: 'Enter password',
                      obscureText: true,
                    ),
                    VTextField(
                      label: 'Search',
                      hint: 'Type to search...',
                      leading: VIcon(LucideIcons.search, size: 18),
                    ),
                    VTextField(
                      label: 'Website',
                      hint: 'https://',
                      leading: VIcon(LucideIcons.globe, size: 18),
                      trailing: VIcon(LucideIcons.externalLink, size: 18),
                    ),
                    const VTextField(
                        label: 'Disabled', hint: 'Cannot edit', enabled: false),
                    const _DatePickerTextFieldDemo(),
                    const _DateTimePickerTextFieldDemo(),
                  ]),
            ),
          ),
        ]);
  }
}

class _DatePickerTextFieldDemo extends StatefulWidget {
  const _DatePickerTextFieldDemo();

  @override
  State<_DatePickerTextFieldDemo> createState() =>
      _DatePickerTextFieldDemoState();
}

class _DatePickerTextFieldDemoState extends State<_DatePickerTextFieldDemo> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final VPopoverController _popoverController = VPopoverController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    _controller.dispose();
    _popoverController.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _popoverController.open();
    }
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _controller.text =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    });
    _popoverController.close();
  }

  @override
  Widget build(BuildContext context) {
    return VPopover(
      controller: _popoverController,
      matchTriggerWidth: false,
      placement: VAnchoredOverlayPlacement.auto,
      desiredHeight: 340,
      desiredWidth: 260,
      triggerBuilder: (context, controller, isOpen) {
        return VTextField(
          controller: _controller,
          focusNode: _focusNode,
          label: 'Birth Date (DatePicker Popover)',
          hint: 'Click input or calendar icon...',
          trailing: GestureDetector(
            onTap: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                _focusNode.requestFocus();
                controller.open();
              }
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: VIcon(LucideIcons.calendar, size: 18),
            ),
          ),
        );
      },
      contentBuilder: (context, controller) {
        final theme = VTheme.of(context);
        return DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colors.surface,
            borderRadius: BorderRadius.circular(theme.radii.md),
            border: Border.all(color: theme.colors.border),
            boxShadow: [theme.shadows.dropdown],
          ),
          child: Padding(
            padding: EdgeInsets.all(theme.spacing.md),
            child: SizedBox(
              width: 240,
              child: VDatePicker(
                selected: _selectedDate,
                onChanged: _selectDate,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DateTimePickerTextFieldDemo extends StatefulWidget {
  const _DateTimePickerTextFieldDemo();

  @override
  State<_DateTimePickerTextFieldDemo> createState() =>
      _DateTimePickerTextFieldDemoState();
}

class _DateTimePickerTextFieldDemoState
    extends State<_DateTimePickerTextFieldDemo> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final VPopoverController _popoverController = VPopoverController();
  DateTime? _selectedDate;
  VTimeOfDay _selectedTime = const VTimeOfDay(hour: 12, minute: 0);
  int _activeTab = 0; // 0 for Date, 1 for Time

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    _controller.dispose();
    _popoverController.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _popoverController.open();
    }
  }

  void _updateText() {
    if (_selectedDate == null) return;
    final dateStr =
        "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}";
    final timeStr = _selectedTime.toString();
    _controller.text = "$dateStr $timeStr";
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _updateText();
      _activeTab = 1; // Auto switch to time picker
    });
  }

  void _selectTime(VTimeOfDay time) {
    setState(() {
      _selectedTime = time;
      _updateText();
    });
  }

  void _confirmSelection() {
    _popoverController.close();
  }

  @override
  Widget build(BuildContext context) {
    return VPopover(
      controller: _popoverController,
      matchTriggerWidth: false,
      placement: VAnchoredOverlayPlacement.auto,
      desiredHeight: 430,
      desiredWidth: 260,
      triggerBuilder: (context, controller, isOpen) {
        return VTextField(
          controller: _controller,
          focusNode: _focusNode,
          label: 'Appointment Date & Time (Popover)',
          hint: 'Select appointment date & time...',
          trailing: GestureDetector(
            onTap: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                _focusNode.requestFocus();
                controller.open();
              }
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: VIcon(LucideIcons.calendarClock, size: 18),
            ),
          ),
        );
      },
      contentBuilder: (context, controller) {
        final theme = VTheme.of(context);
        return DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colors.surface,
            borderRadius: BorderRadius.circular(theme.radii.md),
            border: Border.all(color: theme.colors.border),
            boxShadow: [theme.shadows.dropdown],
          ),
          child: Padding(
            padding: EdgeInsets.all(theme.spacing.md),
            child: SizedBox(
              width: 240,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _activeTab = 0),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: _activeTab == 0
                                      ? theme.colors.actionPrimary
                                      : const Color(0x00000000),
                                  width: 2,
                                ),
                              ),
                            ),
                            child: VText(
                              'Date',
                              variant: VTextVariant.caption,
                              color: _activeTab == 0
                                  ? theme.colors.actionPrimary
                                  : theme.colors.textMuted,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _activeTab = 1),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: _activeTab == 1
                                      ? theme.colors.actionPrimary
                                      : const Color(0x00000000),
                                  width: 2,
                                ),
                              ),
                            ),
                            child: VText(
                              'Time',
                              variant: VTextVariant.caption,
                              color: _activeTab == 1
                                  ? theme.colors.actionPrimary
                                  : theme.colors.textMuted,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: theme.spacing.md),
                  SizedBox(
                    height: 280,
                    child: _activeTab == 0
                        ? VDatePicker(
                            selected: _selectedDate,
                            onChanged: _selectDate,
                          )
                        : VTimePicker(
                            selected: _selectedTime,
                            onChanged: _selectTime,
                          ),
                  ),
                  if (_activeTab == 1) ...[
                    SizedBox(height: theme.spacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        VButton(
                          onPressed: _confirmSelection,
                          child: const VText('Confirm',
                              variant: VTextVariant.label),
                        ),
                      ],
                    )
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


// docs-snippet:start text-field-basic
// const VTextField(
//   label: 'Email',
//   hint: 'you@example.com',
//   keyboardType: TextInputType.emailAddress,
//   errorText: 'Invalid email address',
// )
// docs-snippet:end text-field-basic

// docs-snippet:start text-field-owned-state
// final controller = TextEditingController();
// final focusNode = FocusNode();
//
// VTextField(
//   controller: controller,
//   focusNode: focusNode,
//   label: 'Search',
//   hint: 'Type to filter results',
//   leading: VIcon(LucideIcons.search, size: 18),
//   onSubmitted: runSearch,
// )
// docs-snippet:end text-field-owned-state

