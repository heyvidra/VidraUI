import 'package:flutter/widgets.dart';

import '../../foundation/overlay.dart';

VOverlayHandle showVWidgetOverlay(
  BuildContext context,
  VOverlayEntryBuilder builder, {
  bool maintainState = false,
}) {
  final overlay = VOverlay.maybeOf(context);
  if (overlay != null) {
    return overlay.show(
      builder,
      maintainState: maintainState,
    );
  }

  late final _VRawOverlayHandle handle;
  final entry = OverlayEntry(
    maintainState: maintainState,
    builder: (overlayContext) => builder(overlayContext, handle),
  );
  handle = _VRawOverlayHandle(entry);
  Overlay.of(context).insert(entry);
  return handle;
}

class _VRawOverlayHandle implements VOverlayHandle {
  _VRawOverlayHandle(this._entry);

  OverlayEntry? _entry;

  @override
  bool get mounted => _entry?.mounted ?? false;

  @override
  void markNeedsBuild() {
    _entry?.markNeedsBuild();
  }

  @override
  void remove() {
    final entry = _entry;
    if (entry == null) return;
    entry.remove();
    entry.dispose();
    _entry = null;
  }
}
