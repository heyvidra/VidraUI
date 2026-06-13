import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/v_platform.dart';
import '../../theme/v_theme.dart';
import '../../theme/v_theme_data.dart';
import '../basic/v_text.dart';
import 'v_text_selection_controls.dart';
import 'v_text_selection_menu.dart';

/// A themed selectable text widget.
///
/// Built directly on [EditableText] with `readOnly: true` and
/// [TextSelectionGestureDetectorBuilder] for selection gestures —
/// no Material dependency. Supports tap-to-place-cursor,
/// double-tap-to-select-word, long-press/drag-to-select, and
/// a custom [VTextSelectionMenu] context menu.
class VSelectableText extends StatefulWidget {
  const VSelectableText(
    this.data, {
    super.key,
    this.variant = VTextVariant.body,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectionColor,
    this.cursorColor,
    this.contextMenuBuilder,
    this.semanticLabel,
    this.minLines,
  });

  final String data;
  final VTextVariant variant;
  final TextAlign? textAlign;
  final int? maxLines;
  final int? minLines;
  final TextOverflow? overflow;
  final Color? selectionColor;
  final Color? cursorColor;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final String? semanticLabel;

  @override
  State<VSelectableText> createState() => _VSelectableTextState();
}

class _VSelectableTextState extends State<VSelectableText>
    implements TextSelectionGestureDetectorBuilderDelegate {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  final GlobalKey<EditableTextState> _editableTextKey =
      GlobalKey<EditableTextState>();
  late _VSelectableTextGestureDetectorBuilder _selectionGestureDetectorBuilder;

  // Long-press drag tracking (all pointer kinds)
  Offset? _longPressOrigin;
  double _dragStartViewportOffset = 0.0;

  @override
  GlobalKey<EditableTextState> get editableTextKey => _editableTextKey;

  @override
  bool get forcePressEnabled => false;

  @override
  bool get selectionEnabled => true;

  RenderEditable? get _renderEditable =>
      _editableTextKey.currentState?.renderEditable;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.data);
    _focusNode = FocusNode();
    _selectionGestureDetectorBuilder =
        _VSelectableTextGestureDetectorBuilder(state: this);
    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(VSelectableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      final oldSelection = _controller.selection;
      _controller.text = widget.data;
      if (oldSelection.isValid) {
        final newLength = widget.data.length;
        if (oldSelection.baseOffset <= newLength &&
            oldSelection.extentOffset <= newLength) {
          _controller.selection = oldSelection;
        }
      }
    }
  }

  @override
  void dispose() {
    _selectionGestureDetectorBuilder.cancelPending();
    _focusNode.removeListener(_handleFocusChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChanged() {
    if (!_focusNode.hasFocus) {
      _controller.value = TextEditingValue(text: _controller.value.text);
    }
  }

  // ---------------------------------------------------------------------------
  // Long-press handlers (works for all PointerDeviceKind)
  // ---------------------------------------------------------------------------

  void _handleLongPressStart(LongPressStartDetails details) {
    final render = _renderEditable;
    if (render == null) return;

    _longPressOrigin = details.globalPosition;
    _dragStartViewportOffset = render.offset.pixels;

    render.handleTapDown(TapDownDetails(globalPosition: details.globalPosition));
    render.selectWord(cause: SelectionChangedCause.longPress);

    _focusNode.requestFocus();
  }

  void _handleLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    final render = _renderEditable;
    if (render == null || _longPressOrigin == null) return;

    final viewportDelta = render.offset.pixels - _dragStartViewportOffset;
    final adjustedOrigin = _longPressOrigin! - Offset(0, viewportDelta);

    render.selectWordsInRange(
      from: adjustedOrigin,
      to: details.globalPosition,
      cause: SelectionChangedCause.longPress,
    );
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    _longPressOrigin = null;
    _editableTextKey.currentState?.showToolbar();
  }

  void _handleLongPressCancel() {
    _longPressOrigin = null;
  }

  // ---------------------------------------------------------------------------
  // Context menu
  // ---------------------------------------------------------------------------

  EditableTextContextMenuBuilder _defaultContextMenuBuilder(VThemeData theme) {
    return (BuildContext context, EditableTextState editableTextState) {
      return VTextSelectionMenu(
        theme: theme,
        state: editableTextState,
        isDesktop: VPlatformScope.of(context).isDesktop,
        items: _selectableTextMenuItems(editableTextState),
      );
    };
  }

  List<VTextSelectionMenuItem> _selectableTextMenuItems(
    EditableTextState state,
  ) {
    final hasSelection = state.textEditingValue.selection.isValid &&
        !state.textEditingValue.selection.isCollapsed;
    final hasText = state.textEditingValue.text.isNotEmpty;
    final ctrl = VPlatformScope.of(state.context).shortcutModifier;

    return [
      VTextSelectionMenuItem(
        label: 'Copy',
        shortcut: '${ctrl}C',
        enabled: hasSelection,
        onTap: () {
          state.copySelection(SelectionChangedCause.toolbar);
          state.hideToolbar();
        },
      ),
      VTextSelectionMenuItem(
        label: 'Select All',
        shortcut: '${ctrl}A',
        enabled: hasText,
        onTap: () {
          state.selectAll(SelectionChangedCause.toolbar);
          state.hideToolbar();
        },
      ),
    ];
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final baseStyle = resolveVariantStyle(theme, widget.variant);

    final editable = EditableText(
      key: _editableTextKey,
      controller: _controller,
      focusNode: _focusNode,
      readOnly: true,
      enableInteractiveSelection: true,
      showCursor: false,
      textAlign: widget.textAlign ?? TextAlign.start,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      style: baseStyle.copyWith(color: theme.colors.text),
      selectionColor: widget.selectionColor ??
          theme.colors.actionPrimary.withValues(alpha: 0.28),
      cursorColor: widget.cursorColor ?? theme.colors.actionPrimary,
      contextMenuBuilder:
          widget.contextMenuBuilder ?? _defaultContextMenuBuilder(theme),
      selectionControls: VTextSelectionControls(),
      backgroundCursorColor: theme.colors.textDisabled,
      cursorWidth: 2.0,
      rendererIgnoresPointer: true,
    );

    final wrapped = switch (widget.overflow) {
      TextOverflow.clip ||
      TextOverflow.ellipsis ||
      TextOverflow.fade =>
        ClipRect(child: editable),
      TextOverflow.visible || null => editable,
    };

    Widget result = wrapped;
    if (widget.variant == VTextVariant.heading ||
        widget.variant == VTextVariant.title) {
      result = Semantics(header: true, child: result);
    }

    // The framework's TextSelectionGestureDetector hard-codes
    // `supportedDevices: {PointerDeviceKind.touch}` for its
    // LongPressGestureRecognizer, so mouse long-press is silently dropped.
    //
    // Fix: wrap with an outer RawGestureDetector that registers its own
    // LongPressGestureRecognizer with no device restriction.  The outer
    // recognizer wins in the arena (added first) and calls our handlers
    // directly on the RenderEditable, replicating the framework's
    // onSingleLongTapStart / MoveUpdate / End logic for all pointer kinds.
    final innerDetector = _selectionGestureDetectorBuilder.buildGestureDetector(
      behavior: HitTestBehavior.translucent,
      child: result,
    );

    final Widget withLongPress = RawGestureDetector(
      behavior: HitTestBehavior.translucent,
      gestures: {
        LongPressGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
          () => LongPressGestureRecognizer(debugOwner: this),
          (LongPressGestureRecognizer instance) {
            instance
              ..onLongPressStart = _handleLongPressStart
              ..onLongPressMoveUpdate = _handleLongPressMoveUpdate
              ..onLongPressEnd = _handleLongPressEnd
              ..onLongPressCancel = _handleLongPressCancel;
          },
        ),
      },
      child: innerDetector,
    );

    return Semantics(
      label: widget.semanticLabel,
      child: withLongPress,
    );
  }
}

