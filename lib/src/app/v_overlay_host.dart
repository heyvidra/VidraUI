import 'package:flutter/widgets.dart';

import '../foundation/overlay.dart';
import '../foundation/toast.dart';

export '../foundation/overlay.dart'
    show VOverlayController, VOverlayEntryBuilder, VOverlayHandle, VToastHandle;
export '../foundation/toast.dart' show VToastPosition, VToastStackMode;

class _VOverlayHostHandle implements VOverlayHandle {
  _VOverlayHostHandle(this._host);

  final VOverlayHostState _host;
  OverlayEntry? _entry;

  @override
  bool get mounted => _entry?.mounted ?? false;

  void _attach(OverlayEntry entry) {
    _entry = entry;
  }

  @override
  void markNeedsBuild() {
    _entry?.markNeedsBuild();
  }

  @override
  void remove() {
    final entry = _entry;
    if (entry == null) return;
    _host._remove(entry);
    _entry = null;
  }
}

class _VToastHostHandle extends _VOverlayHostHandle implements VToastHandle {
  _VToastHostHandle(
    super.host,
    this.position,
    this.stackMode,
  );

  @override
  final VToastPosition position;

  @override
  final VToastStackMode stackMode;

  double height = 56.0;

  @override
  void remove() {
    final entry = _entry;
    if (entry == null) return;
    _host._removeToast(this);
    _entry = null;
  }
}

/// A host widget that manages an [Overlay] for toast, dialog, and other
/// overlay content.
///
/// Insert overlay entries via [VOverlayHostState.insert] and remove them
/// via [VOverlayHostState.remove]. All entries are cleaned up when the
/// host is disposed.
///
/// Obtain the host state from any descendant context:
/// ```dart
/// final host = VOverlay.of(context);
/// ```
class VOverlayHost extends StatefulWidget {
  const VOverlayHost({
    super.key,
    required this.child,
    required this.textDirection,
  });

  final Widget child;
  final TextDirection textDirection;

  @override
  State<VOverlayHost> createState() => VOverlayHostState();
}

