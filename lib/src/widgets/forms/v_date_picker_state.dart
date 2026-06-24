part of 'v_date_picker.dart';

class _VDatePickerState extends State<VDatePicker> {
  late DateTime _viewMonth;
  late DateTime _focusedDate;
  final Map<String, FocusNode> _dayFocusNodes = <String, FocusNode>{};

  @override
  void initState() {
    super.initState();
    _viewMonth = DateTime(
      (widget.selected ?? DateTime.now()).year,
      (widget.selected ?? DateTime.now()).month,
    );
    _focusedDate = _nearestEnabledDate(widget.selected ?? DateTime.now());
  }

  DateTime get _first => widget.firstDate ?? DateTime(2000);
  DateTime get _last => widget.lastDate ?? DateTime(2100, 12, 31);

  @override
  void dispose() {
    _clearDayFocusNodes();
    super.dispose();
  }

  void _clearDayFocusNodes() {
    for (final node in _dayFocusNodes.values) {
      node.dispose();
    }
    _dayFocusNodes.clear();
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isDisabled(DateTime date) =>
      date.isBefore(_first) || date.isAfter(_last);

  DateTime _nearestEnabledDate(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    if (normalized.isBefore(_first)) {
      return DateTime(_first.year, _first.month, _first.day);
    }
    if (normalized.isAfter(_last)) {
      return DateTime(_last.year, _last.month, _last.day);
    }
    return normalized;
  }

  String _dayKey(DateTime date) => '${date.year}-${date.month}-${date.day}';

  FocusNode _focusNodeFor(DateTime date) {
    return _dayFocusNodes.putIfAbsent(_dayKey(date), FocusNode.new);
  }

  void _prevMonth() {
    final nextMonth = DateTime(_viewMonth.year, _viewMonth.month - 1);
    if (nextMonth.isBefore(_first)) return;
    _clearDayFocusNodes();
    setState(() {
      _viewMonth = nextMonth;
    });
  }

  void _nextMonth() {
    final nextMonth = DateTime(_viewMonth.year, _viewMonth.month + 1);
    if (nextMonth.isAfter(_last)) return;
    _clearDayFocusNodes();
    setState(() {
      _viewMonth = nextMonth;
    });
  }

  void _moveFocus(int days) {
    final next = DateTime(
      _focusedDate.year,
      _focusedDate.month,
      _focusedDate.day + days,
    );
    if (_isDisabled(next)) return;
    _focusDate(next);
  }

  void _focusDate(DateTime date) {
    final targetMonth = DateTime(date.year, date.month);
    if (targetMonth.year != _viewMonth.year ||
        targetMonth.month != _viewMonth.month) {
      _clearDayFocusNodes();
    }
    setState(() {
      _focusedDate = DateTime(date.year, date.month, date.day);
      _viewMonth = targetMonth;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _focusNodeFor(date).requestFocus();
    });
  }

  void _selectFocusedDate() {
    if (_isDisabled(_focusedDate)) return;
    widget.onChanged?.call(_focusedDate);
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VDatePickerTheme.of(context) ?? theme.components.datePicker;
    final today = DateTime.now();
    final daysInMonth = DateTime(_viewMonth.year, _viewMonth.month + 1, 0).day;
    final firstWeekday =
        DateTime(_viewMonth.year, _viewMonth.month, 1).weekday % 7;

    const headers = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Semantics(
      container: true,
      label: 'Date picker, ${_monthName(_viewMonth.month)} ${_viewMonth.year}',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              VButton(
                shape: VButtonShape.none,
                variant: VButtonVariant.secondary,
                size: VControlSize.sm,
                semanticLabel: 'Previous month',
                onPressed: _prevMonth,
                child: ExcludeSemantics(
                  child: Text(
                    '◂',
                    style: TextStyle(
                      color: tokens.navigationForeground,
                      fontSize: tokens.navigationIconSize,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: VText(
                    '${_monthName(_viewMonth.month)} ${_viewMonth.year}',
                    variant: VTextVariant.label,
                  ),
                ),
              ),
              VButton(
                shape: VButtonShape.none,
                variant: VButtonVariant.secondary,
                size: VControlSize.sm,
                semanticLabel: 'Next month',
                onPressed: _nextMonth,
                child: ExcludeSemantics(
                  child: Text(
                    '▸',
                    style: TextStyle(
                      color: tokens.navigationForeground,
                      fontSize: tokens.navigationIconSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: tokens.headerSpacing),
          Row(
            children: headers
                .map(
                  (h) => Expanded(
                    child: Center(
                      child: VText(
                        h,
                        variant: VTextVariant.caption,
                        color: tokens.weekdayForeground,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: tokens.weekdaySpacing),
          for (int week = 0; week < 6; week++)
            Row(
              children: List.generate(7, (dayOfWeek) {
                final dayNum = week * 7 + dayOfWeek - firstWeekday + 1;
                if (dayNum < 1 || dayNum > daysInMonth) {
                  return const Expanded(child: SizedBox.shrink());
                }
                final date =
                    DateTime(_viewMonth.year, _viewMonth.month, dayNum);
                final isSelected = widget.selected != null &&
                    date.year == widget.selected!.year &&
                    date.month == widget.selected!.month &&
                    date.day == widget.selected!.day;
                final isToday = date.year == today.year &&
                    date.month == today.month &&
                    date.day == today.day;
                final isDisabled = date.isBefore(_first) || date.isAfter(_last);
                final isFocused = _isSameDay(date, _focusedDate);

                return Expanded(
                  child: FocusableActionDetector(
                    focusNode: _focusNodeFor(date),
                    enabled: !isDisabled,
                    onFocusChange: (focused) {
                      if (focused) {
                        setState(() => _focusedDate = date);
                      }
                    },
                    shortcuts: const <ShortcutActivator, Intent>{
                      SingleActivator(LogicalKeyboardKey.arrowLeft):
                          _DirectionalFocusIntent(-1),
                      SingleActivator(LogicalKeyboardKey.arrowRight):
                          _DirectionalFocusIntent(1),
                      SingleActivator(LogicalKeyboardKey.arrowUp):
                          _DirectionalFocusIntent(-7),
                      SingleActivator(LogicalKeyboardKey.arrowDown):
                          _DirectionalFocusIntent(7),
                      SingleActivator(LogicalKeyboardKey.enter):
                          ActivateIntent(),
                      SingleActivator(LogicalKeyboardKey.space):
                          ActivateIntent(),
                    },
                    actions: <Type, Action<Intent>>{
                      _DirectionalFocusIntent:
                          CallbackAction<_DirectionalFocusIntent>(
                        onInvoke: (intent) {
                          _moveFocus(intent.dayDelta);
                          return null;
                        },
                      ),
                      ActivateIntent: CallbackAction<Intent>(
                        onInvoke: (intent) {
                          _selectFocusedDate();
                          return null;
                        },
                      ),
                    },
                    child: Semantics(
                      button: true,
                      enabled: !isDisabled,
                      selected: isSelected,
                      label: _dateSemanticsLabel(
                        date,
                        isSelected: isSelected,
                        isToday: isToday,
                        isDisabled: isDisabled,
                      ),
                      onTap: isDisabled
                          ? null
                          : () => widget.onChanged?.call(date),
                      child: GestureDetector(
                        onTap: isDisabled
                            ? null
                            : () {
                                _focusDate(date);
                                widget.onChanged?.call(date);
                              },
                        child: Container(
                          height: tokens.dayCellHeight,
                          decoration: BoxDecoration(
                            color: _dateBackground(
                              tokens,
                              isSelected: isSelected,
                              isFocused: isFocused,
                            ),
                            borderRadius:
                                BorderRadius.circular(tokens.dayCellRadius),
                            border: _dateBorder(
                              tokens,
                              isToday: isToday,
                              isSelected: isSelected,
                              isFocused: isFocused,
                            ),
                          ),
                          child: Center(
                            child: ExcludeSemantics(
                              child: Text(
                                '$dayNum',
                                style: TextStyle(
                                  color: isSelected
                                      ? tokens.selectedForeground
                                      : isDisabled
                                          ? tokens.disabledForeground
                                          : tokens.dayForeground,
                                  fontSize: tokens.dayTextSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String _monthName(int m) => _months[m - 1];

  Border? _dateBorder(
    VDatePickerTokens tokens, {
    required bool isToday,
    required bool isSelected,
    required bool isFocused,
  }) {
    if (isFocused) {
      return Border.all(
        color: tokens.focusOutline,
        width: tokens.focusOutlineWidth,
      );
    }
    if (isToday && !isSelected) {
      return Border.all(
        color: tokens.todayBorder,
        width: tokens.todayBorderWidth,
      );
    }
    return null;
  }

  Color? _dateBackground(
    VDatePickerTokens tokens, {
    required bool isSelected,
    required bool isFocused,
  }) {
    if (isSelected) return tokens.selectedBackground;
    if (isFocused) return tokens.focusBackground;
    return null;
  }

  String _dateSemanticsLabel(
    DateTime date, {
    required bool isSelected,
    required bool isToday,
    required bool isDisabled,
  }) {
    final parts = <String>[
      '${_monthName(date.month)} ${date.day}, ${date.year}',
    ];
    if (isSelected) parts.add('selected');
    if (isToday) parts.add('today');
    if (isDisabled) parts.add('disabled');
    return parts.join(', ');
  }
}

class _DirectionalFocusIntent extends Intent {
  const _DirectionalFocusIntent(this.dayDelta);

  final int dayDelta;
}