// ---------------------------------------------------------------------------
// Custom gesture detector builder
// ---------------------------------------------------------------------------

/// Extends [TextSelectionGestureDetectorBuilder] to guarantee double-tap
/// word selection even on platforms where the gesture recognizer does not
/// reliably report consecutive tap counts (e.g. mouse/trackpad on desktop).
///
/// Also suppresses the default [onSingleTapUp] selection-collapse behaviour
/// on macOS/iOS when a double-tap was just handled, so the word selection
/// persists.
class _VSelectableTextGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _VSelectableTextGestureDetectorBuilder({required this.state})
      : super(delegate: state);

  final _VSelectableTextState state;

  int _tapCount = 0;
  bool _doubleTapHandled = false;
  Timer? _doubleTapResetTimer;
  static const Duration _doubleTapWindow = Duration(milliseconds: 500);

  void cancelPending() {
    _doubleTapResetTimer?.cancel();
    _doubleTapResetTimer = null;
    _tapCount = 0;
    _doubleTapHandled = false;
  }

  @override
  void onTapDown(TapDragDownDetails details) {
    _tapCount++;
    _doubleTapResetTimer?.cancel();
    if (_doubleTapHandled && _tapCount == 1) {
      _doubleTapHandled = false;
    }

    if (_tapCount == 2 && delegate.selectionEnabled) {
      _selectWordFromDoubleTap(details);
      _tapCount = 0;
      _doubleTapHandled = true;
      _doubleTapResetTimer = null;
    } else {
      super.onTapDown(details);
      _doubleTapResetTimer = Timer(_doubleTapWindow, () {
        _tapCount = 0;
        _doubleTapResetTimer = null;
      });
    }
  }

  @override
  void onDoubleTapDown(TapDragDownDetails details) {
    if (!delegate.selectionEnabled) return;
    _selectWordFromDoubleTap(details);
    _doubleTapHandled = true;
  }

  void _selectWordFromDoubleTap(TapDragDownDetails details) {
    delegate.editableTextKey.currentState?.requestKeyboard();
    renderEditable.handleTapDown(
      TapDownDetails(globalPosition: details.globalPosition),
    );
    renderEditable.selectWord(cause: SelectionChangedCause.doubleTap);
  }

  @override
  void onSingleTapUp(TapDragUpDetails details) {
    // On macOS/iOS the default handler collapses a non-empty selection back
    // to a cursor. Prevent that when we just selected a word via double-tap.
    if (_doubleTapHandled) {
      _doubleTapHandled = false;
      return;
    }
    super.onSingleTapUp(details);
  }

  @override
  void onSingleTapCancel() {
    _doubleTapHandled = false;
    _tapCount = 0;
    _doubleTapResetTimer?.cancel();
    _doubleTapResetTimer = null;
    super.onSingleTapCancel();
  }
}