class VOverlayHostState extends State<VOverlayHost>
    implements VOverlayController {
  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();
  final List<OverlayEntry> _entries = <OverlayEntry>[];
  final List<_VToastHostHandle> _toastHandles = <_VToastHostHandle>[];
  
  // The base entry that renders widget.child. Created once in initState so
  // it is properly tracked and disposed when the host is torn down.
  late final OverlayEntry _childEntry;

  @override
  void initState() {
    super.initState();
    _childEntry = OverlayEntry(
      builder: (context) => widget.child,
    );
  }

  OverlayState get _overlay {
    final state = _overlayKey.currentState;
    assert(state != null,
        'VOverlayHostState._overlay accessed before Overlay is built');
    return state!;
  }

  /// Inserts an overlay entry and returns a removable handle.
  @override
  VOverlayHandle show(
    VOverlayEntryBuilder builder, {
    bool maintainState = false,
  }) {
    final handle = _VOverlayHostHandle(this);
    final entry = OverlayEntry(
      maintainState: maintainState,
      builder: (context) => builder(context, handle),
    );

    handle._attach(entry);
    _overlay.insert(entry);
    _entries.add(entry);

    return handle;
  }

  /// Shows a toast with stack management support.
  @override
  VToastHandle showToast(
    VOverlayEntryBuilder builder, {
    required VToastPosition position,
    required VToastStackMode stackMode,
    bool maintainState = false,
  }) {
    // Handle replace mode by removing existing toasts at the same position
    if (stackMode == VToastStackMode.replace) {
      final toRemove = _toastHandles
          .where((h) => h.position == position && h.mounted)
          .toList();
      for (final handle in toRemove) {
        handle.remove();
      }
    }

    final handle = _VToastHostHandle(this, position, stackMode);
    
    final entry = OverlayEntry(
      maintainState: maintainState,
      builder: (context) {
        // Calculate stack offset at build time for dynamic positioning
        final stackOffset = _calculateToastStackOffset(position, handle);
        return _ToastStackWrapper(
          position: position,
          stackOffset: stackOffset,
          onHeightMeasured: (height) {
            if (handle.height != height) {
              handle.height = height;
              _updateToastPositions(position);
            }
          },
          child: builder(context, handle),
        );
      },
    );

    handle._attach(entry);
    _overlay.insert(entry);
    _entries.add(entry);
    _toastHandles.add(handle);

    return handle;
  }

  /// Calculates the vertical offset for a toast based on existing toasts.
  double _calculateToastStackOffset(VToastPosition position, _VToastHostHandle currentHandle) {
    final toastsAtPosition = _toastHandles
        .where((h) => h.position == position && h.mounted)
        .toList();
    final currentIndex = toastsAtPosition.indexOf(currentHandle);
    
    if (currentIndex <= 0) return 0.0;
    
    double offset = 0.0;
    const gap = 8.0;
    for (int i = 0; i < currentIndex; i++) {
      offset += toastsAtPosition[i].height + gap;
    }
    return offset;
  }

  /// Removes and disposes a previously inserted overlay entry.
  void _remove(OverlayEntry entry) {
    if (_entries.remove(entry)) {
      entry.remove();
      entry.dispose();
    }
  }

  /// Removes and disposes a toast handle.
  void _removeToast(_VToastHostHandle handle) {
    final entry = handle._entry;
    if (entry != null && _entries.remove(entry)) {
      entry.remove();
      entry.dispose();
    }
    _toastHandles.remove(handle);
    
    // Update positions of remaining toasts at the same position
    _updateToastPositions(handle.position);
  }

  /// Updates the positions of remaining toasts after one is removed.
  void _updateToastPositions(VToastPosition position) {
    final toastsAtPosition = _toastHandles
        .where((h) => h.position == position && h.mounted)
        .toList();
    
    // Mark all toast entries for rebuild to update their stack positions
    for (final handle in toastsAtPosition) {
      handle.markNeedsBuild();
    }
  }

  @override
  void dispose() {
    for (final entry in List<OverlayEntry>.from(_entries)) {
      entry.remove();
      entry.dispose();
    }
    _entries.clear();
    _toastHandles.clear();
    // _childEntry is part of the Overlay's initialEntries. The Overlay widget
    // owns its lifetime and disposes it during its own teardown, so we must
    // NOT call remove() or dispose() on it here — doing so triggers an
    // assertion: "OverlayEntry must first be removed from the Overlay before
    // dispose is called". Ownership of _childEntry stays with the Overlay.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.textDirection,
      child: VOverlayControllerScope(
        controller: this,
        child: Overlay(
          key: _overlayKey,
          initialEntries: [_childEntry],
        ),
      ),
    );
  }
}

/// Wrapper that handles toast stack positioning.
class _ToastStackWrapper extends StatefulWidget {
  const _ToastStackWrapper({
    required this.position,
    required this.stackOffset,
    required this.onHeightMeasured,
    required this.child,
  });

  final VToastPosition position;
  final double stackOffset;
  final ValueChanged<double> onHeightMeasured;
  final Widget child;

  @override
  State<_ToastStackWrapper> createState() => _ToastStackWrapperState();
}

class _ToastStackWrapperState extends State<_ToastStackWrapper> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureHeight());
  }

  @override
  void didUpdateWidget(covariant _ToastStackWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureHeight());
  }

  void _measureHeight() {
    if (!mounted) return;
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      widget.onHeightMeasured(renderBox.size.height);
    }
  }

  @override
  Widget build(BuildContext context) {
    final positionedChild = KeyedSubtree(
      key: _key,
      child: widget.child,
    );

    return switch (widget.position) {
      VToastPosition.bottom => Positioned(
          left: 0,
          right: 0,
          bottom: widget.stackOffset,
          child: positionedChild,
        ),
      VToastPosition.top => Positioned(
          left: 0,
          right: 0,
          top: widget.stackOffset,
          child: positionedChild,
        ),
      VToastPosition.center => Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Center(
            child: Transform.translate(
              offset: Offset(
                0,
                widget.position == VToastPosition.center
                    ? widget.stackOffset * 0.5
                    : widget.stackOffset,
              ),
              child: positionedChild,
            ),
          ),
        ),
    };
  }
}