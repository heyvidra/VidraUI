import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/v_appearance.dart';
import '../../theme/v_appearance_box.dart';
import '../../theme/v_appearance_scope.dart';
import '../../theme/v_component_themes.g.dart';
import '../../theme/v_icon_theme.dart';
import '../../theme/v_icon_theme_data.dart';
import '../../theme/v_theme.dart';
import '../feedback/v_progress.dart';
import '../interaction/v_interactive.dart';
import 'button_internal.dart';

/// Variants for [VButton].
enum VButtonVariant {
  primary,
  secondary,
  danger,
}

/// Shape options for [VButton].
enum VButtonShape { rounded, circle, none }

/// An accessible, theme-aware button.
///
/// Uses [VInteractive] for interaction state and reads [VButtonTokens]
/// from the current [VTheme]. Supports keyboard activation via Enter/Space.
class VButton extends StatelessWidget {
  const VButton({
    super.key,
    required this.child,
    this.onPressed,
    this.variant = VButtonVariant.primary,
    this.size = VControlSize.md,
    this.shape = VButtonShape.rounded,
    this.appearance,
    this.leadingIcon,
    this.trailingIcon,
    this.iconGap,
    this.loading = false,
    this.loadingIndicator,
    this.loadingSemanticLabel,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
  });

  /// The content of the button (usually [VText] or an icon).
  final Widget child;

  /// Called when the button is tapped or activated via keyboard.
  final VoidCallback? onPressed;

  /// The visual variant.
  final VButtonVariant variant;

  /// The button size.
  final VControlSize size;

  /// The button shape.
  final VButtonShape shape;

  /// Per-component appearance override.
  final VAppearance? appearance;

  /// Optional icon before the [child].
  final Widget? leadingIcon;

  /// Optional icon after the [child].
  final Widget? trailingIcon;

  /// Gap between icon and [child]. Defaults to [VSpacing.sm] (8.0).
  final double? iconGap;

  /// When true, shows a loading indicator and disables interaction.
  final bool loading;

  /// Custom loading widget. Defaults to a small animated dots spinner.
  final Widget? loadingIndicator;

  /// Semantic label announced when in loading state.
  final String? loadingSemanticLabel;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Whether this button should focus itself initially.
  final bool autofocus;

  /// An optional external focus node.
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VButtonTheme.of(context) ?? theme.components.button;

    final interactive = onPressed != null && !loading;

