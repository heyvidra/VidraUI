part of '../../main.dart';

class _FormDemo extends StatefulWidget {
  const _FormDemo();
  @override
  State<_FormDemo> createState() => _FormDemoState();
}

class _FormDemoState extends State<_FormDemo> {
  final _formKey = GlobalKey<VFormState>();
  String _status = '';

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Form', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VForm(
                key: _formKey,
                children: [
                  const VFormField(
                    errors: [],
                    child: VTextField(label: 'Name', hint: 'Enter name'),
                  ),
                  const SizedBox(height: 12),
                  const VFormField(
                    errors: [VFormFieldError('This field is required')],
                    child: VTextField(label: 'Email', hint: 'you@example.com'),
                  ),
                  const SizedBox(height: 12),
                  const VFormField(
                    errors: [],
                    child: VTextField(
                      label: 'Password',
                      hint: 'Min 8 characters',
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const VFormField(
                    errors: [],
                    child: VTextField(
                      maxLines: 3,
                      label: 'Description',
                      hint: 'Enter description',
                    ),
                  ),
                  const SizedBox(height: 16),
                  VFlex.horizontal(gap: 8, children: [
                    VButton(
                      onPressed: () {
                        final ok = _formKey.currentState!.validate();
                        setState(
                            () => _status = ok ? 'Valid ✓' : 'Has errors ✗');
                      },
                      child: const VText('Submit', variant: VTextVariant.label),
                    ),
                    if (_status.isNotEmpty)
                      VText(_status, variant: VTextVariant.body),
                  ]),
                ],
              ),
            ),
          ),
        ]);
  }
}


// docs-snippet:start form-basic
// VForm(
//   key: formKey,
//   children: const [
//     VFormField(
//       errors: [VFormFieldError('This field is required')],
//       child: VTextField(label: 'Email', hint: 'you@example.com'),
//     ),
//   ],
// )
// docs-snippet:end form-basic

// docs-snippet:start form-submit
// final formKey = GlobalKey<VFormState>();
//
// VButton(
//   onPressed: () {
//     final valid = formKey.currentState?.validate() ?? false;
//     if (valid) submit();
//   },
//   child: const VText('Submit', variant: VTextVariant.label),
// )
// docs-snippet:end form-submit

