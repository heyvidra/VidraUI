part of 'v_text_field.dart';

class _VTextFieldSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _VTextFieldSelectionGestureDetectorBuilder({required _VTextFieldState state})
      : super(delegate: state);
}
