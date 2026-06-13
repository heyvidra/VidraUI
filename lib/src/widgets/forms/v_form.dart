import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';
import '../basic/v_text.dart';

/// A validation error for a form field.
class VFormFieldError {
  const VFormFieldError(this.message);
  final String message;
}

/// Wraps a form field widget and displays validation errors below it.
class VFormField extends StatelessWidget {
  const VFormField({
    super.key,
    required this.child,
    this.errors = const [],
  });

  final Widget child;
  final List<VFormFieldError> errors;

  bool get hasError => errors.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        ...errors.map(
          (e) => Padding(
            padding: EdgeInsets.only(top: theme.spacing.xs),
            child: Semantics(
              liveRegion: true,
              child: VText(
                e.message,
                variant: VTextVariant.caption,
                color: theme.colors.danger,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// A simple form widget that collects [VFormField] children and validates
/// them on submit.
///
/// Pass a list of [VFormField] widgets as [children]. Call [validate] to
/// check all fields and return true if all are valid.
///
/// ```dart
/// final formKey = GlobalKey<VFormState>();
///
/// VForm(
///   key: formKey,
///   children: [
///     VFormField(
///       errors: _nameErrors,
///       child: VTextField(label: 'Name'),
///     ),
///   ],
/// );
///
/// // On submit:
/// if (formKey.currentState!.validate()) { ... }
/// ```
class VForm extends StatefulWidget {
  const VForm({
    super.key,
    required this.children,
    this.gap,
    this.onSubmit,
  });

  final List<Widget> children;
  final double? gap;
  final VoidCallback? onSubmit;

  @override
  State<VForm> createState() => VFormState();
}

class VFormState extends State<VForm> {
  /// Validates all form fields and returns true if none have errors.
  ///
  /// This method walks the subtree looking for [VFormField] widgets and checks
  /// whether any have errors. It does **not** trigger a rebuild — callers are
  /// responsible for updating their own state (e.g. via `setState`) after
  /// receiving the validation result if they need the UI to reflect new errors.
  bool validate() {
    // Walk the subtree looking for VFormField widgets and check their errors.
    bool valid = true;
    void visitor(Element element) {
      final widget = element.widget;
      if (widget is VFormField && widget.hasError) {
        valid = false;
      }
      element.visitChildren(visitor);
    }

    context.visitChildElements(visitor);
    if (valid) {
      widget.onSubmit?.call();
    }
    return valid;
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final gap = widget.gap ?? theme.spacing.md;
    final children = <Widget>[];

    for (var i = 0; i < widget.children.length; i++) {
      if (i > 0 && gap > 0) {
        children.add(SizedBox(height: gap));
      }
      children.add(widget.children[i]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
