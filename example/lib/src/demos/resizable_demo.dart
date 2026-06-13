part of '../../main.dart';

class _ResizableDemo extends StatefulWidget {
  const _ResizableDemo();
  @override
  State<_ResizableDemo> createState() => _ResizableDemoState();
}

class _ResizableDemoState extends State<_ResizableDemo> {
  Rect _fixedRect = const Rect.fromLTWH(40, 40, 160, 120);
  Rect _expandedRect = const Rect.fromLTWH(40, 40, 160, 120);
  Rect _hiddenRect = const Rect.fromLTWH(40, 40, 160, 110);
  Rect _customRect = const Rect.fromLTWH(40, 40, 160, 110);

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Resizable', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    const VText('Size mode', variant: VTextVariant.title),
                    VResizable(
                      initialSize: const Size(300, 180),
                      enabledHandles: VResizeHandles.all,
                      child: VSurface(
                        variant: VSurfaceVariant.elevated,
                        child: const Center(
                            child: VText('Drag handles to resize',
                                variant: VTextVariant.caption)),
                      ),
                    ),
                    VResizable(
                      initialSize: const Size(220, 110),
                      enabledHandles: const <VResizeHandle>{},
                      child: VSurface(
                        variant: VSurfaceVariant.base,
                        child: const Center(
                            child: VText('No enabled handles',
                                variant: VTextVariant.caption)),
                      ),
                    ),
                  ]),
            ),
          ),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    const VText('Positioned mode', variant: VTextVariant.title),
                    VFlex.horizontal(
                      gap: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _ResizableCanvas(
                            rect: _fixedRect,
                            label: 'Fixed boundary',
                            onChanged: (r) => setState(() => _fixedRect = r),
                          ),
                        ),
                        Expanded(
                          child: _ResizableCanvas(
                            rect: _expandedRect,
                            label: 'Expand within bounds',
                            boundaryBehavior:
                                VResizeBoundaryBehavior.expandWithinBounds,
                            onChanged: (r) => setState(() => _expandedRect = r),
                          ),
                        ),
                      ],
                    ),
                    VFlex.horizontal(
                      gap: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _ResizableCanvas(
                            rect: _hiddenRect,
                            label: 'Hidden handles',
                            showHandles: false,
                            onChanged: (r) => setState(() => _hiddenRect = r),
                          ),
                        ),
                        Expanded(
                          child: _ResizableCanvas(
                            rect: _customRect,
                            label: 'Custom handles',
                            onChanged: (r) => setState(() => _customRect = r),
                            handleBuilder:
                                (context, handle, active, defaultHandle) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color: active
                                      ? theme.colors.actionPrimary
                                      : theme.colors.warning,
                                  borderRadius:
                                      BorderRadius.circular(theme.radii.full),
                                  border:
                                      Border.all(color: theme.colors.border),
                                ),
                                child: const SizedBox(width: 10, height: 10),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ]);
  }
}

class _ResizableCanvas extends StatelessWidget {
  const _ResizableCanvas({
    required this.rect,
    required this.label,
    required this.onChanged,
    this.boundaryBehavior = VResizeBoundaryBehavior.fixed,
    this.showHandles = true,
    this.handleBuilder,
  });

  final Rect rect;
  final String label;
  final ValueChanged<Rect> onChanged;
  final VResizeBoundaryBehavior boundaryBehavior;
  final bool showHandles;
  final VResizeHandleBuilder? handleBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: VSurface(
        variant: VSurfaceVariant.base,
        child: Stack(
          children: [
            VResizable.positioned(
          rect: rect,
              constrainToParent: true,
              boundaryPadding: const EdgeInsets.all(8),
              boundaryBehavior: boundaryBehavior,
              showHandles: showHandles,
              handleBuilder: handleBuilder,
              onRectChanged: onChanged,
              child: VSurface(
                variant: VSurfaceVariant.elevated,
                child: Center(
                  child: VText(label, variant: VTextVariant.caption),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