    return Semantics(
      button: true,
      enabled: interactive,
      label: semanticLabel,
      hint: loading
          ? (loadingSemanticLabel ?? 'Loading, please wait')
          : (!interactive ? 'Button is disabled' : null),
      liveRegion: loading,
      child: Actions(
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (ActivateIntent intent) {
              if (!loading) onPressed?.call();
              return null;
            },
          ),
        },
        child: Shortcuts(
          shortcuts: const <ShortcutActivator, Intent>{
            SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
            SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
          },
          child: VInteractive(
            enabled: interactive,
            onTap: interactive ? onPressed : null,
            autofocus: autofocus,
            focusNode: focusNode,
            requestFocusOnTap: false,
            builder: (context, states) {
              final background = switch (variant) {
                VButtonVariant.primary =>
                  tokens.primaryBackground.resolve(states),
                VButtonVariant.secondary =>
                  tokens.secondaryBackground.resolve(states),
                VButtonVariant.danger =>
                  tokens.dangerBackground.resolve(states),
              };

              final appearance =
                  this.appearance ?? VAppearanceScope.of(context);

              final foregroundBase = switch (variant) {
                VButtonVariant.primary =>
                  tokens.primaryForeground.resolve(states),
                VButtonVariant.secondary =>
                  tokens.secondaryForeground.resolve(states),
                VButtonVariant.danger =>
                  tokens.dangerForeground.resolve(states),
              };
              
              // For shape.none (text buttons), we need semantic colors that vary by state
              final semanticColor = switch (variant) {
                VButtonVariant.primary => 
                  states.contains(WidgetState.disabled)
                    ? theme.colors.textDisabled
                    : states.contains(WidgetState.pressed)
                      ? theme.colors.actionPrimaryPressed
                      : states.contains(WidgetState.hovered)
                        ? theme.colors.actionPrimaryHover
                        : theme.colors.actionPrimary,
                VButtonVariant.secondary => 
                  states.contains(WidgetState.disabled)
                    ? theme.colors.textDisabled
                    : theme.colors.text,  // Secondary keeps same color on hover
                VButtonVariant.danger => 
                  states.contains(WidgetState.disabled)
                    ? theme.colors.textDisabled
                    : states.contains(WidgetState.pressed)
                      ? theme.colors.danger
                      : states.contains(WidgetState.hovered)
                        ? theme.colors.dangerHover
                        : theme.colors.danger,
              };
              
              // Semantic color = the variant's action color, used by
              // Outlined/Glass appearances as visible text on transparent bg.
              final semantic = switch (variant) {
                VButtonVariant.primary => theme.colors.actionPrimary,
                VButtonVariant.secondary => theme.colors.text,
                VButtonVariant.danger => theme.colors.danger,
              };
              
              // For shape.none (text buttons), use state-aware semantic color
              // to ensure text is visible without background and responds to hover
              final foreground = shape == VButtonShape.none
                  ? semanticColor
                  : (appearance?.foreground(foregroundBase, states, semantic) ??
                      foregroundBase);

              final border = switch (variant) {
                VButtonVariant.primary => tokens.primaryBorder.resolve(states),
                VButtonVariant.secondary =>
                  tokens.secondaryBorder.resolve(states),
                VButtonVariant.danger => tokens.dangerBorder.resolve(states),
              };

              final focused = states.contains(WidgetState.focused);
              final shadows = focused
                  ? [
                      BoxShadow(
                        color: tokens.focusRing.withValues(alpha: 0.45),
                        blurRadius: 0,
                        spreadRadius: 3,
                      ),
                    ]
                  : <BoxShadow>[];

              final resolvedBg =
                  appearance?.background(background, states) ?? background;

              final effectiveBorderColor =
                  appearance?.borderColor(border, states) ?? border;
              final effectiveBorderWidth = appearance?.borderWidth(1.0) ?? 1.0;
              final effectiveShadows = appearance?.shadows(shadows) ?? shadows;
              final buttonHeight = switch (size) {
                VControlSize.sm => tokens.heightSm,
                VControlSize.md => tokens.heightMd,
                VControlSize.lg => tokens.heightLg,
              };
              final horizontalPadding = switch (size) {
                VControlSize.sm => tokens.paddingHorizontalSm,
                VControlSize.md => tokens.paddingHorizontalMd,
                VControlSize.lg => tokens.paddingHorizontalLg,
              };
              final verticalPadding = switch (size) {
                VControlSize.sm => tokens.paddingVerticalSm,
                VControlSize.md => tokens.paddingVerticalMd,
                VControlSize.lg => tokens.paddingVerticalLg,
              };
              final iconSize = switch (size) {
                VControlSize.sm => tokens.iconSizeSm,
                VControlSize.md => tokens.iconSizeMd,
                VControlSize.lg => tokens.iconSizeLg,
              };
              final circular = shape == VButtonShape.circle;
              final baseRadius = circular ? buttonHeight / 2 : tokens.radius;
              final resolvedRadius = BorderRadius.circular(
                appearance?.radius(baseRadius) ?? baseRadius,
              );

              final content = VTheme(
                data: theme.copyWith(
                  colors: theme.colors.copyWith(text: foreground),
                ),
                child: VIconTheme(
                  data: VIconThemeData(
                    color: foreground,
                    size: iconSize,
                  ),
                  child: DefaultTextStyle(
                    style: theme.typography.label.copyWith(
                      color: foreground,
                    ),
                    child: ButtonContent(
                      loading: loading,
                      loadingIndicator:
                          loadingIndicator ?? VLoadingDots(color: foreground),
                      leadingIcon: leadingIcon,
                      trailingIcon: trailingIcon,
                      gap: iconGap ?? theme.spacing.sm,
                      child: child,
                    ),
                  ),
                ),
              );

              if (shape == VButtonShape.none) {
                return content;
              }

              return VVisualBox(
                  appearance: appearance,
                  states: states,
                  background: resolvedBg,
                  borderRadius: resolvedRadius,
                  child: RepaintBoundary(
                      child: AnimatedButtonDecoration(
                    duration: theme.motion.control.duration,
                    curve: theme.motion.control.curve,
                    backgroundColor: resolvedBg,
                    borderColor: effectiveBorderColor,
                    borderWidth: effectiveBorderWidth,
                    borderRadius: resolvedRadius,
                    shadows: effectiveShadows,
                    constraints: BoxConstraints(
                      minWidth: circular ? buttonHeight : 0,
                      minHeight: buttonHeight,
                    ),
                    padding: circular
                        ? EdgeInsets.zero
                        : EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                            vertical: verticalPadding,
                          ),
                    child: circular
                        ? SizedBox.square(
                            dimension: buttonHeight,
                            child: Center(child: content),
                          )
                        : Center(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: content,
                          ),
                  )));
            },
          ),
        ),
      ),
    );
  }
}
