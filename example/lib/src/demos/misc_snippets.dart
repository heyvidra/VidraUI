part of '../../main.dart';

// docs-snippet:start sheet-basic
// VSheet.show<void>(
//   context,
//   edge: VSheetEdge.bottom,
//   size: VSheetSize.auto,
//   builder: (ctx) => VSheetSurface(
//     child: VButton(
//       onPressed: () => VSheetScope.of<void>(ctx)(null),
//       child: const VText('Close', variant: VTextVariant.label),
//     ),
//   ),
// )
// docs-snippet:end sheet-basic

// docs-snippet:start time-picker-basic
// VTimePicker(
//   selected: selectedTime,
//   onChanged: (time) => setState(() => selectedTime = time),
// )
// docs-snippet:end time-picker-basic

// docs-snippet:start feedback-basic
// VFlex.vertical(
// crossAxisAlignment: CrossAxisAlignment.stretch,
//   gap: 12,
//   children: const [
//     VProgressBar(value: 0.7),
//     VProgressBar(value: null),
//     VSpinner(),
//   ],
// )
// docs-snippet:end feedback-basic

// docs-snippet:start layout-basic
// VScaffold(
//   header: const VAppBar(title: VText('Settings')),
//   body: VFlex.vertical(
// crossAxisAlignment: CrossAxisAlignment.stretch,
//     padding: const EdgeInsets.all(16),
//     gap: 12,
//     children: const [VText('Content')],
//   ),
// )
// docs-snippet:end layout-basic

// docs-snippet:start dialog-basic
// final confirmed = await VDialog.show<bool>(
//   context,
//   builder: (ctx) => VDialogSurface(
//     child: VFlex.vertical(
// crossAxisAlignment: CrossAxisAlignment.stretch,
//       gap: 16,
//       children: [
//         const VText('Delete item?', variant: VTextVariant.title),
//         const VText('This action cannot be undone.'),
//         VButton(
//           onPressed: () => VDialogScope.of<bool>(ctx)(true),
//           variant: VButtonVariant.danger,
//           child: const VText('Delete', variant: VTextVariant.label),
//         ),
//       ],
//     ),
//   ),
// );
// docs-snippet:end dialog-basic

// docs-snippet:start scaffold-background-gradient
// VScaffold(
//   background: VBackground.gradient(
//     LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [theme.colors.background, theme.colors.surfaceElevated],
//     ),
//   ),
//   body: const VText('Page content'),
// )
// docs-snippet:end scaffold-background-gradient

// docs-snippet:start tokens-basic
// final theme = VTheme.of(context);
// return VSurface(
//   child: Padding(
//     padding: EdgeInsets.all(theme.spacing.md),
//     child: VText('Tokenized spacing and typography'),
//   ),
// );
// docs-snippet:end tokens-basic

// docs-snippet:start state-property-basic
// final background = VStateProperty<Color>.resolveWith(
//   normal: theme.colors.surface,
//   hovered: theme.colors.surfaceHover,
//   pressed: theme.colors.surfacePressed,
//   disabled: theme.colors.surfaceDisabled,
// );
// docs-snippet:end state-property-basic

