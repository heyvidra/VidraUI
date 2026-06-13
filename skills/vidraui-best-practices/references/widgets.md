# VidraUI Widget Reference

This document provides API details, architecture rules, and usage notes for VidraUI components.

## VSelectableText

A themed selectable text widget built directly on EditableText with full gesture support.

### API

```dart
const VSelectableText(
  String data, {
  Key? key,
  VTextVariant variant = VTextVariant.body,
  TextAlign? textAlign,
  int? maxLines,
  int? minLines,
  TextOverflow? overflow,
  Color? selectionColor,
  Color? cursorColor,
  EditableTextContextMenuBuilder? contextMenuBuilder,
  String? semanticLabel,
})
```

- `data`: The text to display (required).
- `variant`: Text style variant (heading, title, body, caption).
- `textAlign`: Text alignment (start, center, end).
- `maxLines` / `minLines`: Line constraints.
- `overflow`: How to handle text overflow (clip, ellipsis, fade, visible).
- `selectionColor`: Custom selection highlight color.
- `cursorColor`: Custom cursor color (when focused).
- `contextMenuBuilder`: Custom context menu builder.
- `semanticLabel`: Accessibility label.

### Architecture & Theme Rules

- Built on `EditableText` with `readOnly: true` - **zero Material/Cupertino dependencies**.
- Uses `TextSelectionGestureDetectorBuilder` for gesture handling.
- Uses `VTextSelectionControls` and `VTextSelectionMenu` for context menu.
- Reads `VTypography` from theme for text styles.
- Selection and cursor colors default to theme's `actionPrimary`.

### Gesture Support

VSelectableText supports all standard text selection gestures:

1. **Single tap**: Place cursor at position
2. **Double tap**: Select word at position
3. **Long press**: Select word and show drag handles (ALL pointer devices)
4. **Drag**: Extend selection
5. **Context menu**: Copy, Select All (keyboard shortcuts shown)

### Long Press Implementation

The component uses a **dual gesture detector** architecture to support long press on all pointer devices:

```dart
RawGestureDetector (custom long press, all devices)
  └── TextSelectionGestureDetector (double-tap, tap)
      └── EditableText (rendering)
```

The outer `RawGestureDetector` registers a `LongPressGestureRecognizer` with no device restrictions, winning the gesture arena and enabling long press on touch, mouse, and trackpad.

Custom handlers:
- `_handleLongPressStart`: Select word at touch position
- `_handleLongPressMoveUpdate`: Extend selection with viewport scroll compensation
- `_handleLongPressEnd`: Show selection toolbar
- `_handleLongPressCancel`: Clean up state

### Viewport Scroll Compensation

When dragging during long press, the viewport may scroll. The implementation compensates by tracking:
- `_longPressOrigin`: Global position where long press started
- `_dragStartViewportOffset`: Scroll offset at drag start

Selection coordinates are adjusted for viewport delta to ensure accuracy.

### Context Menu

The default context menu provides:
- **Copy** (Ctrl+C / Cmd+C): Copy selected text
- **Select All** (Ctrl+A / Cmd+A): Select all text

Custom menu builders can be provided via `contextMenuBuilder` parameter.

### Usage Notes

- Use `VSelectableText` when users need to copy text but not edit it.
- For editable text, use `VTextField` instead.
- Long press works on all platforms and pointer devices (touch, mouse, trackpad).
- Selection handles and toolbar appear automatically on selection.
- Text selection respects theme colors and follows platform conventions.
- For headings/titles, header semantics are automatically added.

### Example

```dart
VSelectableText(
  'This text can be selected. Long press on mobile or '
  'drag with a mouse on desktop to select and copy it.',
  variant: VTextVariant.body,
)
```

### Common Issues

**Issue**: Long press doesn't select on mouse/trackpad
**Solution**: Ensure you're using the latest VSelectableText implementation with dual gesture detector architecture.

**Issue**: Selection lost when scrolling
**Solution**: The implementation includes viewport scroll compensation - if this occurs, verify `_handleLongPressMoveUpdate` is working correctly.

## VDivider

A thin horizontal or vertical separator line.

### API

```dart
const VDivider({
  super.key,
  Axis axis = Axis.horizontal,
  double? thickness,
  double? indent,
  double? endIndent,
  Color? color,
  VDividerStyle style = VDividerStyle.solid,
  double? dotRadius,
  double? dotStep,
  Widget? label,
})
```

- `axis`: Separator direction (`Axis.horizontal` or `Axis.vertical`).
- `thickness`: Customized thickness of the separator line (or dots).
- `indent`: Start indent/margin.
- `endIndent`: End indent/margin.
- `color`: Customized line/dot color.
- `style`: Solid or dotted (`VDividerStyle.solid` or `VDividerStyle.dotted`).
- `dotRadius` / `dotStep`: Customizable diameter/spacing of dots. Only active when `style` is `VDividerStyle.dotted`.
- `label`: Central label. Only active when `axis` is `Axis.horizontal` and `style` is `VDividerStyle.solid`.

### Architecture & Theme Rules

- `VDivider` reads `VDividerTokens` from `VDividerTheme.of(context)` or falls back to `VThemeData.components.divider`.
- Colors and thickness must be computed through component tokens, preventing hardcoded styling.

### Usage Notes

- Place horizontal dividers between list items (e.g. `VListTile`).
- Use vertical dividers to separate sidebar panels or adjacent items in a row.
- Ensure that the height/width containing a vertical divider is constrained by parent or flex layouts.
