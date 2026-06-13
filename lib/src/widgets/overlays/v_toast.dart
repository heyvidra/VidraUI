import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../foundation/background.dart';
import '../../foundation/motion.dart';
import '../../foundation/overlay.dart';
import '../../foundation/toast.dart';
import '../../theme/v_component_themes.g.dart';
import '../../theme/v_motion_scope.dart';
import '../../theme/v_overlay_animation.dart';
import '../../theme/v_screen.dart';
import '../../theme/v_theme.dart';

part 'v_toast_icon.dart';
part 'v_toast_view.dart';

/// Variants for [VToast].
enum VToastVariant {
  info,
  success,
  warning,
  error,
}

/// Builds a trailing action for [VToast].
typedef VToastActionBuilder = Widget Function(
  BuildContext context,
  VoidCallback dismiss,
);

/// Displays a brief, auto-dismissing message at the bottom of the screen.
///
/// Uses [VOverlay] — does not depend on Material's messenger or snack-bar APIs.
///
/// ```dart
/// VToast.show(
///   context,
///   message: 'Saved successfully',
///   variant: VToastVariant.success,
/// );
/// ```
class VToast {
  /// Shows a toast with [message].
  ///
  /// The toast auto-dismisses after [duration]. Defaults to 3 seconds, or
  /// 5 seconds when [action] is provided.
  ///
  /// Use [stackMode] to control how multiple toasts are handled:
  /// - [VToastStackMode.replace]: New toasts replace existing ones (default)
  /// - [VToastStackMode.stack]: New toasts stack above existing ones
  static void show(
    BuildContext context, {
    required String message,
    VToastVariant variant = VToastVariant.info,
    VToastPosition position = VToastPosition.bottom,
    VToastStackMode stackMode = VToastStackMode.replace,
    Duration? duration,
    Widget? icon,
    VToastActionBuilder? action,
    VBackground? background,
  }) {
    final host = VOverlay.of(context);
    final sourceTheme = resolveOverlayTheme(
      context,
      VToastTheme.of,
      (c, t) => c.copyWith(toast: t),
    );

    host.showToast(
      (context, handle) {
        final tokens = sourceTheme.components.toast;
        final toast = VTheme(
          data: sourceTheme,
          child: _VToastView(
            message: message,
            variant: variant,
            duration: duration ??
                (action == null
                    ? const Duration(seconds: 3)
                    : const Duration(seconds: 5)),
            icon: icon,
            action: action,
            background: background,
            onDismissed: () {
              handle.remove();
            },
          ),
        );
        final isLargeScreen = context.vIsMdUp;
        final effectiveToast = isLargeScreen
            ? Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: toast,
                ),
              )
            : toast;

        // Apply horizontal insets
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: tokens.horizontalInset,
          ).copyWith(
            bottom: position == VToastPosition.bottom 
                ? tokens.verticalInset 
                : 0,
            top: position == VToastPosition.top 
                ? tokens.verticalInset 
                : 0,
          ),
          child: effectiveToast,
        );
      },
      position: position,
      stackMode: stackMode,
    );
  }
}
