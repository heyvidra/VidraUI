part of '../../main.dart';

class _DatePickerDemo extends StatefulWidget {
  const _DatePickerDemo();
  @override
  State<_DatePickerDemo> createState() => _DatePickerDemoState();
}

class _DatePickerDemoState extends State<_DatePickerDemo> {
  DateTime? _date;
  VTimeOfDay? _time;

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Date & Time Picker', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 16,
                  children: [
                    VText(
                      _date != null
                          ? 'Selected: ${_date!.year}-${_date!.month.toString().padLeft(2, '0')}-${_date!.day.toString().padLeft(2, '0')}'
                          : 'No date selected',
                      variant: VTextVariant.body,
                    ),
                    VDatePicker(
                      selected: _date,
                      onChanged: (d) => setState(() => _date = d),
                    ),
                    VDivider(),
                    VText(
                      _time != null ? 'Time: $_time' : 'No time selected',
                      variant: VTextVariant.body,
                    ),
                    VTimePicker(
                      selected: _time,
                      onChanged: (t) => setState(() => _time = t),
                    ),
                  ]),
            ),
          ),
        ]);
  }
}


// docs-snippet:start date-picker-basic
// VDatePicker(
//   selected: selectedDate,
//   onChanged: (date) => setState(() => selectedDate = date),
// )
// docs-snippet:end date-picker-basic

// docs-snippet:start date-picker-range
// VDatePicker(
//   selected: selectedDate,
//   firstDate: DateTime(2026, 1, 1),
//   lastDate: DateTime(2026, 12, 31),
//   onChanged: (date) => setState(() => selectedDate = date),
// )
// docs-snippet:end date-picker-range

