import 'docs.dart';

const vApiInventory = <String, VDocApiSymbol>{
  'VAccordion': VDocApiSymbol(
    name: 'VAccordion',
    kind: 'class',
    library: 'lib/src/widgets/layout/v_accordion.dart',
    members: [
      VDocApiMember(
        name: 'VAccordion',
        kind: 'constructor',
        signature: 'const VAccordion({',
      ),
      VDocApiMember(
        name: 'initialIndex',
        kind: 'field',
        signature: 'final int? initialIndex;',
      ),
      VDocApiMember(
        name: 'items',
        kind: 'field',
        signature: 'final List<VAccordionItem> items;',
      ),
      VDocApiMember(
        name: 'multiple',
        kind: 'field',
        signature: 'final bool multiple;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VAccordion> createState() => _VAccordionState();',
      ),
    ],
  ),
  'VAccordionItem': VDocApiSymbol(
    name: 'VAccordionItem',
    kind: 'class',
    library: 'lib/src/widgets/layout/v_accordion.dart',
    members: [
      VDocApiMember(
        name: 'VAccordionItem',
        kind: 'constructor',
        signature: 'const VAccordionItem({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'header',
        kind: 'field',
        signature: 'final Widget header;',
      ),
      VDocApiMember(
        name: 'indicatorAtStart',
        kind: 'field',
        signature: 'final bool indicatorAtStart;',
      ),
      VDocApiMember(
        name: 'indicatorColor',
        kind: 'field',
        signature: 'final Color? indicatorColor;',
      ),
      VDocApiMember(
        name: 'initiallyExpanded',
        kind: 'field',
        signature: 'final bool initiallyExpanded;',
      ),
    ],
  ),
  'VAccordionTheme': VDocApiSymbol(
    name: 'VAccordionTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VAccordionTheme',
        kind: 'constructor',
        signature: 'const VAccordionTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VAccordionTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VAccordionTokens': VDocApiSymbol(
    name: 'VAccordionTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_accordion_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VAccordionTokens',
        kind: 'constructor',
        signature: 'const VAccordionTokens({',
      ),
      VDocApiMember(
        name: 'VAccordionTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VAccordionTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'VAccordionTokens.fromTheme',
        kind: 'constructor',
        signature: 'factory VAccordionTokens.fromTheme({',
      ),
      VDocApiMember(
        name: 'bodyBackground',
        kind: 'field',
        signature: 'final Color bodyBackground;',
      ),
      VDocApiMember(
        name: 'bodyPadding',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry bodyPadding;',
      ),
      VDocApiMember(
        name: 'focusRing',
        kind: 'field',
        signature: 'final Color focusRing;',
      ),
      VDocApiMember(
        name: 'headerBackground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> headerBackground;',
      ),
      VDocApiMember(
        name: 'headerBorder',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> headerBorder;',
      ),
      VDocApiMember(
        name: 'headerForeground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> headerForeground;',
      ),
      VDocApiMember(
        name: 'headerPadding',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry headerPadding;',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'field',
        signature: 'final double radius;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VAccordionTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VAccordionTokens lerp(',
      ),
    ],
  ),
  'VAlertDialog': VDocApiSymbol(
    name: 'VAlertDialog',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_alert_dialog.dart',
    members: [
      VDocApiMember(
        name: 'VAlertDialog',
        kind: 'constructor',
        signature: 'const VAlertDialog({',
      ),
      VDocApiMember(
        name: 'actions',
        kind: 'field',
        signature: 'final List<Widget>? actions;',
      ),
      VDocApiMember(
        name: 'body',
        kind: 'field',
        signature: 'final String? body;',
      ),
      VDocApiMember(
        name: 'bodyWidget',
        kind: 'field',
        signature: 'final Widget? bodyWidget;',
      ),
      VDocApiMember(
        name: 'closable',
        kind: 'field',
        signature: 'final bool closable;',
      ),
      VDocApiMember(
        name: 'maxHeight',
        kind: 'field',
        signature: 'final double? maxHeight;',
      ),
      VDocApiMember(
        name: 'onClose',
        kind: 'field',
        signature: 'final VoidCallback? onClose;',
      ),
      VDocApiMember(
        name: 'surfaceBackground',
        kind: 'field',
        signature: 'final VBackground? surfaceBackground;',
      ),
      VDocApiMember(
        name: 'title',
        kind: 'field',
        signature: 'final String? title;',
      ),
      VDocApiMember(
        name: 'width',
        kind: 'field',
        signature: 'final double? width;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VAnchoredOverlayPlacement': VDocApiSymbol(
    name: 'VAnchoredOverlayPlacement',
    kind: 'enum',
    library: 'lib/src/widgets/overlays/v_anchored_overlay.dart',
    members: [
      VDocApiMember(
        name: 'auto',
        kind: 'value',
        signature: 'auto',
      ),
      VDocApiMember(
        name: 'down',
        kind: 'value',
        signature: 'down',
      ),
      VDocApiMember(
        name: 'up',
        kind: 'value',
        signature: 'up',
      ),
      VDocApiMember(
        name: 'left',
        kind: 'value',
        signature: 'left',
      ),
      VDocApiMember(
        name: 'right',
        kind: 'value',
        signature: 'right',
      ),
      VDocApiMember(
        name: 'autoHorizontal',
        kind: 'value',
        signature: 'autoHorizontal',
      ),
    ],
  ),
  'VAnimatedBox': VDocApiSymbol(
    name: 'VAnimatedBox',
    kind: 'class',
    library: 'lib/src/widgets/animation/v_animated.dart',
    members: [
      VDocApiMember(
        name: 'VAnimatedBox',
        kind: 'constructor',
        signature: 'const VAnimatedBox({',
      ),
      VDocApiMember(
        name: 'alignment',
        kind: 'field',
        signature: 'final AlignmentGeometry? alignment;',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget? child;',
      ),
      VDocApiMember(
        name: 'clipBehavior',
        kind: 'field',
        signature: 'final Clip clipBehavior;',
      ),
      VDocApiMember(
        name: 'constraints',
        kind: 'field',
        signature: 'final BoxConstraints? constraints;',
      ),
      VDocApiMember(
        name: 'decoration',
        kind: 'field',
        signature: 'final Decoration? decoration;',
      ),
      VDocApiMember(
        name: 'height',
        kind: 'field',
        signature: 'final double? height;',
      ),
      VDocApiMember(
        name: 'margin',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry? margin;',
      ),
      VDocApiMember(
        name: 'motion',
        kind: 'field',
        signature: 'final VMotionSpec? motion;',
      ),
      VDocApiMember(
        name: 'padding',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry? padding;',
      ),
      VDocApiMember(
        name: 'width',
        kind: 'field',
        signature: 'final double? width;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VAnimatedList': VDocApiSymbol(
    name: 'VAnimatedList',
    kind: 'class',
    library: 'lib/src/widgets/animation/v_animated_list.dart',
    members: [
      VDocApiMember(
        name: 'VAnimatedList',
        kind: 'constructor',
        signature: 'const VAnimatedList({',
      ),
      VDocApiMember(
        name: 'children',
        kind: 'field',
        signature: 'final List<Widget> children;',
      ),
      VDocApiMember(
        name: 'controller',
        kind: 'field',
        signature: 'final ScrollController? controller;',
      ),
      VDocApiMember(
        name: 'gap',
        kind: 'field',
        signature: 'final double gap;',
      ),
      VDocApiMember(
        name: 'motion',
        kind: 'field',
        signature: 'final VMotion? motion;',
      ),
      VDocApiMember(
        name: 'padding',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry? padding;',
      ),
      VDocApiMember(
        name: 'scrollDirection',
        kind: 'field',
        signature: 'final Axis scrollDirection;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VAnimatedList> createState() => _VAnimatedListState();',
      ),
    ],
  ),
  'VAnimatedScaleFade': VDocApiSymbol(
    name: 'VAnimatedScaleFade',
    kind: 'class',
    library: 'lib/src/widgets/animation/v_animated.dart',
    members: [
      VDocApiMember(
        name: 'VAnimatedScaleFade',
        kind: 'constructor',
        signature: 'const VAnimatedScaleFade({',
      ),
      VDocApiMember(
        name: 'alignment',
        kind: 'field',
        signature: 'final Alignment alignment;',
      ),
      VDocApiMember(
        name: 'beginScale',
        kind: 'field',
        signature: 'final double beginScale;',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'maintainState',
        kind: 'field',
        signature: 'final bool maintainState;',
      ),
      VDocApiMember(
        name: 'motion',
        kind: 'field',
        signature: 'final VMotionSpec? motion;',
      ),
      VDocApiMember(
        name: 'visible',
        kind: 'field',
        signature: 'final bool visible;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VAnimatedScaleFade> createState() => _VAnimatedScaleFadeState();',
      ),
    ],
  ),
  'VAnimatedSlideFade': VDocApiSymbol(
    name: 'VAnimatedSlideFade',
    kind: 'class',
    library: 'lib/src/widgets/animation/v_animated.dart',
    members: [
      VDocApiMember(
        name: 'VAnimatedSlideFade',
        kind: 'constructor',
        signature: 'const VAnimatedSlideFade({',
      ),
      VDocApiMember(
        name: 'beginOffset',
        kind: 'field',
        signature: 'final Offset beginOffset;',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'maintainState',
        kind: 'field',
        signature: 'final bool maintainState;',
      ),
      VDocApiMember(
        name: 'motion',
        kind: 'field',
        signature: 'final VMotionSpec? motion;',
      ),
      VDocApiMember(
        name: 'visible',
        kind: 'field',
        signature: 'final bool visible;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VAnimatedSlideFade> createState() => _VAnimatedSlideFadeState();',
      ),
    ],
  ),
  'VAnimatedSwitcher': VDocApiSymbol(
    name: 'VAnimatedSwitcher',
    kind: 'class',
    library: 'lib/src/widgets/animation/v_animated_switcher.dart',
    members: [
      VDocApiMember(
        name: 'VAnimatedSwitcher',
        kind: 'constructor',
        signature: 'const VAnimatedSwitcher({',
      ),
      VDocApiMember(
        name: 'children',
        kind: 'field',
        signature: 'final List<Widget> children;',
      ),
      VDocApiMember(
        name: 'controller',
        kind: 'field',
        signature: 'final VAnimatedSwitcherController controller;',
      ),
      VDocApiMember(
        name: 'enterTransition',
        kind: 'field',
        signature: 'final VTransitionBuilder? enterTransition;',
      ),
      VDocApiMember(
        name: 'exitTransition',
        kind: 'field',
        signature: 'final VTransitionBuilder? exitTransition;',
      ),
      VDocApiMember(
        name: 'motion',
        kind: 'field',
        signature: 'final VMotionSpec? motion;',
      ),
      VDocApiMember(
        name: 'transition',
        kind: 'field',
        signature: 'final VContentTransition? transition;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VAnimatedSwitcher> createState() => _VAnimatedSwitcherState();',
      ),
    ],
  ),
  'VAnimatedSwitcherController': VDocApiSymbol(
    name: 'VAnimatedSwitcherController',
    kind: 'class',
    library: 'lib/src/widgets/animation/v_animated_switcher.dart',
    members: [
      VDocApiMember(
        name: 'VAnimatedSwitcherController',
        kind: 'constructor',
        signature: 'VAnimatedSwitcherController({int initialIndex = 0, int count = 0})',
      ),
      VDocApiMember(
        name: 'count',
        kind: 'field',
        signature: 'int get count => _count;',
      ),
      VDocApiMember(
        name: 'index',
        kind: 'field',
        signature: 'int get index => _index;',
      ),
      VDocApiMember(
        name: 'isBackward',
        kind: 'field',
        signature: 'bool get isBackward => _index < _previousIndex;',
      ),
      VDocApiMember(
        name: 'isForward',
        kind: 'field',
        signature: 'bool get isForward => _index > _previousIndex;',
      ),
      VDocApiMember(
        name: 'previousIndex',
        kind: 'field',
        signature: 'int get previousIndex => _previousIndex;',
      ),
      VDocApiMember(
        name: 'jumpTo',
        kind: 'method',
        signature: 'void jumpTo(int i) {',
      ),
      VDocApiMember(
        name: 'next',
        kind: 'method',
        signature: 'void next() => jumpTo((_index + 1) % _count);',
      ),
      VDocApiMember(
        name: 'previous',
        kind: 'method',
        signature: 'void previous() => jumpTo((_index - 1 + _count) % _count);',
      ),
      VDocApiMember(
        name: 'updateCount',
        kind: 'method',
        signature: 'void updateCount(int newCount) {',
      ),
    ],
  ),
  'VAnimatedText': VDocApiSymbol(
    name: 'VAnimatedText',
    kind: 'class',
    library: 'lib/src/widgets/animation/animated_text/v_animated_text.dart',
    members: [
      VDocApiMember(
        name: 'VAnimatedText',
        kind: 'constructor',
        signature: 'const VAnimatedText(',
      ),
      VDocApiMember(
        name: 'color',
        kind: 'field',
        signature: 'final Color? color;',
      ),
      VDocApiMember(
        name: 'cursorChar',
        kind: 'field',
        signature: 'final String cursorChar;',
      ),
      VDocApiMember(
        name: 'cursorColor',
        kind: 'field',
        signature: 'final Color? cursorColor;',
      ),
      VDocApiMember(
        name: 'customEffect',
        kind: 'field',
        signature: 'final VAnimatedTextEffect? customEffect;',
      ),
      VDocApiMember(
        name: 'effect',
        kind: 'field',
        signature: 'final VTextAnimationEffect effect;',
      ),
      VDocApiMember(
        name: 'maxLines',
        kind: 'field',
        signature: 'final int? maxLines;',
      ),
      VDocApiMember(
        name: 'motion',
        kind: 'field',
        signature: 'final VMotionSpec? motion;',
      ),
      VDocApiMember(
        name: 'onComplete',
        kind: 'field',
        signature: 'final VoidCallback? onComplete;',
      ),
      VDocApiMember(
        name: 'overflow',
        kind: 'field',
        signature: 'final TextOverflow? overflow;',
      ),
      VDocApiMember(
        name: 'showCursor',
        kind: 'field',
        signature: 'final bool showCursor;',
      ),
      VDocApiMember(
        name: 'softWrap',
        kind: 'field',
        signature: 'final bool softWrap;',
      ),
      VDocApiMember(
        name: 'speed',
        kind: 'field',
        signature: 'final Duration speed;',
      ),
      VDocApiMember(
        name: 'text',
        kind: 'field',
        signature: 'final String text;',
      ),
      VDocApiMember(
        name: 'textAlign',
        kind: 'field',
        signature: 'final TextAlign? textAlign;',
      ),
      VDocApiMember(
        name: 'variant',
        kind: 'field',
        signature: 'final VTextVariant variant;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VAnimatedTextData': VDocApiSymbol(
    name: 'VAnimatedTextData',
    kind: 'class',
    library: 'lib/src/widgets/animation/animated_text/v_animated_text_data.dart',
    members: [
      VDocApiMember(
        name: 'VAnimatedTextData',
        kind: 'constructor',
        signature: 'const VAnimatedTextData({',
      ),
      VDocApiMember(
        name: 'cursorChar',
        kind: 'field',
        signature: 'final String cursorChar;',
      ),
      VDocApiMember(
        name: 'cursorColor',
        kind: 'field',
        signature: 'final Color? cursorColor;',
      ),
      VDocApiMember(
        name: 'maxLines',
        kind: 'field',
        signature: 'final int? maxLines;',
      ),
      VDocApiMember(
        name: 'motion',
        kind: 'field',
        signature: 'final VMotionSpec motion;',
      ),
      VDocApiMember(
        name: 'onComplete',
        kind: 'field',
        signature: 'final VoidCallback? onComplete;',
      ),
      VDocApiMember(
        name: 'overflow',
        kind: 'field',
        signature: 'final TextOverflow? overflow;',
      ),
      VDocApiMember(
        name: 'showCursor',
        kind: 'field',
        signature: 'final bool showCursor;',
      ),
      VDocApiMember(
        name: 'softWrap',
        kind: 'field',
        signature: 'final bool softWrap;',
      ),
      VDocApiMember(
        name: 'speed',
        kind: 'field',
        signature: 'final Duration speed;',
      ),
      VDocApiMember(
        name: 'style',
        kind: 'field',
        signature: 'final TextStyle style;',
      ),
      VDocApiMember(
        name: 'text',
        kind: 'field',
        signature: 'final String text;',
      ),
      VDocApiMember(
        name: 'textAlign',
        kind: 'field',
        signature: 'final TextAlign? textAlign;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VAnimatedTextData copyWith({',
      ),
    ],
  ),
  'VAnimatedTextEffect': VDocApiSymbol(
    name: 'VAnimatedTextEffect',
    kind: 'class',
    library: 'lib/src/widgets/animation/animated_text/effects/animated_text_effect.dart',
    members: [
      VDocApiMember(
        name: 'VAnimatedTextEffect',
        kind: 'constructor',
        signature: 'const VAnimatedTextEffect();',
      ),
      VDocApiMember(
        name: 'VAnimatedTextEffect.from',
        kind: 'constructor',
        signature: 'factory VAnimatedTextEffect.from(VTextAnimationEffect effect) =>',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context, VAnimatedTextData data);',
      ),
    ],
  ),
  'VAnimatedTheme': VDocApiSymbol(
    name: 'VAnimatedTheme',
    kind: 'class',
    library: 'lib/src/theme/v_animated_theme.dart',
    members: [
      VDocApiMember(
        name: 'VAnimatedTheme',
        kind: 'constructor',
        signature: 'const VAnimatedTheme({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'data',
        kind: 'field',
        signature: 'final VThemeData data;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'AnimatedWidgetBaseState<VAnimatedTheme> createState() =>',
      ),
    ],
  ),
  'VAnimatedVisibility': VDocApiSymbol(
    name: 'VAnimatedVisibility',
    kind: 'class',
    library: 'lib/src/widgets/animation/v_animated.dart',
    members: [
      VDocApiMember(
        name: 'VAnimatedVisibility',
        kind: 'constructor',
        signature: 'const VAnimatedVisibility({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'maintainState',
        kind: 'field',
        signature: 'final bool maintainState;',
      ),
      VDocApiMember(
        name: 'motion',
        kind: 'field',
        signature: 'final VMotionSpec? motion;',
      ),
      VDocApiMember(
        name: 'visible',
        kind: 'field',
        signature: 'final bool visible;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VAnimatedVisibility> createState() => _VAnimatedVisibilityState();',
      ),
    ],
  ),
  'VAppBar': VDocApiSymbol(
    name: 'VAppBar',
    kind: 'class',
    library: 'lib/src/widgets/layout/v_app_bar.dart',
    members: [
      VDocApiMember(
        name: 'VAppBar',
        kind: 'constructor',
        signature: 'const VAppBar({',
      ),
      VDocApiMember(
        name: 'actions',
        kind: 'field',
        signature: 'final List<Widget> actions;',
      ),
      VDocApiMember(
        name: 'backgroundColor',
        kind: 'field',
        signature: 'final Color? backgroundColor;',
      ),
      VDocApiMember(
        name: 'bottom',
        kind: 'field',
        signature: 'final Widget? bottom;',
      ),
      VDocApiMember(
        name: 'centerTitle',
        kind: 'field',
        signature: 'final bool? centerTitle;',
      ),
      VDocApiMember(
        name: 'foregroundColor',
        kind: 'field',
        signature: 'final Color? foregroundColor;',
      ),
      VDocApiMember(
        name: 'height',
        kind: 'field',
        signature: 'final double? height;',
      ),
      VDocApiMember(
        name: 'leading',
        kind: 'field',
        signature: 'final Widget? leading;',
      ),
      VDocApiMember(
        name: 'safeArea',
        kind: 'field',
        signature: 'final bool safeArea;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'subtitle',
        kind: 'field',
        signature: 'final Widget? subtitle;',
      ),
      VDocApiMember(
        name: 'title',
        kind: 'field',
        signature: 'final Widget? title;',
      ),
      VDocApiMember(
        name: 'variant',
        kind: 'field',
        signature: 'final VAppBarVariant variant;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'sliver',
        kind: 'method',
        signature: 'static Widget sliver({',
      ),
    ],
  ),
  'VAppBarTheme': VDocApiSymbol(
    name: 'VAppBarTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VAppBarTheme',
        kind: 'constructor',
        signature: 'const VAppBarTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VAppBarTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VAppBarTokens': VDocApiSymbol(
    name: 'VAppBarTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_app_bar_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VAppBarTokens',
        kind: 'constructor',
        signature: 'const VAppBarTokens({',
      ),
      VDocApiMember(
        name: 'VAppBarTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VAppBarTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'actionGap',
        kind: 'field',
        signature: 'final double actionGap;',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'field',
        signature: 'final Color background;',
      ),
      VDocApiMember(
        name: 'border',
        kind: 'field',
        signature: 'final Color border;',
      ),
      VDocApiMember(
        name: 'bottomSpacing',
        kind: 'field',
        signature: 'final double bottomSpacing;',
      ),
      VDocApiMember(
        name: 'elevatedShadow',
        kind: 'field',
        signature: 'final BoxShadow? elevatedShadow;',
      ),
      VDocApiMember(
        name: 'expandedHeight',
        kind: 'field',
        signature: 'final double expandedHeight;',
      ),
      VDocApiMember(
        name: 'foreground',
        kind: 'field',
        signature: 'final Color foreground;',
      ),
      VDocApiMember(
        name: 'height',
        kind: 'field',
        signature: 'final double height;',
      ),
      VDocApiMember(
        name: 'horizontalPadding',
        kind: 'field',
        signature: 'final double horizontalPadding;',
      ),
      VDocApiMember(
        name: 'leadingWidth',
        kind: 'field',
        signature: 'final double leadingWidth;',
      ),
      VDocApiMember(
        name: 'shadow',
        kind: 'field',
        signature: 'final BoxShadow? shadow;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VAppBarTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VAppBarTokens lerp(VAppBarTokens a, VAppBarTokens b, double t) {',
      ),
    ],
  ),
  'VAppBarVariant': VDocApiSymbol(
    name: 'VAppBarVariant',
    kind: 'enum',
    library: 'lib/src/widgets/layout/v_app_bar.dart',
    members: [
      VDocApiMember(
        name: 'flat',
        kind: 'value',
        signature: 'flat',
      ),
      VDocApiMember(
        name: 'elevated',
        kind: 'value',
        signature: 'elevated',
      ),
      VDocApiMember(
        name: 'transparent',
        kind: 'value',
        signature: 'transparent',
      ),
    ],
  ),
  'VAppearance': VDocApiSymbol(
    name: 'VAppearance',
    kind: 'class',
    library: 'lib/src/theme/v_appearance.dart',
    members: [
      VDocApiMember(
        name: 'VAppearance',
        kind: 'constructor',
        signature: 'const VAppearance();',
      ),
      VDocApiMember(
        name: 'clipBehavior',
        kind: 'field',
        signature: 'Clip get clipBehavior => Clip.antiAlias;',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'method',
        signature: 'Color background(Color base, Set<WidgetState> states) => base;',
      ),
      VDocApiMember(
        name: 'borderColor',
        kind: 'method',
        signature: 'Color borderColor(Color base, Set<WidgetState> states) => base;',
      ),
      VDocApiMember(
        name: 'borderWidth',
        kind: 'method',
        signature: 'double? borderWidth(double? base) => base;',
      ),
      VDocApiMember(
        name: 'foreground',
        kind: 'method',
        signature: 'Color foreground(Color base, Set<WidgetState> states, [Color? semantic]) =>',
      ),
      VDocApiMember(
        name: 'gradient',
        kind: 'method',
        signature: 'Gradient? gradient(Color base, Set<WidgetState> states) => null;',
      ),
      VDocApiMember(
        name: 'innerShadows',
        kind: 'method',
        signature: 'List<BoxShadow> innerShadows(',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'method',
        signature: 'double radius(double base) => base;',
      ),
      VDocApiMember(
        name: 'shadows',
        kind: 'method',
        signature: 'List<BoxShadow> shadows(List<BoxShadow> base) => base;',
      ),
      VDocApiMember(
        name: 'wrap',
        kind: 'method',
        signature: 'Widget wrap(',
      ),
    ],
  ),
  'VAppearanceScope': VDocApiSymbol(
    name: 'VAppearanceScope',
    kind: 'class',
    library: 'lib/src/theme/v_appearance_scope.dart',
    members: [
      VDocApiMember(
        name: 'VAppearanceScope',
        kind: 'constructor',
        signature: 'const VAppearanceScope({',
      ),
      VDocApiMember(
        name: 'appearance',
        kind: 'field',
        signature: 'final VAppearance appearance;',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VAppearance? of(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'updateShouldNotify',
        kind: 'method',
        signature: 'bool updateShouldNotify(VAppearanceScope oldWidget) =>',
      ),
    ],
  ),
  'VAssetImageSource': VDocApiSymbol(
    name: 'VAssetImageSource',
    kind: 'class',
    library: 'lib/src/widgets/media/v_image_source.dart',
    members: [
      VDocApiMember(
        name: 'VAssetImageSource',
        kind: 'constructor',
        signature: 'const VAssetImageSource(',
      ),
      VDocApiMember(
        name: 'bundle',
        kind: 'field',
        signature: 'final AssetBundle? bundle;',
      ),
      VDocApiMember(
        name: 'name',
        kind: 'field',
        signature: 'final String name;',
      ),
      VDocApiMember(
        name: 'package',
        kind: 'field',
        signature: 'final String? package;',
      ),
      VDocApiMember(
        name: 'resolve',
        kind: 'method',
        signature: 'ImageProvider<Object> resolve(BuildContext context) {',
      ),
    ],
  ),
  'VAutoSuggestAsyncBuilder': VDocApiSymbol(
    name: 'VAutoSuggestAsyncBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/forms/v_auto_suggest_box.dart',
    members: [
      VDocApiMember(
        name: 'VAutoSuggestAsyncBuilder',
        kind: 'typedef',
        signature: 'typedef VAutoSuggestAsyncBuilder = Future<List<VAutoSuggestItem>?> Function(',
      ),
    ],
  ),
  'VAutoSuggestBox': VDocApiSymbol(
    name: 'VAutoSuggestBox',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_auto_suggest_box.dart',
    members: [
      VDocApiMember(
        name: 'VAutoSuggestBox',
        kind: 'constructor',
        signature: 'const VAutoSuggestBox({',
      ),
      VDocApiMember(
        name: 'asyncSuggestionsBuilder',
        kind: 'field',
        signature: 'final VAutoSuggestAsyncBuilder? asyncSuggestionsBuilder;',
      ),
      VDocApiMember(
        name: 'controller',
        kind: 'field',
        signature: 'final TextEditingController? controller;',
      ),
      VDocApiMember(
        name: 'debounceDuration',
        kind: 'field',
        signature: 'final Duration debounceDuration;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'errorText',
        kind: 'field',
        signature: 'final String? errorText;',
      ),
      VDocApiMember(
        name: 'focusNode',
        kind: 'field',
        signature: 'final FocusNode? focusNode;',
      ),
      VDocApiMember(
        name: 'highlightMatch',
        kind: 'field',
        signature: 'final bool highlightMatch;',
      ),
      VDocApiMember(
        name: 'hint',
        kind: 'field',
        signature: 'final String? hint;',
      ),
      VDocApiMember(
        name: 'keyboardType',
        kind: 'field',
        signature: 'final TextInputType? keyboardType;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String? label;',
      ),
      VDocApiMember(
        name: 'leading',
        kind: 'field',
        signature: 'final Widget? leading;',
      ),
      VDocApiMember(
        name: 'maxDropdownHeight',
        kind: 'field',
        signature: 'final double maxDropdownHeight;',
      ),
      VDocApiMember(
        name: 'maxSuggestions',
        kind: 'field',
        signature: 'final int maxSuggestions;',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<String>? onChanged;',
      ),
      VDocApiMember(
        name: 'onSelected',
        kind: 'field',
        signature: 'final ValueChanged<VAutoSuggestItem>? onSelected;',
      ),
      VDocApiMember(
        name: 'onSubmitted',
        kind: 'field',
        signature: 'final ValueChanged<String>? onSubmitted;',
      ),
      VDocApiMember(
        name: 'placement',
        kind: 'field',
        signature: 'final VAnchoredOverlayPlacement placement;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'suggestionsBuilder',
        kind: 'field',
        signature: 'final VAutoSuggestBuilder? suggestionsBuilder;',
      ),
      VDocApiMember(
        name: 'textInputAction',
        kind: 'field',
        signature: 'final TextInputAction? textInputAction;',
      ),
      VDocApiMember(
        name: 'trailing',
        kind: 'field',
        signature: 'final Widget? trailing;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VAutoSuggestBox> createState() => _VAutoSuggestBoxState();',
      ),
    ],
  ),
  'VAutoSuggestBuilder': VDocApiSymbol(
    name: 'VAutoSuggestBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/forms/v_auto_suggest_box.dart',
    members: [
      VDocApiMember(
        name: 'VAutoSuggestBuilder',
        kind: 'typedef',
        signature: 'typedef VAutoSuggestBuilder = List<VAutoSuggestItem> Function(String query);',
      ),
    ],
  ),
  'VAutoSuggestItem': VDocApiSymbol(
    name: 'VAutoSuggestItem',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_auto_suggest_box.dart',
    members: [
      VDocApiMember(
        name: 'VAutoSuggestItem',
        kind: 'constructor',
        signature: 'const VAutoSuggestItem({',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String label;',
      ),
      VDocApiMember(
        name: 'leading',
        kind: 'field',
        signature: 'final Widget? leading;',
      ),
      VDocApiMember(
        name: 'subtitle',
        kind: 'field',
        signature: 'final String? subtitle;',
      ),
      VDocApiMember(
        name: 'value',
        kind: 'field',
        signature: 'final String value;',
      ),
    ],
  ),
  'VAutoSuggestTokens': VDocApiSymbol(
    name: 'VAutoSuggestTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_auto_suggest_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VAutoSuggestTokens',
        kind: 'constructor',
        signature: 'const VAutoSuggestTokens({',
      ),
      VDocApiMember(
        name: 'VAutoSuggestTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VAutoSuggestTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'itemDisabledText',
        kind: 'field',
        signature: 'final Color itemDisabledText;',
      ),
      VDocApiMember(
        name: 'itemHeight',
        kind: 'field',
        signature: 'final double itemHeight;',
      ),
      VDocApiMember(
        name: 'itemHover',
        kind: 'field',
        signature: 'final Color itemHover;',
      ),
      VDocApiMember(
        name: 'itemPaddingHorizontal',
        kind: 'field',
        signature: 'final double itemPaddingHorizontal;',
      ),
      VDocApiMember(
        name: 'itemPaddingVertical',
        kind: 'field',
        signature: 'final double itemPaddingVertical;',
      ),
      VDocApiMember(
        name: 'itemSelected',
        kind: 'field',
        signature: 'final Color itemSelected;',
      ),
      VDocApiMember(
        name: 'itemSelectedText',
        kind: 'field',
        signature: 'final Color itemSelectedText;',
      ),
      VDocApiMember(
        name: 'itemSubtitleHeight',
        kind: 'field',
        signature: 'final double itemSubtitleHeight;',
      ),
      VDocApiMember(
        name: 'itemText',
        kind: 'field',
        signature: 'final Color itemText;',
      ),
      VDocApiMember(
        name: 'matchHighlight',
        kind: 'field',
        signature: 'final Color matchHighlight;',
      ),
      VDocApiMember(
        name: 'panelBackground',
        kind: 'field',
        signature: 'final Color panelBackground;',
      ),
      VDocApiMember(
        name: 'panelBorder',
        kind: 'field',
        signature: 'final Color panelBorder;',
      ),
      VDocApiMember(
        name: 'panelRadius',
        kind: 'field',
        signature: 'final double panelRadius;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VAutoSuggestTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VAutoSuggestTokens lerp(',
      ),
    ],
  ),
  'VAvatar': VDocApiSymbol(
    name: 'VAvatar',
    kind: 'class',
    library: 'lib/src/widgets/basic/v_avatar.dart',
    members: [
      VDocApiMember(
        name: 'VAvatar',
        kind: 'constructor',
        signature: 'const VAvatar({',
      ),
      VDocApiMember(
        name: 'avatarSize',
        kind: 'field',
        signature: 'final VControlSize? avatarSize;',
      ),
      VDocApiMember(
        name: 'backgroundColor',
        kind: 'field',
        signature: 'final Color? backgroundColor;',
      ),
      VDocApiMember(
        name: 'foregroundColor',
        kind: 'field',
        signature: 'final Color? foregroundColor;',
      ),
      VDocApiMember(
        name: 'name',
        kind: 'field',
        signature: 'final String? name;',
      ),
      VDocApiMember(
        name: 'size',
        kind: 'field',
        signature: 'final double size;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VBackGestureDetector': VDocApiSymbol(
    name: 'VBackGestureDetector',
    kind: 'class',
    library: 'lib/src/app/v_page_route_back_gesture.dart',
    members: [
      VDocApiMember(
        name: 'VBackGestureDetector',
        kind: 'constructor',
        signature: 'const VBackGestureDetector({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VBackGestureDetector> createState() => _VBackGestureDetectorState();',
      ),
    ],
  ),
  'VBackGestureScope': VDocApiSymbol(
    name: 'VBackGestureScope',
    kind: 'class',
    library: 'lib/src/app/v_page_route_back_gesture.dart',
    members: [
      VDocApiMember(
        name: 'VBackGestureScope',
        kind: 'constructor',
        signature: 'const VBackGestureScope({',
      ),
      VDocApiMember(
        name: 'controller',
        kind: 'field',
        signature: 'final AnimationController? controller;',
      ),
      VDocApiMember(
        name: 'isGestureEnabled',
        kind: 'field',
        signature: 'final bool isGestureEnabled;',
      ),
      VDocApiMember(
        name: 'onCommitPop',
        kind: 'field',
        signature: 'final VoidCallback onCommitPop;',
      ),
      VDocApiMember(
        name: 'maybeOf',
        kind: 'method',
        signature: 'static VBackGestureScope? maybeOf(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VBackGestureScope of(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'updateShouldNotify',
        kind: 'method',
        signature: 'bool updateShouldNotify(VBackGestureScope oldWidget) =>',
      ),
    ],
  ),
  'VBackground': VDocApiSymbol(
    name: 'VBackground',
    kind: 'class',
    library: 'lib/src/foundation/background.dart',
    members: [
      VDocApiMember(
        name: 'VBackground.color',
        kind: 'constructor',
        signature: 'const VBackground.color(Color color) : this._(color: color);',
      ),
      VDocApiMember(
        name: 'VBackground.gradient',
        kind: 'constructor',
        signature: 'const VBackground.gradient(Gradient gradient) : this._(gradient: gradient);',
      ),
      VDocApiMember(
        name: 'color',
        kind: 'field',
        signature: 'final Color? color;',
      ),
      VDocApiMember(
        name: 'gradient',
        kind: 'field',
        signature: 'final Gradient? gradient;',
      ),
      VDocApiMember(
        name: 'hashCode',
        kind: 'method',
        signature: 'int get hashCode => Object.hash(color, gradient);',
      ),
      VDocApiMember(
        name: 'operator',
        kind: 'method',
        signature: 'bool operator ==(Object other) {',
      ),
      VDocApiMember(
        name: 'toString',
        kind: 'method',
        signature: 'String toString() => \'VBackground(\${color ?? gradient})\';',
      ),
    ],
  ),
  'VBadge': VDocApiSymbol(
    name: 'VBadge',
    kind: 'class',
    library: 'lib/src/widgets/basic/v_badge.dart',
    members: [
      VDocApiMember(
        name: 'VBadge',
        kind: 'constructor',
        signature: 'const VBadge({',
      ),
      VDocApiMember(
        name: 'backgroundColor',
        kind: 'field',
        signature: 'final Color? backgroundColor;',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'count',
        kind: 'field',
        signature: 'final int? count;',
      ),
      VDocApiMember(
        name: 'foregroundColor',
        kind: 'field',
        signature: 'final Color? foregroundColor;',
      ),
      VDocApiMember(
        name: 'showDot',
        kind: 'field',
        signature: 'final bool showDot;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VBorderStyle': VDocApiSymbol(
    name: 'VBorderStyle',
    kind: 'enum',
    library: 'lib/src/widgets/basic/v_surface.dart',
    members: [
      VDocApiMember(
        name: 'solid',
        kind: 'value',
        signature: 'solid',
      ),
      VDocApiMember(
        name: 'dotted',
        kind: 'value',
        signature: 'dotted',
      ),
    ],
  ),
  'VBox': VDocApiSymbol(
    name: 'VBox',
    kind: 'class',
    library: 'lib/src/widgets/basic/v_box.dart',
    members: [
      VDocApiMember(
        name: 'VBox',
        kind: 'constructor',
        signature: 'const VBox({',
      ),
      VDocApiMember(
        name: 'border',
        kind: 'field',
        signature: 'final BoxBorder? border;',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'color',
        kind: 'field',
        signature: 'final Color? color;',
      ),
      VDocApiMember(
        name: 'height',
        kind: 'field',
        signature: 'final double? height;',
      ),
      VDocApiMember(
        name: 'margin',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry? margin;',
      ),
      VDocApiMember(
        name: 'padding',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry? padding;',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'field',
        signature: 'final double? radius;',
      ),
      VDocApiMember(
        name: 'width',
        kind: 'field',
        signature: 'final double? width;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VBreakpoint': VDocApiSymbol(
    name: 'VBreakpoint',
    kind: 'enum',
    library: 'lib/src/foundation/responsive.dart',
    members: [
      VDocApiMember(
        name: 'xs',
        kind: 'value',
        signature: 'xs',
      ),
      VDocApiMember(
        name: 'sm',
        kind: 'value',
        signature: 'sm',
      ),
      VDocApiMember(
        name: 'md',
        kind: 'value',
        signature: 'md',
      ),
      VDocApiMember(
        name: 'lg',
        kind: 'value',
        signature: 'lg',
      ),
      VDocApiMember(
        name: 'xl',
        kind: 'value',
        signature: 'xl',
      ),
      VDocApiMember(
        name: 'xxl',
        kind: 'value',
        signature: 'xxl',
      ),
    ],
  ),
  'VBreakpointValues': VDocApiSymbol(
    name: 'VBreakpointValues',
    kind: 'class',
    library: 'lib/src/foundation/responsive.dart',
    members: [
      VDocApiMember(
        name: 'VBreakpointValues',
        kind: 'constructor',
        signature: 'const VBreakpointValues({',
      ),
      VDocApiMember(
        name: 'lg',
        kind: 'field',
        signature: 'final double lg;',
      ),
      VDocApiMember(
        name: 'md',
        kind: 'field',
        signature: 'final double md;',
      ),
      VDocApiMember(
        name: 'sm',
        kind: 'field',
        signature: 'final double sm;',
      ),
      VDocApiMember(
        name: 'xl',
        kind: 'field',
        signature: 'final double xl;',
      ),
      VDocApiMember(
        name: 'xxl',
        kind: 'field',
        signature: 'final double xxl;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VBreakpointValues copyWith({',
      ),
      VDocApiMember(
        name: 'debugFillProperties',
        kind: 'method',
        signature: 'void debugFillProperties(DiagnosticPropertiesBuilder properties) {',
      ),
      VDocApiMember(
        name: 'hashCode',
        kind: 'method',
        signature: 'int get hashCode => _\$VBreakpointValuesHash(this);',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VBreakpointValues lerp(',
      ),
      VDocApiMember(
        name: 'operator',
        kind: 'method',
        signature: 'bool operator ==(Object other) => _\$VBreakpointValuesEq(this, other);',
      ),
      VDocApiMember(
        name: 'resolve',
        kind: 'method',
        signature: 'VBreakpoint resolve(double width) {',
      ),
    ],
  ),
  'VButton': VDocApiSymbol(
    name: 'VButton',
    kind: 'class',
    library: 'lib/src/widgets/buttons/v_button.dart',
    members: [
      VDocApiMember(
        name: 'VButton',
        kind: 'constructor',
        signature: 'const VButton({',
      ),
      VDocApiMember(
        name: 'appearance',
        kind: 'field',
        signature: 'final VAppearance? appearance;',
      ),
      VDocApiMember(
        name: 'autofocus',
        kind: 'field',
        signature: 'final bool autofocus;',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'focusNode',
        kind: 'field',
        signature: 'final FocusNode? focusNode;',
      ),
      VDocApiMember(
        name: 'iconGap',
        kind: 'field',
        signature: 'final double? iconGap;',
      ),
      VDocApiMember(
        name: 'leadingIcon',
        kind: 'field',
        signature: 'final Widget? leadingIcon;',
      ),
      VDocApiMember(
        name: 'loading',
        kind: 'field',
        signature: 'final bool loading;',
      ),
      VDocApiMember(
        name: 'loadingIndicator',
        kind: 'field',
        signature: 'final Widget? loadingIndicator;',
      ),
      VDocApiMember(
        name: 'loadingSemanticLabel',
        kind: 'field',
        signature: 'final String? loadingSemanticLabel;',
      ),
      VDocApiMember(
        name: 'onPressed',
        kind: 'field',
        signature: 'final VoidCallback? onPressed;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'shape',
        kind: 'field',
        signature: 'final VButtonShape shape;',
      ),
      VDocApiMember(
        name: 'size',
        kind: 'field',
        signature: 'final VControlSize size;',
      ),
      VDocApiMember(
        name: 'trailingIcon',
        kind: 'field',
        signature: 'final Widget? trailingIcon;',
      ),
      VDocApiMember(
        name: 'variant',
        kind: 'field',
        signature: 'final VButtonVariant variant;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VButtonShape': VDocApiSymbol(
    name: 'VButtonShape',
    kind: 'enum',
    library: 'lib/src/widgets/buttons/v_button.dart',
    members: [
      VDocApiMember(
        name: 'rounded',
        kind: 'value',
        signature: 'rounded',
      ),
      VDocApiMember(
        name: 'circle',
        kind: 'value',
        signature: 'circle',
      ),
      VDocApiMember(
        name: 'none',
        kind: 'value',
        signature: 'none',
      ),
    ],
  ),
  'VButtonTheme': VDocApiSymbol(
    name: 'VButtonTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VButtonTheme',
        kind: 'constructor',
        signature: 'const VButtonTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VButtonTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VButtonTokens': VDocApiSymbol(
    name: 'VButtonTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_button_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VButtonTokens',
        kind: 'constructor',
        signature: 'const VButtonTokens({',
      ),
      VDocApiMember(
        name: 'VButtonTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VButtonTokens.fromColors(VColors colors) =>',
      ),
      VDocApiMember(
        name: 'VButtonTokens.fromTheme',
        kind: 'constructor',
        signature: 'VButtonTokens.fromTheme(colors, VSizes.defaults(), VRadii.defaults());',
      ),
      VDocApiMember(
        name: 'dangerBackground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> dangerBackground;',
      ),
      VDocApiMember(
        name: 'dangerBorder',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> dangerBorder;',
      ),
      VDocApiMember(
        name: 'dangerForeground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> dangerForeground;',
      ),
      VDocApiMember(
        name: 'focusRing',
        kind: 'field',
        signature: 'final Color focusRing;',
      ),
      VDocApiMember(
        name: 'heightLg',
        kind: 'field',
        signature: 'final double heightLg;',
      ),
      VDocApiMember(
        name: 'heightMd',
        kind: 'field',
        signature: 'final double heightMd;',
      ),
      VDocApiMember(
        name: 'heightSm',
        kind: 'field',
        signature: 'final double heightSm;',
      ),
      VDocApiMember(
        name: 'iconSizeLg',
        kind: 'field',
        signature: 'final double iconSizeLg;',
      ),
      VDocApiMember(
        name: 'iconSizeMd',
        kind: 'field',
        signature: 'final double iconSizeMd;',
      ),
      VDocApiMember(
        name: 'iconSizeSm',
        kind: 'field',
        signature: 'final double iconSizeSm;',
      ),
      VDocApiMember(
        name: 'paddingHorizontalLg',
        kind: 'field',
        signature: 'final double paddingHorizontalLg;',
      ),
      VDocApiMember(
        name: 'paddingHorizontalMd',
        kind: 'field',
        signature: 'final double paddingHorizontalMd;',
      ),
      VDocApiMember(
        name: 'paddingHorizontalSm',
        kind: 'field',
        signature: 'final double paddingHorizontalSm;',
      ),
      VDocApiMember(
        name: 'paddingVerticalLg',
        kind: 'field',
        signature: 'final double paddingVerticalLg;',
      ),
      VDocApiMember(
        name: 'paddingVerticalMd',
        kind: 'field',
        signature: 'final double paddingVerticalMd;',
      ),
      VDocApiMember(
        name: 'paddingVerticalSm',
        kind: 'field',
        signature: 'final double paddingVerticalSm;',
      ),
      VDocApiMember(
        name: 'primaryBackground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> primaryBackground;',
      ),
      VDocApiMember(
        name: 'primaryBorder',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> primaryBorder;',
      ),
      VDocApiMember(
        name: 'primaryForeground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> primaryForeground;',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'field',
        signature: 'final double radius;',
      ),
      VDocApiMember(
        name: 'secondaryBackground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> secondaryBackground;',
      ),
      VDocApiMember(
        name: 'secondaryBorder',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> secondaryBorder;',
      ),
      VDocApiMember(
        name: 'secondaryForeground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> secondaryForeground;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VButtonTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VButtonTokens lerp(VButtonTokens a, VButtonTokens b, double t) {',
      ),
    ],
  ),
  'VButtonTokensOverride': VDocApiSymbol(
    name: 'VButtonTokensOverride',
    kind: 'typedef',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VButtonTokensOverride',
        kind: 'typedef',
        signature: 'typedef VButtonTokensOverride = VScopedTokenOverride<VButtonTokens>;',
      ),
    ],
  ),
  'VButtonVariant': VDocApiSymbol(
    name: 'VButtonVariant',
    kind: 'enum',
    library: 'lib/src/widgets/buttons/v_button.dart',
    members: [
      VDocApiMember(
        name: 'primary',
        kind: 'value',
        signature: 'primary',
      ),
      VDocApiMember(
        name: 'secondary',
        kind: 'value',
        signature: 'secondary',
      ),
      VDocApiMember(
        name: 'danger',
        kind: 'value',
        signature: 'danger',
      ),
    ],
  ),
  'VCarousel': VDocApiSymbol(
    name: 'VCarousel',
    kind: 'class',
    library: 'lib/src/widgets/data/v_carousel.dart',
    members: [
      VDocApiMember(
        name: 'VCarousel',
        kind: 'constructor',
        signature: 'const VCarousel({',
      ),
      VDocApiMember(
        name: 'autoPlay',
        kind: 'field',
        signature: 'final bool autoPlay;',
      ),
      VDocApiMember(
        name: 'children',
        kind: 'field',
        signature: 'final List<Widget> children;',
      ),
      VDocApiMember(
        name: 'height',
        kind: 'field',
        signature: 'final double height;',
      ),
      VDocApiMember(
        name: 'interval',
        kind: 'field',
        signature: 'final Duration interval;',
      ),
      VDocApiMember(
        name: 'onPageChanged',
        kind: 'field',
        signature: 'final ValueChanged<int>? onPageChanged;',
      ),
      VDocApiMember(
        name: 'showDots',
        kind: 'field',
        signature: 'final bool showDots;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VCarousel> createState() => _VCarouselState();',
      ),
    ],
  ),
  'VCheckbox': VDocApiSymbol(
    name: 'VCheckbox',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_checkbox.dart',
    members: [
      VDocApiMember(
        name: 'VCheckbox',
        kind: 'constructor',
        signature: 'const VCheckbox({',
      ),
      VDocApiMember(
        name: 'autofocus',
        kind: 'field',
        signature: 'final bool autofocus;',
      ),
      VDocApiMember(
        name: 'checked',
        kind: 'field',
        signature: 'final bool? checked;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'focusNode',
        kind: 'field',
        signature: 'final FocusNode? focusNode;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String? label;',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<bool?>? onChanged;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'tristate',
        kind: 'field',
        signature: 'final bool tristate;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VCheckboxTheme': VDocApiSymbol(
    name: 'VCheckboxTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VCheckboxTheme',
        kind: 'constructor',
        signature: 'const VCheckboxTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VCheckboxTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VCheckboxTokens': VDocApiSymbol(
    name: 'VCheckboxTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_checkbox_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VCheckboxTokens',
        kind: 'constructor',
        signature: 'const VCheckboxTokens({',
      ),
      VDocApiMember(
        name: 'VCheckboxTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VCheckboxTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'checkedBackground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> checkedBackground;',
      ),
      VDocApiMember(
        name: 'checkedBorder',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> checkedBorder;',
      ),
      VDocApiMember(
        name: 'checkmark',
        kind: 'field',
        signature: 'final Color checkmark;',
      ),
      VDocApiMember(
        name: 'focusRing',
        kind: 'field',
        signature: 'final Color focusRing;',
      ),
      VDocApiMember(
        name: 'uncheckedBackground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> uncheckedBackground;',
      ),
      VDocApiMember(
        name: 'uncheckedBorder',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> uncheckedBorder;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VCheckboxTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VCheckboxTokens lerp(VCheckboxTokens a, VCheckboxTokens b, double t) {',
      ),
    ],
  ),
  'VChip': VDocApiSymbol(
    name: 'VChip',
    kind: 'class',
    library: 'lib/src/widgets/buttons/v_chip.dart',
    members: [
      VDocApiMember(
        name: 'VChip',
        kind: 'constructor',
        signature: 'const VChip({',
      ),
      VDocApiMember(
        name: 'autofocus',
        kind: 'field',
        signature: 'final bool autofocus;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'focusNode',
        kind: 'field',
        signature: 'final FocusNode? focusNode;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final Widget label;',
      ),
      VDocApiMember(
        name: 'leading',
        kind: 'field',
        signature: 'final Widget? leading;',
      ),
      VDocApiMember(
        name: 'onDeleted',
        kind: 'field',
        signature: 'final VoidCallback? onDeleted;',
      ),
      VDocApiMember(
        name: 'onPressed',
        kind: 'field',
        signature: 'final VoidCallback? onPressed;',
      ),
      VDocApiMember(
        name: 'selected',
        kind: 'field',
        signature: 'final bool selected;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'size',
        kind: 'field',
        signature: 'final VControlSize size;',
      ),
      VDocApiMember(
        name: 'trailing',
        kind: 'field',
        signature: 'final Widget? trailing;',
      ),
      VDocApiMember(
        name: 'variant',
        kind: 'field',
        signature: 'final VChipVariant variant;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VChipTheme': VDocApiSymbol(
    name: 'VChipTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VChipTheme',
        kind: 'constructor',
        signature: 'const VChipTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VChipTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VChipTokens': VDocApiSymbol(
    name: 'VChipTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_chip_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VChipTokens',
        kind: 'constructor',
        signature: 'const VChipTokens({',
      ),
      VDocApiMember(
        name: 'VChipTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VChipTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> background;',
      ),
      VDocApiMember(
        name: 'border',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> border;',
      ),
      VDocApiMember(
        name: 'focusRing',
        kind: 'field',
        signature: 'final Color focusRing;',
      ),
      VDocApiMember(
        name: 'foreground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> foreground;',
      ),
      VDocApiMember(
        name: 'gap',
        kind: 'field',
        signature: 'final double gap;',
      ),
      VDocApiMember(
        name: 'heightLg',
        kind: 'field',
        signature: 'final double heightLg;',
      ),
      VDocApiMember(
        name: 'heightMd',
        kind: 'field',
        signature: 'final double heightMd;',
      ),
      VDocApiMember(
        name: 'heightSm',
        kind: 'field',
        signature: 'final double heightSm;',
      ),
      VDocApiMember(
        name: 'iconSizeLg',
        kind: 'field',
        signature: 'final double iconSizeLg;',
      ),
      VDocApiMember(
        name: 'iconSizeMd',
        kind: 'field',
        signature: 'final double iconSizeMd;',
      ),
      VDocApiMember(
        name: 'iconSizeSm',
        kind: 'field',
        signature: 'final double iconSizeSm;',
      ),
      VDocApiMember(
        name: 'paddingHorizontalLg',
        kind: 'field',
        signature: 'final double paddingHorizontalLg;',
      ),
      VDocApiMember(
        name: 'paddingHorizontalMd',
        kind: 'field',
        signature: 'final double paddingHorizontalMd;',
      ),
      VDocApiMember(
        name: 'paddingHorizontalSm',
        kind: 'field',
        signature: 'final double paddingHorizontalSm;',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'field',
        signature: 'final double radius;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VChipTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VChipTokens lerp(VChipTokens a, VChipTokens b, double t) {',
      ),
    ],
  ),
  'VChipVariant': VDocApiSymbol(
    name: 'VChipVariant',
    kind: 'enum',
    library: 'lib/src/widgets/buttons/v_chip.dart',
    members: [
      VDocApiMember(
        name: 'filled',
        kind: 'value',
        signature: 'filled',
      ),
      VDocApiMember(
        name: 'soft',
        kind: 'value',
        signature: 'soft',
      ),
      VDocApiMember(
        name: 'outlined',
        kind: 'value',
        signature: 'outlined',
      ),
    ],
  ),
  'VCollapsible': VDocApiSymbol(
    name: 'VCollapsible',
    kind: 'class',
    library: 'lib/src/widgets/layout/v_accordion.dart',
    members: [
      VDocApiMember(
        name: 'VCollapsible',
        kind: 'constructor',
        signature: 'const VCollapsible({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'expanded',
        kind: 'field',
        signature: 'final bool? expanded;',
      ),
      VDocApiMember(
        name: 'header',
        kind: 'field',
        signature: 'final Widget header;',
      ),
      VDocApiMember(
        name: 'indicatorAtStart',
        kind: 'field',
        signature: 'final bool indicatorAtStart;',
      ),
      VDocApiMember(
        name: 'indicatorColor',
        kind: 'field',
        signature: 'final Color? indicatorColor;',
      ),
      VDocApiMember(
        name: 'initiallyExpanded',
        kind: 'field',
        signature: 'final bool initiallyExpanded;',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<bool>? onChanged;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VCollapsible> createState() => _VCollapsibleState();',
      ),
    ],
  ),
  'VColors': VDocApiSymbol(
    name: 'VColors',
    kind: 'class',
    library: 'lib/src/foundation/semantic_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VColors',
        kind: 'constructor',
        signature: 'const VColors({',
      ),
      VDocApiMember(
        name: 'VColors.dark',
        kind: 'constructor',
        signature: 'factory VColors.dark() {',
      ),
      VDocApiMember(
        name: 'VColors.light',
        kind: 'constructor',
        signature: 'factory VColors.light() {',
      ),
      VDocApiMember(
        name: 'actionPrimary',
        kind: 'field',
        signature: 'final Color actionPrimary;',
      ),
      VDocApiMember(
        name: 'actionPrimaryHover',
        kind: 'field',
        signature: 'final Color actionPrimaryHover;',
      ),
      VDocApiMember(
        name: 'actionPrimaryPressed',
        kind: 'field',
        signature: 'final Color actionPrimaryPressed;',
      ),
      VDocApiMember(
        name: 'actionPrimaryText',
        kind: 'field',
        signature: 'final Color actionPrimaryText;',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'field',
        signature: 'final Color background;',
      ),
      VDocApiMember(
        name: 'border',
        kind: 'field',
        signature: 'final Color border;',
      ),
      VDocApiMember(
        name: 'borderStrong',
        kind: 'field',
        signature: 'final Color borderStrong;',
      ),
      VDocApiMember(
        name: 'danger',
        kind: 'field',
        signature: 'final Color danger;',
      ),
      VDocApiMember(
        name: 'dangerHover',
        kind: 'field',
        signature: 'final Color dangerHover;',
      ),
      VDocApiMember(
        name: 'dangerSurface',
        kind: 'field',
        signature: 'final Color dangerSurface;',
      ),
      VDocApiMember(
        name: 'focusRing',
        kind: 'field',
        signature: 'final Color focusRing;',
      ),
      VDocApiMember(
        name: 'scrim',
        kind: 'field',
        signature: 'final Color scrim;',
      ),
      VDocApiMember(
        name: 'success',
        kind: 'field',
        signature: 'final Color success;',
      ),
      VDocApiMember(
        name: 'successHover',
        kind: 'field',
        signature: 'final Color successHover;',
      ),
      VDocApiMember(
        name: 'successSurface',
        kind: 'field',
        signature: 'final Color successSurface;',
      ),
      VDocApiMember(
        name: 'surface',
        kind: 'field',
        signature: 'final Color surface;',
      ),
      VDocApiMember(
        name: 'surfaceElevated',
        kind: 'field',
        signature: 'final Color surfaceElevated;',
      ),
      VDocApiMember(
        name: 'surfaceHover',
        kind: 'field',
        signature: 'final Color surfaceHover;',
      ),
      VDocApiMember(
        name: 'surfaceLevel0',
        kind: 'field',
        signature: 'final Color surfaceLevel0;',
      ),
      VDocApiMember(
        name: 'surfaceLevel1',
        kind: 'field',
        signature: 'final Color surfaceLevel1;',
      ),
      VDocApiMember(
        name: 'surfaceLevel2',
        kind: 'field',
        signature: 'final Color surfaceLevel2;',
      ),
      VDocApiMember(
        name: 'surfaceLevel3',
        kind: 'field',
        signature: 'final Color surfaceLevel3;',
      ),
      VDocApiMember(
        name: 'surfaceLevel4',
        kind: 'field',
        signature: 'final Color surfaceLevel4;',
      ),
      VDocApiMember(
        name: 'text',
        kind: 'field',
        signature: 'final Color text;',
      ),
      VDocApiMember(
        name: 'textDisabled',
        kind: 'field',
        signature: 'final Color textDisabled;',
      ),
      VDocApiMember(
        name: 'textMuted',
        kind: 'field',
        signature: 'final Color textMuted;',
      ),
      VDocApiMember(
        name: 'warning',
        kind: 'field',
        signature: 'final Color warning;',
      ),
      VDocApiMember(
        name: 'warningHover',
        kind: 'field',
        signature: 'final Color warningHover;',
      ),
      VDocApiMember(
        name: 'warningSurface',
        kind: 'field',
        signature: 'final Color warningSurface;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VColors copyWith({',
      ),
      VDocApiMember(
        name: 'debugFillProperties',
        kind: 'method',
        signature: 'void debugFillProperties(DiagnosticPropertiesBuilder properties) {',
      ),
      VDocApiMember(
        name: 'hashCode',
        kind: 'method',
        signature: 'int get hashCode => _\$VColorsHash(this);',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VColors lerp(VColors a, VColors b, double t) =>',
      ),
      VDocApiMember(
        name: 'operator',
        kind: 'method',
        signature: 'bool operator ==(Object other) => _\$VColorsEq(this, other);',
      ),
      VDocApiMember(
        name: 'surfaceColor',
        kind: 'method',
        signature: 'Color surfaceColor(VElevation elevation) {',
      ),
    ],
  ),
  'VComponentThemeWrapper': VDocApiSymbol(
    name: 'VComponentThemeWrapper',
    kind: 'class',
    library: 'lib/src/theme/v_token_theme.dart',
    members: [
      VDocApiMember(
        name: 'VComponentThemeWrapper',
        kind: 'constructor',
        signature: 'const VComponentThemeWrapper({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'data',
        kind: 'field',
        signature: 'final T data;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VComponentTokens': VDocApiSymbol(
    name: 'VComponentTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_component_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VComponentTokens',
        kind: 'constructor',
        signature: 'const VComponentTokens({',
      ),
      VDocApiMember(
        name: 'VComponentTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VComponentTokens.fromColors(VColors colors) =>',
      ),
      VDocApiMember(
        name: 'VComponentTokens.fromTheme',
        kind: 'constructor',
        signature: 'factory VComponentTokens.fromTheme({',
      ),
      VDocApiMember(
        name: 'accordion',
        kind: 'field',
        signature: 'final VAccordionTokens accordion;',
      ),
      VDocApiMember(
        name: 'appBar',
        kind: 'field',
        signature: 'final VAppBarTokens appBar;',
      ),
      VDocApiMember(
        name: 'autoSuggest',
        kind: 'field',
        signature: 'final VAutoSuggestTokens autoSuggest;',
      ),
      VDocApiMember(
        name: 'button',
        kind: 'field',
        signature: 'final VButtonTokens button;',
      ),
      VDocApiMember(
        name: 'checkbox',
        kind: 'field',
        signature: 'final VCheckboxTokens checkbox;',
      ),
      VDocApiMember(
        name: 'chip',
        kind: 'field',
        signature: 'final VChipTokens chip;',
      ),
      VDocApiMember(
        name: 'datePicker',
        kind: 'field',
        signature: 'final VDatePickerTokens datePicker;',
      ),
      VDocApiMember(
        name: 'dialog',
        kind: 'field',
        signature: 'final VDialogTokens dialog;',
      ),
      VDocApiMember(
        name: 'divider',
        kind: 'field',
        signature: 'final VDividerTokens divider;',
      ),
      VDocApiMember(
        name: 'input',
        kind: 'field',
        signature: 'final VInputTokens input;',
      ),
      VDocApiMember(
        name: 'menu',
        kind: 'field',
        signature: 'final VMenuTokens menu;',
      ),
      VDocApiMember(
        name: 'navigationBar',
        kind: 'field',
        signature: 'final VNavigationBarTokens navigationBar;',
      ),
      VDocApiMember(
        name: 'radio',
        kind: 'field',
        signature: 'final VRadioTokens radio;',
      ),
      VDocApiMember(
        name: 'scrollbar',
        kind: 'field',
        signature: 'final VScrollbarTokens scrollbar;',
      ),
      VDocApiMember(
        name: 'segmentedControl',
        kind: 'field',
        signature: 'final VSegmentedControlTokens segmentedControl;',
      ),
      VDocApiMember(
        name: 'select',
        kind: 'field',
        signature: 'final VSelectTokens select;',
      ),
      VDocApiMember(
        name: 'slider',
        kind: 'field',
        signature: 'final VSliderTokens slider;',
      ),
      VDocApiMember(
        name: 'steps',
        kind: 'field',
        signature: 'final VStepsTokens steps;',
      ),
      VDocApiMember(
        name: 'surface',
        kind: 'field',
        signature: 'final VSurfaceTokens surface;',
      ),
      VDocApiMember(
        name: 'switch_',
        kind: 'field',
        signature: 'final VSwitchTokens switch_;',
      ),
      VDocApiMember(
        name: 'table',
        kind: 'field',
        signature: 'final VTableTokens table;',
      ),
      VDocApiMember(
        name: 'teachingTip',
        kind: 'field',
        signature: 'final VTeachingTipTokens teachingTip;',
      ),
      VDocApiMember(
        name: 'timePicker',
        kind: 'field',
        signature: 'final VTimePickerTokens timePicker;',
      ),
      VDocApiMember(
        name: 'timeline',
        kind: 'field',
        signature: 'final VTimeLineTokens timeline;',
      ),
      VDocApiMember(
        name: 'toast',
        kind: 'field',
        signature: 'final VToastTokens toast;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VComponentTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VComponentTokens lerp(',
      ),
    ],
  ),
  'VComponentTokensOverride': VDocApiSymbol(
    name: 'VComponentTokensOverride',
    kind: 'typedef',
    library: 'lib/src/theme/v_theme_data.dart',
    members: [
      VDocApiMember(
        name: 'VComponentTokensOverride',
        kind: 'typedef',
        signature: 'typedef VComponentTokensOverride = VComponentTokens Function(',
      ),
    ],
  ),
  'VContentTransition': VDocApiSymbol(
    name: 'VContentTransition',
    kind: 'enum',
    library: 'lib/src/widgets/animation/v_animated_switcher.dart',
    members: [
      VDocApiMember(
        name: 'fade',
        kind: 'value',
        signature: 'fade',
      ),
      VDocApiMember(
        name: 'slide',
        kind: 'value',
        signature: 'slide',
      ),
      VDocApiMember(
        name: 'scaleFade',
        kind: 'value',
        signature: 'scaleFade',
      ),
    ],
  ),
  'VContextMenu': VDocApiSymbol(
    name: 'VContextMenu',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_context_menu.dart',
    members: [
      VDocApiMember(
        name: 'VContextMenu',
        kind: 'constructor',
        signature: 'const VContextMenu({',
      ),
      VDocApiMember(
        name: 'actions',
        kind: 'field',
        signature: 'final List<VContextMenuItem> actions;',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'previewBuilder',
        kind: 'field',
        signature: 'final WidgetBuilder? previewBuilder;',
      ),
      VDocApiMember(
        name: 'style',
        kind: 'field',
        signature: 'final VContextMenuStyle style;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VContextMenu> createState() => _VContextMenuState();',
      ),
    ],
  ),
  'VContextMenuItem': VDocApiSymbol(
    name: 'VContextMenuItem',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_context_menu.dart',
    members: [
      VDocApiMember(
        name: 'VContextMenuItem',
        kind: 'constructor',
        signature: 'const VContextMenuItem({',
      ),
      VDocApiMember(
        name: 'description',
        kind: 'field',
        signature: 'final String? description;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'icon',
        kind: 'field',
        signature: 'final Widget? icon;',
      ),
      VDocApiMember(
        name: 'isDestructive',
        kind: 'field',
        signature: 'final bool isDestructive;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String label;',
      ),
      VDocApiMember(
        name: 'onTap',
        kind: 'field',
        signature: 'final VoidCallback? onTap;',
      ),
    ],
  ),
  'VContextMenuStyle': VDocApiSymbol(
    name: 'VContextMenuStyle',
    kind: 'enum',
    library: 'lib/src/widgets/overlays/v_context_menu.dart',
    members: [
      VDocApiMember(
        name: 'modern',
        kind: 'value',
        signature: 'modern',
      ),
      VDocApiMember(
        name: 'ios',
        kind: 'value',
        signature: 'ios',
      ),
    ],
  ),
  'VControlSize': VDocApiSymbol(
    name: 'VControlSize',
    kind: 'enum',
    library: 'lib/src/foundation/sizes.dart',
    members: [
      VDocApiMember(
        name: 'sm',
        kind: 'value',
        signature: 'sm',
      ),
      VDocApiMember(
        name: 'md',
        kind: 'value',
        signature: 'md',
      ),
      VDocApiMember(
        name: 'lg',
        kind: 'value',
        signature: 'lg',
      ),
    ],
  ),
  'VDatePicker': VDocApiSymbol(
    name: 'VDatePicker',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_date_picker.dart',
    members: [
      VDocApiMember(
        name: 'VDatePicker',
        kind: 'constructor',
        signature: 'const VDatePicker({',
      ),
      VDocApiMember(
        name: 'firstDate',
        kind: 'field',
        signature: 'final DateTime? firstDate;',
      ),
      VDocApiMember(
        name: 'lastDate',
        kind: 'field',
        signature: 'final DateTime? lastDate;',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<DateTime>? onChanged;',
      ),
      VDocApiMember(
        name: 'selected',
        kind: 'field',
        signature: 'final DateTime? selected;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VDatePicker> createState() => _VDatePickerState();',
      ),
    ],
  ),
  'VDatePickerTheme': VDocApiSymbol(
    name: 'VDatePickerTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VDatePickerTheme',
        kind: 'constructor',
        signature: 'const VDatePickerTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VDatePickerTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VDatePickerTokens': VDocApiSymbol(
    name: 'VDatePickerTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_date_picker_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VDatePickerTokens',
        kind: 'constructor',
        signature: 'const VDatePickerTokens({',
      ),
      VDocApiMember(
        name: 'VDatePickerTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VDatePickerTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'dayCellHeight',
        kind: 'field',
        signature: 'final double dayCellHeight;',
      ),
      VDocApiMember(
        name: 'dayCellRadius',
        kind: 'field',
        signature: 'final double dayCellRadius;',
      ),
      VDocApiMember(
        name: 'dayForeground',
        kind: 'field',
        signature: 'final Color dayForeground;',
      ),
      VDocApiMember(
        name: 'dayTextSize',
        kind: 'field',
        signature: 'final double dayTextSize;',
      ),
      VDocApiMember(
        name: 'disabledForeground',
        kind: 'field',
        signature: 'final Color disabledForeground;',
      ),
      VDocApiMember(
        name: 'focusBackground',
        kind: 'field',
        signature: 'final Color focusBackground;',
      ),
      VDocApiMember(
        name: 'focusOutline',
        kind: 'field',
        signature: 'final Color focusOutline;',
      ),
      VDocApiMember(
        name: 'focusOutlineWidth',
        kind: 'field',
        signature: 'final double focusOutlineWidth;',
      ),
      VDocApiMember(
        name: 'headerSpacing',
        kind: 'field',
        signature: 'final double headerSpacing;',
      ),
      VDocApiMember(
        name: 'navigationForeground',
        kind: 'field',
        signature: 'final Color navigationForeground;',
      ),
      VDocApiMember(
        name: 'navigationIconSize',
        kind: 'field',
        signature: 'final double navigationIconSize;',
      ),
      VDocApiMember(
        name: 'selectedBackground',
        kind: 'field',
        signature: 'final Color selectedBackground;',
      ),
      VDocApiMember(
        name: 'selectedForeground',
        kind: 'field',
        signature: 'final Color selectedForeground;',
      ),
      VDocApiMember(
        name: 'todayBorder',
        kind: 'field',
        signature: 'final Color todayBorder;',
      ),
      VDocApiMember(
        name: 'todayBorderWidth',
        kind: 'field',
        signature: 'final double todayBorderWidth;',
      ),
      VDocApiMember(
        name: 'weekdayForeground',
        kind: 'field',
        signature: 'final Color weekdayForeground;',
      ),
      VDocApiMember(
        name: 'weekdaySpacing',
        kind: 'field',
        signature: 'final double weekdaySpacing;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VDatePickerTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VDatePickerTokens lerp(',
      ),
    ],
  ),
  'VDialog': VDocApiSymbol(
    name: 'VDialog',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_dialog.dart',
    members: [
    ],
  ),
  'VDialogScope': VDocApiSymbol(
    name: 'VDialogScope',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_dialog.dart',
    members: [
      VDocApiMember(
        name: 'VDialogScope',
        kind: 'constructor',
        signature: 'const VDialogScope({',
      ),
      VDocApiMember(
        name: 'Function',
        kind: 'method',
        signature: 'final void Function(T? result) close;',
      ),
      VDocApiMember(
        name: 'updateShouldNotify',
        kind: 'method',
        signature: 'bool updateShouldNotify(VDialogScope<T> oldWidget) =>',
      ),
    ],
  ),
  'VDialogSurface': VDocApiSymbol(
    name: 'VDialogSurface',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_dialog.dart',
    members: [
      VDocApiMember(
        name: 'VDialogSurface',
        kind: 'constructor',
        signature: 'const VDialogSurface({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'maxHeight',
        kind: 'field',
        signature: 'final double? maxHeight;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'surfaceBackground',
        kind: 'field',
        signature: 'final VBackground? surfaceBackground;',
      ),
      VDocApiMember(
        name: 'width',
        kind: 'field',
        signature: 'final double? width;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VDialogTheme': VDocApiSymbol(
    name: 'VDialogTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VDialogTheme',
        kind: 'constructor',
        signature: 'const VDialogTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VDialogTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VDialogTokens': VDocApiSymbol(
    name: 'VDialogTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_dialog_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VDialogTokens',
        kind: 'constructor',
        signature: 'const VDialogTokens({',
      ),
      VDocApiMember(
        name: 'VDialogTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VDialogTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'barrierColor',
        kind: 'field',
        signature: 'final Color barrierColor;',
      ),
      VDocApiMember(
        name: 'defaultMaxHeight',
        kind: 'field',
        signature: 'final double defaultMaxHeight;',
      ),
      VDocApiMember(
        name: 'defaultWidth',
        kind: 'field',
        signature: 'final double defaultWidth;',
      ),
      VDocApiMember(
        name: 'surface',
        kind: 'field',
        signature: 'final Color surface;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VDialogTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VDialogTokens lerp(VDialogTokens a, VDialogTokens b, double t) {',
      ),
    ],
  ),
  'VDivider': VDocApiSymbol(
    name: 'VDivider',
    kind: 'class',
    library: 'lib/src/widgets/basic/v_divider.dart',
    members: [
      VDocApiMember(
        name: 'VDivider',
        kind: 'constructor',
        signature: 'const VDivider({',
      ),
      VDocApiMember(
        name: 'axis',
        kind: 'field',
        signature: 'final Axis axis;',
      ),
      VDocApiMember(
        name: 'color',
        kind: 'field',
        signature: 'final Color? color;',
      ),
      VDocApiMember(
        name: 'dotRadius',
        kind: 'field',
        signature: 'final double? dotRadius;',
      ),
      VDocApiMember(
        name: 'dotStep',
        kind: 'field',
        signature: 'final double? dotStep;',
      ),
      VDocApiMember(
        name: 'endIndent',
        kind: 'field',
        signature: 'final double? endIndent;',
      ),
      VDocApiMember(
        name: 'indent',
        kind: 'field',
        signature: 'final double? indent;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final Widget? label;',
      ),
      VDocApiMember(
        name: 'style',
        kind: 'field',
        signature: 'final VDividerStyle style;',
      ),
      VDocApiMember(
        name: 'thickness',
        kind: 'field',
        signature: 'final double? thickness;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VDividerStyle': VDocApiSymbol(
    name: 'VDividerStyle',
    kind: 'enum',
    library: 'lib/src/widgets/basic/v_divider.dart',
    members: [
      VDocApiMember(
        name: 'solid',
        kind: 'value',
        signature: 'solid',
      ),
      VDocApiMember(
        name: 'dotted',
        kind: 'value',
        signature: 'dotted',
      ),
    ],
  ),
  'VDividerTheme': VDocApiSymbol(
    name: 'VDividerTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VDividerTheme',
        kind: 'constructor',
        signature: 'const VDividerTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VDividerTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VDividerTokens': VDocApiSymbol(
    name: 'VDividerTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_divider_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VDividerTokens',
        kind: 'constructor',
        signature: 'const VDividerTokens({',
      ),
      VDocApiMember(
        name: 'VDividerTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VDividerTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'color',
        kind: 'field',
        signature: 'final Color color;',
      ),
      VDocApiMember(
        name: 'dotRadius',
        kind: 'field',
        signature: 'final double dotRadius;',
      ),
      VDocApiMember(
        name: 'dotStep',
        kind: 'field',
        signature: 'final double dotStep;',
      ),
      VDocApiMember(
        name: 'thickness',
        kind: 'field',
        signature: 'final double thickness;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VDividerTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VDividerTokens lerp(VDividerTokens a, VDividerTokens b, double t) {',
      ),
    ],
  ),
  'VElevation': VDocApiSymbol(
    name: 'VElevation',
    kind: 'enum',
    library: 'lib/src/foundation/shadows.dart',
    members: [
      VDocApiMember(
        name: 'level0',
        kind: 'value',
        signature: 'level0',
      ),
      VDocApiMember(
        name: 'level1',
        kind: 'value',
        signature: 'level1',
      ),
      VDocApiMember(
        name: 'level2',
        kind: 'value',
        signature: 'level2',
      ),
      VDocApiMember(
        name: 'level3',
        kind: 'value',
        signature: 'level3',
      ),
      VDocApiMember(
        name: 'level4',
        kind: 'value',
        signature: 'level4',
      ),
    ],
  ),
  'VEmptyState': VDocApiSymbol(
    name: 'VEmptyState',
    kind: 'class',
    library: 'lib/src/widgets/feedback/v_empty_state.dart',
    members: [
      VDocApiMember(
        name: 'VEmptyState',
        kind: 'constructor',
        signature: 'const VEmptyState({',
      ),
      VDocApiMember(
        name: 'action',
        kind: 'field',
        signature: 'final Widget? action;',
      ),
      VDocApiMember(
        name: 'description',
        kind: 'field',
        signature: 'final String? description;',
      ),
      VDocApiMember(
        name: 'icon',
        kind: 'field',
        signature: 'final IconData? icon;',
      ),
      VDocApiMember(
        name: 'maxWidth',
        kind: 'field',
        signature: 'final double maxWidth;',
      ),
      VDocApiMember(
        name: 'title',
        kind: 'field',
        signature: 'final String? title;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VFlatAppearance': VDocApiSymbol(
    name: 'VFlatAppearance',
    kind: 'class',
    library: 'lib/src/theme/v_appearance.dart',
    members: [
      VDocApiMember(
        name: 'VFlatAppearance',
        kind: 'constructor',
        signature: 'const VFlatAppearance();',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'method',
        signature: 'Color background(Color base, Set<WidgetState> states) {',
      ),
      VDocApiMember(
        name: 'borderColor',
        kind: 'method',
        signature: 'Color borderColor(Color base, Set<WidgetState> states) {',
      ),
      VDocApiMember(
        name: 'shadows',
        kind: 'method',
        signature: 'List<BoxShadow> shadows(List<BoxShadow> base) => const [];',
      ),
    ],
  ),
  'VFlex': VDocApiSymbol(
    name: 'VFlex',
    kind: 'class',
    library: 'lib/src/widgets/basic/v_flex.dart',
    members: [
      VDocApiMember(
        name: 'VFlex',
        kind: 'constructor',
        signature: 'const VFlex({',
      ),
      VDocApiMember(
        name: 'VFlex.horizontal',
        kind: 'constructor',
        signature: 'factory VFlex.horizontal({',
      ),
      VDocApiMember(
        name: 'VFlex.vertical',
        kind: 'constructor',
        signature: 'factory VFlex.vertical({',
      ),
      VDocApiMember(
        name: 'children',
        kind: 'field',
        signature: 'final List<Widget> children;',
      ),
      VDocApiMember(
        name: 'crossAxisAlignment',
        kind: 'field',
        signature: 'final CrossAxisAlignment crossAxisAlignment;',
      ),
      VDocApiMember(
        name: 'direction',
        kind: 'field',
        signature: 'final Axis direction;',
      ),
      VDocApiMember(
        name: 'gap',
        kind: 'field',
        signature: 'final double gap;',
      ),
      VDocApiMember(
        name: 'mainAxisAlignment',
        kind: 'field',
        signature: 'final MainAxisAlignment mainAxisAlignment;',
      ),
      VDocApiMember(
        name: 'mainAxisSize',
        kind: 'field',
        signature: 'final MainAxisSize mainAxisSize;',
      ),
      VDocApiMember(
        name: 'padding',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry? padding;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VForm': VDocApiSymbol(
    name: 'VForm',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_form.dart',
    members: [
      VDocApiMember(
        name: 'VForm',
        kind: 'constructor',
        signature: 'const VForm({',
      ),
      VDocApiMember(
        name: 'children',
        kind: 'field',
        signature: 'final List<Widget> children;',
      ),
      VDocApiMember(
        name: 'gap',
        kind: 'field',
        signature: 'final double? gap;',
      ),
      VDocApiMember(
        name: 'onSubmit',
        kind: 'field',
        signature: 'final VoidCallback? onSubmit;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VForm> createState() => VFormState();',
      ),
    ],
  ),
  'VFormField': VDocApiSymbol(
    name: 'VFormField',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_form.dart',
    members: [
      VDocApiMember(
        name: 'VFormField',
        kind: 'constructor',
        signature: 'const VFormField({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'errors',
        kind: 'field',
        signature: 'final List<VFormFieldError> errors;',
      ),
      VDocApiMember(
        name: 'hasError',
        kind: 'field',
        signature: 'bool get hasError => errors.isNotEmpty;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VFormFieldError': VDocApiSymbol(
    name: 'VFormFieldError',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_form.dart',
    members: [
      VDocApiMember(
        name: 'VFormFieldError',
        kind: 'constructor',
        signature: 'const VFormFieldError(this.message);',
      ),
      VDocApiMember(
        name: 'message',
        kind: 'field',
        signature: 'final String message;',
      ),
    ],
  ),
  'VFormState': VDocApiSymbol(
    name: 'VFormState',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_form.dart',
    members: [
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'validate',
        kind: 'method',
        signature: 'bool validate() {',
      ),
    ],
  ),
  'VGestureDetector': VDocApiSymbol(
    name: 'VGestureDetector',
    kind: 'class',
    library: 'lib/src/widgets/basic/v_gesture_detector.dart',
    members: [
      VDocApiMember(
        name: 'VGestureDetector',
        kind: 'constructor',
        signature: 'const VGestureDetector({',
      ),
      VDocApiMember(
        name: 'behavior',
        kind: 'field',
        signature: 'final HitTestBehavior behavior;',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'dragStartBehavior',
        kind: 'field',
        signature: 'final DragStartBehavior dragStartBehavior;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'excludeFromSemantics',
        kind: 'field',
        signature: 'final bool excludeFromSemantics;',
      ),
      VDocApiMember(
        name: 'mouseCursor',
        kind: 'field',
        signature: 'final MouseCursor? mouseCursor;',
      ),
      VDocApiMember(
        name: 'onDoubleTap',
        kind: 'field',
        signature: 'final GestureTapCallback? onDoubleTap;',
      ),
      VDocApiMember(
        name: 'onDoubleTapCancel',
        kind: 'field',
        signature: 'final GestureTapCancelCallback? onDoubleTapCancel;',
      ),
      VDocApiMember(
        name: 'onDoubleTapDown',
        kind: 'field',
        signature: 'final GestureTapDownCallback? onDoubleTapDown;',
      ),
      VDocApiMember(
        name: 'onEnter',
        kind: 'field',
        signature: 'final PointerEnterEventListener? onEnter;',
      ),
      VDocApiMember(
        name: 'onExit',
        kind: 'field',
        signature: 'final PointerExitEventListener? onExit;',
      ),
      VDocApiMember(
        name: 'onForcePressEnd',
        kind: 'field',
        signature: 'final GestureForcePressEndCallback? onForcePressEnd;',
      ),
      VDocApiMember(
        name: 'onForcePressStart',
        kind: 'field',
        signature: 'final GestureForcePressStartCallback? onForcePressStart;',
      ),
      VDocApiMember(
        name: 'onForcePressUpdate',
        kind: 'field',
        signature: 'final GestureForcePressUpdateCallback? onForcePressUpdate;',
      ),
      VDocApiMember(
        name: 'onHorizontalDragCancel',
        kind: 'field',
        signature: 'final GestureDragCancelCallback? onHorizontalDragCancel;',
      ),
      VDocApiMember(
        name: 'onHorizontalDragDown',
        kind: 'field',
        signature: 'final GestureDragDownCallback? onHorizontalDragDown;',
      ),
      VDocApiMember(
        name: 'onHorizontalDragEnd',
        kind: 'field',
        signature: 'final GestureDragEndCallback? onHorizontalDragEnd;',
      ),
      VDocApiMember(
        name: 'onHorizontalDragStart',
        kind: 'field',
        signature: 'final GestureDragStartCallback? onHorizontalDragStart;',
      ),
      VDocApiMember(
        name: 'onHorizontalDragUpdate',
        kind: 'field',
        signature: 'final GestureDragUpdateCallback? onHorizontalDragUpdate;',
      ),
      VDocApiMember(
        name: 'onHover',
        kind: 'field',
        signature: 'final PointerHoverEventListener? onHover;',
      ),
      VDocApiMember(
        name: 'onLongPress',
        kind: 'field',
        signature: 'final GestureLongPressCallback? onLongPress;',
      ),
      VDocApiMember(
        name: 'onLongPressEnd',
        kind: 'field',
        signature: 'final GestureLongPressEndCallback? onLongPressEnd;',
      ),
      VDocApiMember(
        name: 'onLongPressMoveUpdate',
        kind: 'field',
        signature: 'final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;',
      ),
      VDocApiMember(
        name: 'onLongPressStart',
        kind: 'field',
        signature: 'final GestureLongPressStartCallback? onLongPressStart;',
      ),
      VDocApiMember(
        name: 'onLongPressUp',
        kind: 'field',
        signature: 'final GestureLongPressUpCallback? onLongPressUp;',
      ),
      VDocApiMember(
        name: 'onPanCancel',
        kind: 'field',
        signature: 'final GestureDragCancelCallback? onPanCancel;',
      ),
      VDocApiMember(
        name: 'onPanDown',
        kind: 'field',
        signature: 'final GestureDragDownCallback? onPanDown;',
      ),
      VDocApiMember(
        name: 'onPanEnd',
        kind: 'field',
        signature: 'final GestureDragEndCallback? onPanEnd;',
      ),
      VDocApiMember(
        name: 'onPanStart',
        kind: 'field',
        signature: 'final GestureDragStartCallback? onPanStart;',
      ),
      VDocApiMember(
        name: 'onPanUpdate',
        kind: 'field',
        signature: 'final GestureDragUpdateCallback? onPanUpdate;',
      ),
      VDocApiMember(
        name: 'onScaleEnd',
        kind: 'field',
        signature: 'final GestureScaleEndCallback? onScaleEnd;',
      ),
      VDocApiMember(
        name: 'onScaleStart',
        kind: 'field',
        signature: 'final GestureScaleStartCallback? onScaleStart;',
      ),
      VDocApiMember(
        name: 'onScaleUpdate',
        kind: 'field',
        signature: 'final GestureScaleUpdateCallback? onScaleUpdate;',
      ),
      VDocApiMember(
        name: 'onSecondaryTap',
        kind: 'field',
        signature: 'final GestureTapCallback? onSecondaryTap;',
      ),
      VDocApiMember(
        name: 'onSecondaryTapCancel',
        kind: 'field',
        signature: 'final GestureTapCancelCallback? onSecondaryTapCancel;',
      ),
      VDocApiMember(
        name: 'onSecondaryTapDown',
        kind: 'field',
        signature: 'final GestureTapDownCallback? onSecondaryTapDown;',
      ),
      VDocApiMember(
        name: 'onSecondaryTapUp',
        kind: 'field',
        signature: 'final GestureTapUpCallback? onSecondaryTapUp;',
      ),
      VDocApiMember(
        name: 'onTap',
        kind: 'field',
        signature: 'final GestureTapCallback? onTap;',
      ),
      VDocApiMember(
        name: 'onTapCancel',
        kind: 'field',
        signature: 'final GestureTapCancelCallback? onTapCancel;',
      ),
      VDocApiMember(
        name: 'onTapDown',
        kind: 'field',
        signature: 'final GestureTapDownCallback? onTapDown;',
      ),
      VDocApiMember(
        name: 'onTapUp',
        kind: 'field',
        signature: 'final GestureTapUpCallback? onTapUp;',
      ),
      VDocApiMember(
        name: 'onTertiaryTapCancel',
        kind: 'field',
        signature: 'final GestureTapCancelCallback? onTertiaryTapCancel;',
      ),
      VDocApiMember(
        name: 'onTertiaryTapDown',
        kind: 'field',
        signature: 'final GestureTapDownCallback? onTertiaryTapDown;',
      ),
      VDocApiMember(
        name: 'onTertiaryTapUp',
        kind: 'field',
        signature: 'final GestureTapUpCallback? onTertiaryTapUp;',
      ),
      VDocApiMember(
        name: 'onVerticalDragCancel',
        kind: 'field',
        signature: 'final GestureDragCancelCallback? onVerticalDragCancel;',
      ),
      VDocApiMember(
        name: 'onVerticalDragDown',
        kind: 'field',
        signature: 'final GestureDragDownCallback? onVerticalDragDown;',
      ),
      VDocApiMember(
        name: 'onVerticalDragEnd',
        kind: 'field',
        signature: 'final GestureDragEndCallback? onVerticalDragEnd;',
      ),
      VDocApiMember(
        name: 'onVerticalDragStart',
        kind: 'field',
        signature: 'final GestureDragStartCallback? onVerticalDragStart;',
      ),
      VDocApiMember(
        name: 'onVerticalDragUpdate',
        kind: 'field',
        signature: 'final GestureDragUpdateCallback? onVerticalDragUpdate;',
      ),
      VDocApiMember(
        name: 'supportedDevices',
        kind: 'field',
        signature: 'final Set<PointerDeviceKind>? supportedDevices;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VGridItemBuilder': VDocApiSymbol(
    name: 'VGridItemBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/data/v_scrollable_grid.dart',
    members: [
      VDocApiMember(
        name: 'VGridItemBuilder',
        kind: 'typedef',
        signature: 'typedef VGridItemBuilder<T> = Widget Function(',
      ),
    ],
  ),
  'VGridLayout': VDocApiSymbol(
    name: 'VGridLayout',
    kind: 'enum',
    library: 'lib/src/widgets/data/v_scrollable_grid.dart',
    members: [
      VDocApiMember(
        name: 'fixed',
        kind: 'value',
        signature: 'fixed',
      ),
      VDocApiMember(
        name: 'masonry',
        kind: 'value',
        signature: 'masonry',
      ),
    ],
  ),
  'VIcon': VDocApiSymbol(
    name: 'VIcon',
    kind: 'class',
    library: 'lib/src/widgets/basic/v_icon.dart',
    members: [
      VDocApiMember(
        name: 'VIcon',
        kind: 'constructor',
        signature: 'const VIcon(',
      ),
      VDocApiMember(
        name: 'color',
        kind: 'field',
        signature: 'final Color? color;',
      ),
      VDocApiMember(
        name: 'icon',
        kind: 'field',
        signature: 'final IconData icon;',
      ),
      VDocApiMember(
        name: 'opacity',
        kind: 'field',
        signature: 'final double? opacity;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'size',
        kind: 'field',
        signature: 'final double? size;',
      ),
      VDocApiMember(
        name: 'textDirection',
        kind: 'field',
        signature: 'final TextDirection? textDirection;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VIconTheme': VDocApiSymbol(
    name: 'VIconTheme',
    kind: 'class',
    library: 'lib/src/theme/v_icon_theme.dart',
    members: [
      VDocApiMember(
        name: 'VIconTheme',
        kind: 'constructor',
        signature: 'const VIconTheme({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'data',
        kind: 'field',
        signature: 'final VIconThemeData data;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'maybeOf',
        kind: 'method',
        signature: 'static VIconThemeData? maybeOf(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VIconThemeData of(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VIconThemeData': VDocApiSymbol(
    name: 'VIconThemeData',
    kind: 'class',
    library: 'lib/src/theme/v_icon_theme_data.dart',
    members: [
      VDocApiMember(
        name: 'VIconThemeData',
        kind: 'constructor',
        signature: 'const VIconThemeData({',
      ),
      VDocApiMember(
        name: 'color',
        kind: 'field',
        signature: 'final Color? color;',
      ),
      VDocApiMember(
        name: 'defaultOpacity',
        kind: 'field',
        signature: 'static const defaultOpacity = 1.0;',
      ),
      VDocApiMember(
        name: 'defaultSize',
        kind: 'field',
        signature: 'static const defaultSize = 20.0;',
      ),
      VDocApiMember(
        name: 'effectiveOpacity',
        kind: 'field',
        signature: 'double get effectiveOpacity => opacity ?? defaultOpacity;',
      ),
      VDocApiMember(
        name: 'effectiveSize',
        kind: 'field',
        signature: 'double get effectiveSize => size ?? defaultSize;',
      ),
      VDocApiMember(
        name: 'opacity',
        kind: 'field',
        signature: 'final double? opacity;',
      ),
      VDocApiMember(
        name: 'size',
        kind: 'field',
        signature: 'final double? size;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VIconThemeData copyWith({',
      ),
      VDocApiMember(
        name: 'hashCode',
        kind: 'method',
        signature: 'int get hashCode => Object.hash(size, color, opacity);',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VIconThemeData lerp(VIconThemeData a, VIconThemeData b, double t) {',
      ),
      VDocApiMember(
        name: 'operator',
        kind: 'method',
        signature: 'bool operator ==(Object other) {',
      ),
    ],
  ),
  'VImage': VDocApiSymbol(
    name: 'VImage',
    kind: 'class',
    library: 'lib/src/widgets/media/v_image.dart',
    members: [
      VDocApiMember(
        name: 'VImage',
        kind: 'constructor',
        signature: 'const VImage({',
      ),
      VDocApiMember(
        name: 'VImage.asset',
        kind: 'constructor',
        signature: 'factory VImage.asset(',
      ),
      VDocApiMember(
        name: 'VImage.memory',
        kind: 'constructor',
        signature: 'factory VImage.memory(',
      ),
      VDocApiMember(
        name: 'VImage.network',
        kind: 'constructor',
        signature: 'factory VImage.network(',
      ),
      VDocApiMember(
        name: 'alignment',
        kind: 'field',
        signature: 'final AlignmentGeometry alignment;',
      ),
      VDocApiMember(
        name: 'aspectRatio',
        kind: 'field',
        signature: 'final double? aspectRatio;',
      ),
      VDocApiMember(
        name: 'backgroundColor',
        kind: 'field',
        signature: 'final Color? backgroundColor;',
      ),
      VDocApiMember(
        name: 'excludeFromSemantics',
        kind: 'field',
        signature: 'final bool excludeFromSemantics;',
      ),
      VDocApiMember(
        name: 'fit',
        kind: 'field',
        signature: 'final BoxFit fit;',
      ),
      VDocApiMember(
        name: 'height',
        kind: 'field',
        signature: 'final double? height;',
      ),
      VDocApiMember(
        name: 'placeholder',
        kind: 'field',
        signature: 'final Widget? placeholder;',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'field',
        signature: 'final double? radius;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'source',
        kind: 'field',
        signature: 'final VImageSource source;',
      ),
      VDocApiMember(
        name: 'width',
        kind: 'field',
        signature: 'final double? width;',
      ),
      VDocApiMember(
        name: 'Function',
        kind: 'method',
        signature: 'final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VImageCache': VDocApiSymbol(
    name: 'VImageCache',
    kind: 'class',
    library: 'lib/src/widgets/media/v_image.dart',
    members: [
      VDocApiMember(
        name: 'evict',
        kind: 'method',
        signature: 'static Future<bool> evict(BuildContext context, VImageSource source) async {',
      ),
      VDocApiMember(
        name: 'precache',
        kind: 'method',
        signature: 'static Future<void> precache(',
      ),
    ],
  ),
  'VImageSource': VDocApiSymbol(
    name: 'VImageSource',
    kind: 'class',
    library: 'lib/src/widgets/media/v_image_source.dart',
    members: [
      VDocApiMember(
        name: 'VImageSource',
        kind: 'constructor',
        signature: 'const VImageSource();',
      ),
      VDocApiMember(
        name: 'resolve',
        kind: 'method',
        signature: 'ImageProvider<Object> resolve(BuildContext context);',
      ),
    ],
  ),
  'VInputTheme': VDocApiSymbol(
    name: 'VInputTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VInputTheme',
        kind: 'constructor',
        signature: 'const VInputTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VInputTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VInputTokens': VDocApiSymbol(
    name: 'VInputTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_input_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VInputTokens',
        kind: 'constructor',
        signature: 'const VInputTokens({',
      ),
      VDocApiMember(
        name: 'VInputTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VInputTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'field',
        signature: 'final Color background;',
      ),
      VDocApiMember(
        name: 'border',
        kind: 'field',
        signature: 'final Color border;',
      ),
      VDocApiMember(
        name: 'borderError',
        kind: 'field',
        signature: 'final Color borderError;',
      ),
      VDocApiMember(
        name: 'borderFocused',
        kind: 'field',
        signature: 'final Color borderFocused;',
      ),
      VDocApiMember(
        name: 'focusRing',
        kind: 'field',
        signature: 'final Color focusRing;',
      ),
      VDocApiMember(
        name: 'placeholder',
        kind: 'field',
        signature: 'final Color placeholder;',
      ),
      VDocApiMember(
        name: 'text',
        kind: 'field',
        signature: 'final Color text;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VInputTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VInputTokens lerp(VInputTokens a, VInputTokens b, double t) {',
      ),
    ],
  ),
  'VListTile': VDocApiSymbol(
    name: 'VListTile',
    kind: 'class',
    library: 'lib/src/widgets/layout/v_list_tile.dart',
    members: [
      VDocApiMember(
        name: 'VListTile',
        kind: 'constructor',
        signature: 'const VListTile({',
      ),
      VDocApiMember(
        name: 'dense',
        kind: 'field',
        signature: 'final bool dense;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'leading',
        kind: 'field',
        signature: 'final Widget? leading;',
      ),
      VDocApiMember(
        name: 'onTap',
        kind: 'field',
        signature: 'final VoidCallback? onTap;',
      ),
      VDocApiMember(
        name: 'selected',
        kind: 'field',
        signature: 'final bool selected;',
      ),
      VDocApiMember(
        name: 'showDivider',
        kind: 'field',
        signature: 'final bool showDivider;',
      ),
      VDocApiMember(
        name: 'subtitle',
        kind: 'field',
        signature: 'final String? subtitle;',
      ),
      VDocApiMember(
        name: 'title',
        kind: 'field',
        signature: 'final String? title;',
      ),
      VDocApiMember(
        name: 'titleWidget',
        kind: 'field',
        signature: 'final Widget? titleWidget;',
      ),
      VDocApiMember(
        name: 'trailing',
        kind: 'field',
        signature: 'final Widget? trailing;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VLocale': VDocApiSymbol(
    name: 'VLocale',
    kind: 'class',
    library: 'lib/src/theme/v_locale.dart',
    members: [
      VDocApiMember(
        name: 'en',
        kind: 'method',
        signature: 'static const en = VLocaleStrings(',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VLocaleStrings of(Locale locale) {',
      ),
      VDocApiMember(
        name: 'zh',
        kind: 'method',
        signature: 'static const zh = VLocaleStrings(',
      ),
    ],
  ),
  'VLocaleStrings': VDocApiSymbol(
    name: 'VLocaleStrings',
    kind: 'class',
    library: 'lib/src/theme/v_locale.dart',
    members: [
      VDocApiMember(
        name: 'VLocaleStrings',
        kind: 'constructor',
        signature: 'const VLocaleStrings({',
      ),
      VDocApiMember(
        name: 'cancel',
        kind: 'field',
        signature: 'final String cancel;',
      ),
      VDocApiMember(
        name: 'close',
        kind: 'field',
        signature: 'final String close;',
      ),
      VDocApiMember(
        name: 'confirm',
        kind: 'field',
        signature: 'final String confirm;',
      ),
      VDocApiMember(
        name: 'delete',
        kind: 'field',
        signature: 'final String delete;',
      ),
      VDocApiMember(
        name: 'loading',
        kind: 'field',
        signature: 'final String loading;',
      ),
      VDocApiMember(
        name: 'noResults',
        kind: 'field',
        signature: 'final String noResults;',
      ),
      VDocApiMember(
        name: 'ok',
        kind: 'field',
        signature: 'final String ok;',
      ),
      VDocApiMember(
        name: 'search',
        kind: 'field',
        signature: 'final String search;',
      ),
    ],
  ),
  'VMemoryImageSource': VDocApiSymbol(
    name: 'VMemoryImageSource',
    kind: 'class',
    library: 'lib/src/widgets/media/v_image_source.dart',
    members: [
      VDocApiMember(
        name: 'VMemoryImageSource',
        kind: 'constructor',
        signature: 'const VMemoryImageSource(this.bytes);',
      ),
      VDocApiMember(
        name: 'bytes',
        kind: 'field',
        signature: 'final Uint8List bytes;',
      ),
      VDocApiMember(
        name: 'resolve',
        kind: 'method',
        signature: 'ImageProvider<Object> resolve(BuildContext context) {',
      ),
    ],
  ),
  'VMenuAnchor': VDocApiSymbol(
    name: 'VMenuAnchor',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_menu_anchor.dart',
    members: [
      VDocApiMember(
        name: 'VMenuAnchor',
        kind: 'constructor',
        signature: 'const VMenuAnchor({',
      ),
      VDocApiMember(
        name: 'builder',
        kind: 'field',
        signature: 'final VMenuAnchorBuilder builder;',
      ),
      VDocApiMember(
        name: 'controller',
        kind: 'field',
        signature: 'final VMenuController? controller;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'isSubmenu',
        kind: 'field',
        signature: 'final bool isSubmenu;',
      ),
      VDocApiMember(
        name: 'items',
        kind: 'field',
        signature: 'final List<VMenuItem<T>> items;',
      ),
      VDocApiMember(
        name: 'maxMenuHeight',
        kind: 'field',
        signature: 'final double maxMenuHeight;',
      ),
      VDocApiMember(
        name: 'onActivate',
        kind: 'field',
        signature: 'final ValueChanged<VMenuItem<dynamic>>? onActivate;',
      ),
      VDocApiMember(
        name: 'onSelected',
        kind: 'field',
        signature: 'final ValueChanged<T>? onSelected;',
      ),
      VDocApiMember(
        name: 'onSelectionChanged',
        kind: 'field',
        signature: 'final ValueChanged<Set<T>>? onSelectionChanged;',
      ),
      VDocApiMember(
        name: 'placement',
        kind: 'field',
        signature: 'final VAnchoredOverlayPlacement placement;',
      ),
      VDocApiMember(
        name: 'selectedValue',
        kind: 'field',
        signature: 'final T? selectedValue;',
      ),
      VDocApiMember(
        name: 'selectedValues',
        kind: 'field',
        signature: 'final Set<T>? selectedValues;',
      ),
      VDocApiMember(
        name: 'selectionMode',
        kind: 'field',
        signature: 'final VMenuSelectionMode selectionMode;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VMenuAnchor<T>> createState() => _VMenuAnchorState<T>();',
      ),
    ],
  ),
  'VMenuAnchorBuilder': VDocApiSymbol(
    name: 'VMenuAnchorBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/overlays/v_menu_anchor.dart',
    members: [
      VDocApiMember(
        name: 'VMenuAnchorBuilder',
        kind: 'typedef',
        signature: 'typedef VMenuAnchorBuilder = Widget Function(',
      ),
    ],
  ),
  'VMenuController': VDocApiSymbol(
    name: 'VMenuController',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_menu_anchor.dart',
    members: [
    ],
  ),
  'VMenuItem': VDocApiSymbol(
    name: 'VMenuItem',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_menu_anchor.dart',
    members: [
      VDocApiMember(
        name: 'VMenuItem',
        kind: 'constructor',
        signature: 'const VMenuItem({',
      ),
      VDocApiMember(
        name: 'VMenuItem.separator',
        kind: 'constructor',
        signature: 'const VMenuItem.separator()',
      ),
      VDocApiMember(
        name: 'children',
        kind: 'field',
        signature: 'final List<VMenuItem<T>>? children;',
      ),
      VDocApiMember(
        name: 'closeOnActivate',
        kind: 'field',
        signature: 'final bool? closeOnActivate;',
      ),
      VDocApiMember(
        name: 'description',
        kind: 'field',
        signature: 'final String? description;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'isSeparator',
        kind: 'field',
        signature: 'final bool isSeparator;',
      ),
      VDocApiMember(
        name: 'isSubmenu',
        kind: 'field',
        signature: 'bool get isSubmenu => children != null && children!.isNotEmpty;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String label;',
      ),
      VDocApiMember(
        name: 'leading',
        kind: 'field',
        signature: 'final Widget? leading;',
      ),
      VDocApiMember(
        name: 'onPressed',
        kind: 'field',
        signature: 'final VoidCallback? onPressed;',
      ),
      VDocApiMember(
        name: 'role',
        kind: 'field',
        signature: 'final VMenuItemRole role;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'trailing',
        kind: 'field',
        signature: 'final Widget? trailing;',
      ),
      VDocApiMember(
        name: 'value',
        kind: 'field',
        signature: 'final T? value;',
      ),
    ],
  ),
  'VMenuItemRole': VDocApiSymbol(
    name: 'VMenuItemRole',
    kind: 'enum',
    library: 'lib/src/widgets/overlays/v_menu_anchor.dart',
    members: [
      VDocApiMember(
        name: 'normal',
        kind: 'value',
        signature: 'normal',
      ),
      VDocApiMember(
        name: 'destructive',
        kind: 'value',
        signature: 'destructive',
      ),
    ],
  ),
  'VMenuSelectionMode': VDocApiSymbol(
    name: 'VMenuSelectionMode',
    kind: 'enum',
    library: 'lib/src/widgets/overlays/v_menu_anchor.dart',
    members: [
      VDocApiMember(
        name: 'none',
        kind: 'value',
        signature: 'none',
      ),
      VDocApiMember(
        name: 'single',
        kind: 'value',
        signature: 'single',
      ),
      VDocApiMember(
        name: 'multiple',
        kind: 'value',
        signature: 'multiple',
      ),
    ],
  ),
  'VMenuTheme': VDocApiSymbol(
    name: 'VMenuTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VMenuTheme',
        kind: 'constructor',
        signature: 'const VMenuTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VMenuTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VMenuTokens': VDocApiSymbol(
    name: 'VMenuTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_menu_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VMenuTokens',
        kind: 'constructor',
        signature: 'const VMenuTokens({',
      ),
      VDocApiMember(
        name: 'VMenuTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VMenuTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'backdropBlurSigma',
        kind: 'field',
        signature: 'final double backdropBlurSigma;',
      ),
      VDocApiMember(
        name: 'backdropColor',
        kind: 'field',
        signature: 'final Color backdropColor;',
      ),
      VDocApiMember(
        name: 'backdropOpacity',
        kind: 'field',
        signature: 'final double backdropOpacity;',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'field',
        signature: 'final Color background;',
      ),
      VDocApiMember(
        name: 'border',
        kind: 'field',
        signature: 'final Color border;',
      ),
      VDocApiMember(
        name: 'borderWidth',
        kind: 'field',
        signature: 'final double borderWidth;',
      ),
      VDocApiMember(
        name: 'checkmarkSize',
        kind: 'field',
        signature: 'final double checkmarkSize;',
      ),
      VDocApiMember(
        name: 'destructiveText',
        kind: 'field',
        signature: 'final Color destructiveText;',
      ),
      VDocApiMember(
        name: 'disabledText',
        kind: 'field',
        signature: 'final Color disabledText;',
      ),
      VDocApiMember(
        name: 'focusRing',
        kind: 'field',
        signature: 'final Color focusRing;',
      ),
      VDocApiMember(
        name: 'hoverBackground',
        kind: 'field',
        signature: 'final Color hoverBackground;',
      ),
      VDocApiMember(
        name: 'iconGap',
        kind: 'field',
        signature: 'final double iconGap;',
      ),
      VDocApiMember(
        name: 'iconSize',
        kind: 'field',
        signature: 'final double iconSize;',
      ),
      VDocApiMember(
        name: 'iosHoverOverlayOpacity',
        kind: 'field',
        signature: 'final double iosHoverOverlayOpacity;',
      ),
      VDocApiMember(
        name: 'iosPressedOverlayOpacity',
        kind: 'field',
        signature: 'final double iosPressedOverlayOpacity;',
      ),
      VDocApiMember(
        name: 'itemHeight',
        kind: 'field',
        signature: 'final double itemHeight;',
      ),
      VDocApiMember(
        name: 'itemPaddingHorizontal',
        kind: 'field',
        signature: 'final double itemPaddingHorizontal;',
      ),
      VDocApiMember(
        name: 'itemPaddingVertical',
        kind: 'field',
        signature: 'final double itemPaddingVertical;',
      ),
      VDocApiMember(
        name: 'liftScaleDelta',
        kind: 'field',
        signature: 'final double liftScaleDelta;',
      ),
      VDocApiMember(
        name: 'liftShadowBlur',
        kind: 'field',
        signature: 'final double liftShadowBlur;',
      ),
      VDocApiMember(
        name: 'liftShadowColor',
        kind: 'field',
        signature: 'final Color liftShadowColor;',
      ),
      VDocApiMember(
        name: 'liftShadowOffsetY',
        kind: 'field',
        signature: 'final double liftShadowOffsetY;',
      ),
      VDocApiMember(
        name: 'liftShadowOpacity',
        kind: 'field',
        signature: 'final double liftShadowOpacity;',
      ),
      VDocApiMember(
        name: 'maxHeight',
        kind: 'field',
        signature: 'final double maxHeight;',
      ),
      VDocApiMember(
        name: 'menuScaleBegin',
        kind: 'field',
        signature: 'final double menuScaleBegin;',
      ),
      VDocApiMember(
        name: 'minHeight',
        kind: 'field',
        signature: 'final double minHeight;',
      ),
      VDocApiMember(
        name: 'modernPressedOverlayOpacity',
        kind: 'field',
        signature: 'final double modernPressedOverlayOpacity;',
      ),
      VDocApiMember(
        name: 'previewWidth',
        kind: 'field',
        signature: 'final double previewWidth;',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'field',
        signature: 'final double radius;',
      ),
      VDocApiMember(
        name: 'screenMargin',
        kind: 'field',
        signature: 'final double screenMargin;',
      ),
      VDocApiMember(
        name: 'selectedBackground',
        kind: 'field',
        signature: 'final Color selectedBackground;',
      ),
      VDocApiMember(
        name: 'selectedText',
        kind: 'field',
        signature: 'final Color selectedText;',
      ),
      VDocApiMember(
        name: 'separatorColor',
        kind: 'field',
        signature: 'final Color separatorColor;',
      ),
      VDocApiMember(
        name: 'separatorThickness',
        kind: 'field',
        signature: 'final double separatorThickness;',
      ),
      VDocApiMember(
        name: 'text',
        kind: 'field',
        signature: 'final Color text;',
      ),
      VDocApiMember(
        name: 'width',
        kind: 'field',
        signature: 'final double width;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VMenuTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VMenuTokens lerp(VMenuTokens a, VMenuTokens b, double t) {',
      ),
    ],
  ),
  'VMotion': VDocApiSymbol(
    name: 'VMotion',
    kind: 'class',
    library: 'lib/src/foundation/motion.dart',
    members: [
      VDocApiMember(
        name: 'VMotion',
        kind: 'constructor',
        signature: 'const VMotion({',
      ),
      VDocApiMember(
        name: 'VMotion.defaults',
        kind: 'constructor',
        signature: 'factory VMotion.defaults() => const VMotion();',
      ),
      VDocApiMember(
        name: 'control',
        kind: 'field',
        signature: 'final VMotionSpec control;',
      ),
      VDocApiMember(
        name: 'emphasized',
        kind: 'field',
        signature: 'final VMotionSpec emphasized;',
      ),
      VDocApiMember(
        name: 'fast',
        kind: 'field',
        signature: 'final VMotionSpec fast;',
      ),
      VDocApiMember(
        name: 'instant',
        kind: 'field',
        signature: 'final VMotionSpec instant;',
      ),
      VDocApiMember(
        name: 'none',
        kind: 'field',
        signature: 'final VMotionSpec none;',
      ),
      VDocApiMember(
        name: 'normal',
        kind: 'field',
        signature: 'final VMotionSpec normal;',
      ),
      VDocApiMember(
        name: 'overlay',
        kind: 'field',
        signature: 'final VMotionSpec overlay;',
      ),
      VDocApiMember(
        name: 'page',
        kind: 'field',
        signature: 'final VMotionSpec page;',
      ),
      VDocApiMember(
        name: 'pageTransition',
        kind: 'field',
        signature: 'final VPageTransition pageTransition;',
      ),
      VDocApiMember(
        name: 'reducedMotion',
        kind: 'field',
        signature: 'final bool reducedMotion;',
      ),
      VDocApiMember(
        name: 'slow',
        kind: 'field',
        signature: 'final VMotionSpec slow;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VMotion copyWith({',
      ),
      VDocApiMember(
        name: 'debugFillProperties',
        kind: 'method',
        signature: 'void debugFillProperties(DiagnosticPropertiesBuilder properties) {',
      ),
      VDocApiMember(
        name: 'hashCode',
        kind: 'method',
        signature: 'int get hashCode => Object.hash(',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VMotion lerp(VMotion a, VMotion b, double t) {',
      ),
      VDocApiMember(
        name: 'operator',
        kind: 'method',
        signature: 'bool operator ==(Object other) {',
      ),
      VDocApiMember(
        name: 'tooltipShow',
        kind: 'method',
        signature: 'static const Duration tooltipShow = Duration(seconds: 2);',
      ),
      VDocApiMember(
        name: 'tooltipWait',
        kind: 'method',
        signature: 'static const Duration tooltipWait = Duration(milliseconds: 500);',
      ),
    ],
  ),
  'VMotionResolver': VDocApiSymbol(
    name: 'VMotionResolver',
    kind: 'class',
    library: 'lib/src/theme/v_motion_scope.dart',
    members: [
      VDocApiMember(
        name: 'curve',
        kind: 'method',
        signature: 'static Curve curve(BuildContext context, VMotionSpec spec) {',
      ),
      VDocApiMember(
        name: 'duration',
        kind: 'method',
        signature: 'static Duration duration(BuildContext context, VMotionSpec spec) {',
      ),
      VDocApiMember(
        name: 'reverseCurve',
        kind: 'method',
        signature: 'static Curve reverseCurve(BuildContext context, VMotionSpec spec) {',
      ),
      VDocApiMember(
        name: 'reverseDuration',
        kind: 'method',
        signature: 'static Duration reverseDuration(BuildContext context, VMotionSpec spec) {',
      ),
    ],
  ),
  'VMotionScope': VDocApiSymbol(
    name: 'VMotionScope',
    kind: 'class',
    library: 'lib/src/theme/v_motion_scope.dart',
    members: [
      VDocApiMember(
        name: 'VMotionScope',
        kind: 'constructor',
        signature: 'const VMotionScope({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'motion',
        kind: 'field',
        signature: 'final VMotion motion;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'maybeOf',
        kind: 'method',
        signature: 'static VMotion? maybeOf(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VMotion of(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VMotionSpec': VDocApiSymbol(
    name: 'VMotionSpec',
    kind: 'class',
    library: 'lib/src/foundation/motion.dart',
    members: [
      VDocApiMember(
        name: 'VMotionSpec',
        kind: 'constructor',
        signature: 'const VMotionSpec({',
      ),
      VDocApiMember(
        name: 'curve',
        kind: 'field',
        signature: 'final Curve curve;',
      ),
      VDocApiMember(
        name: 'duration',
        kind: 'field',
        signature: 'final Duration duration;',
      ),
      VDocApiMember(
        name: 'effectiveReverseCurve',
        kind: 'field',
        signature: 'Curve get effectiveReverseCurve => reverseCurve ?? curve;',
      ),
      VDocApiMember(
        name: 'effectiveReverseDuration',
        kind: 'field',
        signature: 'Duration get effectiveReverseDuration => reverseDuration ?? duration;',
      ),
      VDocApiMember(
        name: 'reverseCurve',
        kind: 'field',
        signature: 'final Curve? reverseCurve;',
      ),
      VDocApiMember(
        name: 'reverseDuration',
        kind: 'field',
        signature: 'final Duration? reverseDuration;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VMotionSpec copyWith({',
      ),
      VDocApiMember(
        name: 'debugFillProperties',
        kind: 'method',
        signature: 'void debugFillProperties(DiagnosticPropertiesBuilder properties) {',
      ),
      VDocApiMember(
        name: 'hashCode',
        kind: 'method',
        signature: 'int get hashCode => Object.hash(',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VMotionSpec lerp(VMotionSpec a, VMotionSpec b, double t) {',
      ),
      VDocApiMember(
        name: 'operator',
        kind: 'method',
        signature: 'bool operator ==(Object other) {',
      ),
    ],
  ),
  'VNavigationBar': VDocApiSymbol(
    name: 'VNavigationBar',
    kind: 'class',
    library: 'lib/src/widgets/navigation/v_navigation_bar.dart',
    members: [
      VDocApiMember(
        name: 'VNavigationBar',
        kind: 'constructor',
        signature: 'const VNavigationBar({',
      ),
      VDocApiMember(
        name: 'animation',
        kind: 'field',
        signature: 'final VNavigationBarAnimation animation;',
      ),
      VDocApiMember(
        name: 'centerDestination',
        kind: 'field',
        signature: 'final VNavigationDestination? centerDestination;',
      ),
      VDocApiMember(
        name: 'contentMode',
        kind: 'field',
        signature: 'final VNavigationBarContentMode contentMode;',
      ),
      VDocApiMember(
        name: 'destinations',
        kind: 'field',
        signature: 'final List<VNavigationDestination> destinations;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'indicator',
        kind: 'field',
        signature: 'final VNavigationBarIndicator indicator;',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<int> onChanged;',
      ),
      VDocApiMember(
        name: 'selectedIndex',
        kind: 'field',
        signature: 'final int selectedIndex;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'shape',
        kind: 'field',
        signature: 'final VNavigationBarShape shape;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VNavigationBar> createState() => _VNavigationBarState();',
      ),
    ],
  ),
  'VNavigationBarAnimation': VDocApiSymbol(
    name: 'VNavigationBarAnimation',
    kind: 'enum',
    library: 'lib/src/widgets/navigation/v_navigation_bar.dart',
    members: [
      VDocApiMember(
        name: 'scale',
        kind: 'value',
        signature: 'scale',
      ),
      VDocApiMember(
        name: 'shift',
        kind: 'value',
        signature: 'shift',
      ),
      VDocApiMember(
        name: 'none',
        kind: 'value',
        signature: 'none',
      ),
    ],
  ),
  'VNavigationBarContentMode': VDocApiSymbol(
    name: 'VNavigationBarContentMode',
    kind: 'enum',
    library: 'lib/src/widgets/navigation/v_navigation_bar.dart',
    members: [
      VDocApiMember(
        name: 'labeled',
        kind: 'value',
        signature: 'labeled',
      ),
      VDocApiMember(
        name: 'iconsOnly',
        kind: 'value',
        signature: 'iconsOnly',
      ),
      VDocApiMember(
        name: 'labelsOnly',
        kind: 'value',
        signature: 'labelsOnly',
      ),
    ],
  ),
  'VNavigationBarIndicator': VDocApiSymbol(
    name: 'VNavigationBarIndicator',
    kind: 'enum',
    library: 'lib/src/widgets/navigation/v_navigation_bar.dart',
    members: [
      VDocApiMember(
        name: 'pill',
        kind: 'value',
        signature: 'pill',
      ),
      VDocApiMember(
        name: 'dot',
        kind: 'value',
        signature: 'dot',
      ),
      VDocApiMember(
        name: 'topLine',
        kind: 'value',
        signature: 'topLine',
      ),
      VDocApiMember(
        name: 'none',
        kind: 'value',
        signature: 'none',
      ),
    ],
  ),
  'VNavigationBarShape': VDocApiSymbol(
    name: 'VNavigationBarShape',
    kind: 'enum',
    library: 'lib/src/widgets/navigation/v_navigation_bar.dart',
    members: [
      VDocApiMember(
        name: 'flat',
        kind: 'value',
        signature: 'flat',
      ),
      VDocApiMember(
        name: 'floating',
        kind: 'value',
        signature: 'floating',
      ),
      VDocApiMember(
        name: 'capsule',
        kind: 'value',
        signature: 'capsule',
      ),
    ],
  ),
  'VNavigationBarTheme': VDocApiSymbol(
    name: 'VNavigationBarTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VNavigationBarTheme',
        kind: 'constructor',
        signature: 'const VNavigationBarTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VNavigationBarTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VNavigationBarTokens': VDocApiSymbol(
    name: 'VNavigationBarTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_navigation_bar_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VNavigationBarTokens',
        kind: 'constructor',
        signature: 'const VNavigationBarTokens({',
      ),
      VDocApiMember(
        name: 'VNavigationBarTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VNavigationBarTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'field',
        signature: 'final Color background;',
      ),
      VDocApiMember(
        name: 'border',
        kind: 'field',
        signature: 'final Color border;',
      ),
      VDocApiMember(
        name: 'borderRadius',
        kind: 'field',
        signature: 'final double borderRadius;',
      ),
      VDocApiMember(
        name: 'bottomMargin',
        kind: 'field',
        signature: 'final double bottomMargin;',
      ),
      VDocApiMember(
        name: 'centerFabBackground',
        kind: 'field',
        signature: 'final Color centerFabBackground;',
      ),
      VDocApiMember(
        name: 'centerFabElevation',
        kind: 'field',
        signature: 'final double centerFabElevation;',
      ),
      VDocApiMember(
        name: 'centerFabForeground',
        kind: 'field',
        signature: 'final Color centerFabForeground;',
      ),
      VDocApiMember(
        name: 'centerFabSize',
        kind: 'field',
        signature: 'final double centerFabSize;',
      ),
      VDocApiMember(
        name: 'focusRing',
        kind: 'field',
        signature: 'final Color focusRing;',
      ),
      VDocApiMember(
        name: 'foreground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> foreground;',
      ),
      VDocApiMember(
        name: 'height',
        kind: 'field',
        signature: 'final double height;',
      ),
      VDocApiMember(
        name: 'horizontalMargin',
        kind: 'field',
        signature: 'final double horizontalMargin;',
      ),
      VDocApiMember(
        name: 'horizontalPadding',
        kind: 'field',
        signature: 'final double horizontalPadding;',
      ),
      VDocApiMember(
        name: 'iconLabelSpacing',
        kind: 'field',
        signature: 'final double iconLabelSpacing;',
      ),
      VDocApiMember(
        name: 'iconSize',
        kind: 'field',
        signature: 'final double iconSize;',
      ),
      VDocApiMember(
        name: 'iconsOnlyHeight',
        kind: 'field',
        signature: 'final double iconsOnlyHeight;',
      ),
      VDocApiMember(
        name: 'indicatorBackground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> indicatorBackground;',
      ),
      VDocApiMember(
        name: 'indicatorDotSize',
        kind: 'field',
        signature: 'final double indicatorDotSize;',
      ),
      VDocApiMember(
        name: 'indicatorHorizontalInset',
        kind: 'field',
        signature: 'final double indicatorHorizontalInset;',
      ),
      VDocApiMember(
        name: 'indicatorRadius',
        kind: 'field',
        signature: 'final double indicatorRadius;',
      ),
      VDocApiMember(
        name: 'indicatorTopLineHeight',
        kind: 'field',
        signature: 'final double indicatorTopLineHeight;',
      ),
      VDocApiMember(
        name: 'labelsOnlyHeight',
        kind: 'field',
        signature: 'final double labelsOnlyHeight;',
      ),
      VDocApiMember(
        name: 'notchMargin',
        kind: 'field',
        signature: 'final double notchMargin;',
      ),
      VDocApiMember(
        name: 'shadow',
        kind: 'field',
        signature: 'final List<BoxShadow> shadow;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VNavigationBarTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VNavigationBarTokens lerp(',
      ),
    ],
  ),
  'VNavigationDestination': VDocApiSymbol(
    name: 'VNavigationDestination',
    kind: 'class',
    library: 'lib/src/widgets/navigation/v_navigation_bar.dart',
    members: [
      VDocApiMember(
        name: 'VNavigationDestination',
        kind: 'constructor',
        signature: 'const VNavigationDestination({',
      ),
      VDocApiMember(
        name: 'badge',
        kind: 'field',
        signature: 'final Widget? badge;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'icon',
        kind: 'field',
        signature: 'final Widget icon;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String label;',
      ),
      VDocApiMember(
        name: 'selectedIcon',
        kind: 'field',
        signature: 'final Widget? selectedIcon;',
      ),
    ],
  ),
  'VNavigatorAdapter': VDocApiSymbol(
    name: 'VNavigatorAdapter',
    kind: 'class',
    library: 'lib/src/app/v_navigator_adapter.dart',
    members: [
      VDocApiMember(
        name: 'VNavigatorAdapter',
        kind: 'constructor',
        signature: 'const VNavigatorAdapter({',
      ),
      VDocApiMember(
        name: 'home',
        kind: 'field',
        signature: 'final Widget? home;',
      ),
      VDocApiMember(
        name: 'initialRoute',
        kind: 'field',
        signature: 'final String? initialRoute;',
      ),
      VDocApiMember(
        name: 'navigatorKey',
        kind: 'field',
        signature: 'final GlobalKey<NavigatorState>? navigatorKey;',
      ),
      VDocApiMember(
        name: 'navigatorObservers',
        kind: 'field',
        signature: 'final List<NavigatorObserver>? navigatorObservers;',
      ),
      VDocApiMember(
        name: 'onGenerateRoute',
        kind: 'field',
        signature: 'final RouteFactory? onGenerateRoute;',
      ),
      VDocApiMember(
        name: 'onUnknownRoute',
        kind: 'field',
        signature: 'final RouteFactory? onUnknownRoute;',
      ),
      VDocApiMember(
        name: 'routes',
        kind: 'field',
        signature: 'final Map<String, WidgetBuilder>? routes;',
      ),
      VDocApiMember(
        name: 'buildApp',
        kind: 'method',
        signature: 'Widget buildApp({',
      ),
    ],
  ),
  'VNetworkImageSource': VDocApiSymbol(
    name: 'VNetworkImageSource',
    kind: 'class',
    library: 'lib/src/widgets/media/v_image_source.dart',
    members: [
      VDocApiMember(
        name: 'VNetworkImageSource',
        kind: 'constructor',
        signature: 'const VNetworkImageSource(',
      ),
      VDocApiMember(
        name: 'cache',
        kind: 'field',
        signature: 'final bool cache;',
      ),
      VDocApiMember(
        name: 'cacheKey',
        kind: 'field',
        signature: 'final String? cacheKey;',
      ),
      VDocApiMember(
        name: 'headers',
        kind: 'field',
        signature: 'final Map<String, String>? headers;',
      ),
      VDocApiMember(
        name: 'url',
        kind: 'field',
        signature: 'final String url;',
      ),
      VDocApiMember(
        name: 'resolve',
        kind: 'method',
        signature: 'ImageProvider<Object> resolve(BuildContext context) {',
      ),
    ],
  ),
  'VNumberBox': VDocApiSymbol(
    name: 'VNumberBox',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_number_box.dart',
    members: [
      VDocApiMember(
        name: 'VNumberBox',
        kind: 'constructor',
        signature: 'const VNumberBox({',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'max',
        kind: 'field',
        signature: 'final int? max;',
      ),
      VDocApiMember(
        name: 'min',
        kind: 'field',
        signature: 'final int min;',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<int> onChanged;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'size',
        kind: 'field',
        signature: 'final VControlSize size;',
      ),
      VDocApiMember(
        name: 'step',
        kind: 'field',
        signature: 'final int step;',
      ),
      VDocApiMember(
        name: 'value',
        kind: 'field',
        signature: 'final int value;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VNumberBox> createState() => _VNumberBoxState();',
      ),
    ],
  ),
  'VOutlinedAppearance': VDocApiSymbol(
    name: 'VOutlinedAppearance',
    kind: 'class',
    library: 'lib/src/theme/v_appearance.dart',
    members: [
      VDocApiMember(
        name: 'VOutlinedAppearance',
        kind: 'constructor',
        signature: 'const VOutlinedAppearance();',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'method',
        signature: 'Color background(Color base, Set<WidgetState> states) {',
      ),
      VDocApiMember(
        name: 'borderColor',
        kind: 'method',
        signature: 'Color borderColor(Color base, Set<WidgetState> states) {',
      ),
      VDocApiMember(
        name: 'borderWidth',
        kind: 'method',
        signature: 'double? borderWidth(double? base) => (base ?? 1.0) * 1.5;',
      ),
      VDocApiMember(
        name: 'foreground',
        kind: 'method',
        signature: 'Color foreground(Color base, Set<WidgetState> states, [Color? semantic]) {',
      ),
      VDocApiMember(
        name: 'shadows',
        kind: 'method',
        signature: 'List<BoxShadow> shadows(List<BoxShadow> base) => const [];',
      ),
    ],
  ),
  'VOverlay': VDocApiSymbol(
    name: 'VOverlay',
    kind: 'class',
    library: 'lib/src/foundation/overlay.dart',
    members: [
      VDocApiMember(
        name: 'maybeOf',
        kind: 'method',
        signature: 'static VOverlayController? maybeOf(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VOverlayController of(BuildContext context) {',
      ),
    ],
  ),
  'VOverlayAnimation': VDocApiSymbol(
    name: 'VOverlayAnimation',
    kind: 'class',
    library: 'lib/src/theme/v_overlay_animation.dart',
    members: [
      VDocApiMember(
        name: 'VOverlayAnimation',
        kind: 'constructor',
        signature: 'const VOverlayAnimation({',
      ),
      VDocApiMember(
        name: 'motionSpec',
        kind: 'field',
        signature: 'final VMotionSpec motionSpec;',
      ),
      VDocApiMember(
        name: 'onReverseComplete',
        kind: 'field',
        signature: 'final VoidCallback? onReverseComplete;',
      ),
      VDocApiMember(
        name: 'Function',
        kind: 'method',
        signature: 'final Widget Function(',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VOverlayAnimation> createState() => _VOverlayAnimationState();',
      ),
    ],
  ),
  'VOverlayBarrierMode': VDocApiSymbol(
    name: 'VOverlayBarrierMode',
    kind: 'enum',
    library: 'lib/src/app/v_overlay_presenter.dart',
    members: [
      VDocApiMember(
        name: 'none',
        kind: 'value',
        signature: 'none',
      ),
      VDocApiMember(
        name: 'modal',
        kind: 'value',
        signature: 'modal',
      ),
      VDocApiMember(
        name: 'blurred',
        kind: 'value',
        signature: 'blurred',
      ),
    ],
  ),
  'VOverlayController': VDocApiSymbol(
    name: 'VOverlayController',
    kind: 'class',
    library: 'lib/src/foundation/overlay.dart',
    members: [
      VDocApiMember(
        name: 'show',
        kind: 'method',
        signature: 'VOverlayHandle show(',
      ),
      VDocApiMember(
        name: 'showToast',
        kind: 'method',
        signature: 'VToastHandle showToast(',
      ),
    ],
  ),
  'VOverlayControllerScope': VDocApiSymbol(
    name: 'VOverlayControllerScope',
    kind: 'class',
    library: 'lib/src/foundation/overlay.dart',
    members: [
      VDocApiMember(
        name: 'VOverlayControllerScope',
        kind: 'constructor',
        signature: 'const VOverlayControllerScope({',
      ),
      VDocApiMember(
        name: 'controller',
        kind: 'field',
        signature: 'final VOverlayController controller;',
      ),
      VDocApiMember(
        name: 'maybeOf',
        kind: 'method',
        signature: 'static VOverlayController? maybeOf(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VOverlayController of(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'updateShouldNotify',
        kind: 'method',
        signature: 'bool updateShouldNotify(VOverlayControllerScope oldWidget) =>',
      ),
    ],
  ),
  'VOverlayEntryBuilder': VDocApiSymbol(
    name: 'VOverlayEntryBuilder',
    kind: 'typedef',
    library: 'lib/src/foundation/overlay.dart',
    members: [
      VDocApiMember(
        name: 'VOverlayEntryBuilder',
        kind: 'typedef',
        signature: 'typedef VOverlayEntryBuilder = Widget Function(',
      ),
    ],
  ),
  'VOverlayHandle': VDocApiSymbol(
    name: 'VOverlayHandle',
    kind: 'class',
    library: 'lib/src/foundation/overlay.dart',
    members: [
      VDocApiMember(
        name: 'mounted',
        kind: 'field',
        signature: 'bool get mounted;',
      ),
      VDocApiMember(
        name: 'markNeedsBuild',
        kind: 'method',
        signature: 'void markNeedsBuild();',
      ),
      VDocApiMember(
        name: 'remove',
        kind: 'method',
        signature: 'void remove();',
      ),
    ],
  ),
  'VOverlayHost': VDocApiSymbol(
    name: 'VOverlayHost',
    kind: 'class',
    library: 'lib/src/app/v_overlay_host.dart',
    members: [
      VDocApiMember(
        name: 'VOverlayHost',
        kind: 'constructor',
        signature: 'const VOverlayHost({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'textDirection',
        kind: 'field',
        signature: 'final TextDirection textDirection;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VOverlayHost> createState() => VOverlayHostState();',
      ),
    ],
  ),
  'VOverlayHostState': VDocApiSymbol(
    name: 'VOverlayHostState',
    kind: 'class',
    library: 'lib/src/app/v_overlay_host.dart',
    members: [
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'dispose',
        kind: 'method',
        signature: 'void dispose() {',
      ),
      VDocApiMember(
        name: 'initState',
        kind: 'method',
        signature: 'void initState() {',
      ),
      VDocApiMember(
        name: 'show',
        kind: 'method',
        signature: 'VOverlayHandle show(',
      ),
      VDocApiMember(
        name: 'showToast',
        kind: 'method',
        signature: 'VToastHandle showToast(',
      ),
    ],
  ),
  'VOverlayPresentation': VDocApiSymbol(
    name: 'VOverlayPresentation',
    kind: 'class',
    library: 'lib/src/app/v_overlay_presenter.dart',
    members: [
      VDocApiMember(
        name: 'closed',
        kind: 'field',
        signature: 'Future<void> get closed => _completer.future;',
      ),
      VDocApiMember(
        name: 'dismiss',
        kind: 'method',
        signature: 'void dismiss() {',
      ),
    ],
  ),
  'VOverlayPresenter': VDocApiSymbol(
    name: 'VOverlayPresenter',
    kind: 'class',
    library: 'lib/src/app/v_overlay_presenter.dart',
    members: [
      VDocApiMember(
        name: 'show',
        kind: 'method',
        signature: 'static VOverlayPresentation show({',
      ),
    ],
  ),
  'VOverlayPresenterConfig': VDocApiSymbol(
    name: 'VOverlayPresenterConfig',
    kind: 'class',
    library: 'lib/src/app/v_overlay_presenter.dart',
    members: [
      VDocApiMember(
        name: 'VOverlayPresenterConfig',
        kind: 'constructor',
        signature: 'const VOverlayPresenterConfig({',
      ),
      VDocApiMember(
        name: 'autoDismissAfter',
        kind: 'field',
        signature: 'final Duration? autoDismissAfter;',
      ),
      VDocApiMember(
        name: 'barrierColor',
        kind: 'field',
        signature: 'final Color? barrierColor;',
      ),
      VDocApiMember(
        name: 'barrierDismissible',
        kind: 'field',
        signature: 'final bool barrierDismissible;',
      ),
      VDocApiMember(
        name: 'barrierMode',
        kind: 'field',
        signature: 'final VOverlayBarrierMode barrierMode;',
      ),
      VDocApiMember(
        name: 'dismissOnEscape',
        kind: 'field',
        signature: 'final bool dismissOnEscape;',
      ),
      VDocApiMember(
        name: 'maintainState',
        kind: 'field',
        signature: 'final bool maintainState;',
      ),
      VDocApiMember(
        name: 'motionSpec',
        kind: 'field',
        signature: 'final VMotionSpec? motionSpec;',
      ),
      VDocApiMember(
        name: 'saveAndRestoreFocus',
        kind: 'field',
        signature: 'final bool saveAndRestoreFocus;',
      ),
    ],
  ),
  'VPageEllipsis': VDocApiSymbol(
    name: 'VPageEllipsis',
    kind: 'class',
    library: 'lib/src/widgets/navigation/v_pagination.dart',
    members: [
      VDocApiMember(
        name: 'VPageEllipsis',
        kind: 'constructor',
        signature: 'const VPageEllipsis();',
      ),
    ],
  ),
  'VPageItem': VDocApiSymbol(
    name: 'VPageItem',
    kind: 'class',
    library: 'lib/src/widgets/navigation/v_pagination.dart',
    members: [
      VDocApiMember(
        name: 'VPageItem',
        kind: 'constructor',
        signature: 'const VPageItem();',
      ),
    ],
  ),
  'VPageNumber': VDocApiSymbol(
    name: 'VPageNumber',
    kind: 'class',
    library: 'lib/src/widgets/navigation/v_pagination.dart',
    members: [
      VDocApiMember(
        name: 'VPageNumber',
        kind: 'constructor',
        signature: 'const VPageNumber({required this.page, required this.isCurrent});',
      ),
      VDocApiMember(
        name: 'isCurrent',
        kind: 'field',
        signature: 'final bool isCurrent;',
      ),
      VDocApiMember(
        name: 'page',
        kind: 'field',
        signature: 'final int page;',
      ),
    ],
  ),
  'VPageRoute': VDocApiSymbol(
    name: 'VPageRoute',
    kind: 'class',
    library: 'lib/src/app/v_page_route.dart',
    members: [
      VDocApiMember(
        name: 'VPageRoute',
        kind: 'constructor',
        signature: 'VPageRoute({',
      ),
      VDocApiMember(
        name: 'routeController',
        kind: 'field',
        signature: 'AnimationController get routeController => controller as AnimationController;',
      ),
    ],
  ),
  'VPageTransition': VDocApiSymbol(
    name: 'VPageTransition',
    kind: 'enum',
    library: 'lib/src/foundation/motion.dart',
    members: [
      VDocApiMember(
        name: 'none',
        kind: 'value',
        signature: 'none',
      ),
      VDocApiMember(
        name: 'fade',
        kind: 'value',
        signature: 'fade',
      ),
      VDocApiMember(
        name: 'slide',
        kind: 'value',
        signature: 'slide',
      ),
      VDocApiMember(
        name: 'slideFade',
        kind: 'value',
        signature: 'slideFade',
      ),
      VDocApiMember(
        name: 'scaleFade',
        kind: 'value',
        signature: 'scaleFade',
      ),
      VDocApiMember(
        name: 'iosDepthSlide',
        kind: 'value',
        signature: 'iosDepthSlide',
      ),
      VDocApiMember(
        name: 'sharedAxisX',
        kind: 'value',
        signature: 'sharedAxisX',
      ),
      VDocApiMember(
        name: 'sharedAxisY',
        kind: 'value',
        signature: 'sharedAxisY',
      ),
      VDocApiMember(
        name: 'sharedAxisZ',
        kind: 'value',
        signature: 'sharedAxisZ',
      ),
      VDocApiMember(
        name: 'zoomUpReveal',
        kind: 'value',
        signature: 'zoomUpReveal',
      ),
      VDocApiMember(
        name: 'perspective3D',
        kind: 'value',
        signature: 'perspective3D',
      ),
      VDocApiMember(
        name: 'adaptive',
        kind: 'value',
        signature: 'adaptive',
      ),
    ],
  ),
  'VPagination': VDocApiSymbol(
    name: 'VPagination',
    kind: 'class',
    library: 'lib/src/widgets/navigation/v_pagination.dart',
    members: [
      VDocApiMember(
        name: 'VPagination',
        kind: 'constructor',
        signature: 'const VPagination({',
      ),
      VDocApiMember(
        name: 'boundaryCount',
        kind: 'field',
        signature: 'final int boundaryCount;',
      ),
      VDocApiMember(
        name: 'currentPage',
        kind: 'field',
        signature: 'final int currentPage;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'onPageChanged',
        kind: 'field',
        signature: 'final ValueChanged<int> onPageChanged;',
      ),
      VDocApiMember(
        name: 'showArrows',
        kind: 'field',
        signature: 'final bool showArrows;',
      ),
      VDocApiMember(
        name: 'siblingCount',
        kind: 'field',
        signature: 'final int siblingCount;',
      ),
      VDocApiMember(
        name: 'totalPages',
        kind: 'field',
        signature: 'final int totalPages;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VPlatformBehavior': VDocApiSymbol(
    name: 'VPlatformBehavior',
    kind: 'class',
    library: 'lib/src/foundation/v_platform.dart',
    members: [
      VDocApiMember(
        name: 'VPlatformBehavior',
        kind: 'constructor',
        signature: 'const VPlatformBehavior();',
      ),
      VDocApiMember(
        name: 'VPlatformBehavior.desktop',
        kind: 'constructor',
        signature: 'factory VPlatformBehavior.desktop({required bool isApple}) =>',
      ),
      VDocApiMember(
        name: 'VPlatformBehavior.mobile',
        kind: 'constructor',
        signature: 'factory VPlatformBehavior.mobile({required bool isApple}) =>',
      ),
      VDocApiMember(
        name: 'VPlatformBehavior.resolve',
        kind: 'constructor',
        signature: 'factory VPlatformBehavior.resolve(TargetPlatform platform) => switch (platform) {',
      ),
      VDocApiMember(
        name: 'hasHapticFeedback',
        kind: 'field',
        signature: 'bool get hasHapticFeedback;',
      ),
      VDocApiMember(
        name: 'hasHoverCapability',
        kind: 'field',
        signature: 'bool get hasHoverCapability;',
      ),
      VDocApiMember(
        name: 'isApple',
        kind: 'field',
        signature: 'bool get isApple;',
      ),
      VDocApiMember(
        name: 'isDesktop',
        kind: 'field',
        signature: 'bool get isDesktop;',
      ),
      VDocApiMember(
        name: 'selectionMenuItemHeight',
        kind: 'field',
        signature: 'double get selectionMenuItemHeight;',
      ),
      VDocApiMember(
        name: 'selectionMenuRadius',
        kind: 'field',
        signature: 'double get selectionMenuRadius;',
      ),
      VDocApiMember(
        name: 'shortcutModifier',
        kind: 'field',
        signature: 'String get shortcutModifier;',
      ),
    ],
  ),
  'VPlatformScope': VDocApiSymbol(
    name: 'VPlatformScope',
    kind: 'class',
    library: 'lib/src/foundation/v_platform.dart',
    members: [
      VDocApiMember(
        name: 'VPlatformScope',
        kind: 'constructor',
        signature: 'const VPlatformScope({',
      ),
      VDocApiMember(
        name: 'behavior',
        kind: 'field',
        signature: 'final VPlatformBehavior behavior;',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VPlatformBehavior of(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'updateShouldNotify',
        kind: 'method',
        signature: 'bool updateShouldNotify(VPlatformScope oldWidget) =>',
      ),
    ],
  ),
  'VPopover': VDocApiSymbol(
    name: 'VPopover',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_popover.dart',
    members: [
      VDocApiMember(
        name: 'VPopover',
        kind: 'constructor',
        signature: 'const VPopover({',
      ),
      VDocApiMember(
        name: 'contentBuilder',
        kind: 'field',
        signature: 'final VPopoverContentBuilder contentBuilder;',
      ),
      VDocApiMember(
        name: 'controller',
        kind: 'field',
        signature: 'final VPopoverController? controller;',
      ),
      VDocApiMember(
        name: 'desiredHeight',
        kind: 'field',
        signature: 'final double? desiredHeight;',
      ),
      VDocApiMember(
        name: 'desiredWidth',
        kind: 'field',
        signature: 'final double? desiredWidth;',
      ),
      VDocApiMember(
        name: 'gap',
        kind: 'field',
        signature: 'final double? gap;',
      ),
      VDocApiMember(
        name: 'matchTriggerWidth',
        kind: 'field',
        signature: 'final bool matchTriggerWidth;',
      ),
      VDocApiMember(
        name: 'placement',
        kind: 'field',
        signature: 'final VAnchoredOverlayPlacement placement;',
      ),
      VDocApiMember(
        name: 'triggerBuilder',
        kind: 'field',
        signature: 'final VPopoverTriggerBuilder triggerBuilder;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VPopover> createState() => _VPopoverState();',
      ),
      VDocApiMember(
        name: 'show',
        kind: 'method',
        signature: 'static VOverlayHandle show(',
      ),
    ],
  ),
  'VPopoverContentBuilder': VDocApiSymbol(
    name: 'VPopoverContentBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/overlays/v_popover.dart',
    members: [
      VDocApiMember(
        name: 'VPopoverContentBuilder',
        kind: 'typedef',
        signature: 'typedef VPopoverContentBuilder = Widget Function(',
      ),
    ],
  ),
  'VPopoverController': VDocApiSymbol(
    name: 'VPopoverController',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_popover.dart',
    members: [
      VDocApiMember(
        name: 'isOpen',
        kind: 'field',
        signature: 'bool get isOpen => _isOpen;',
      ),
      VDocApiMember(
        name: 'close',
        kind: 'method',
        signature: 'void close() {',
      ),
      VDocApiMember(
        name: 'open',
        kind: 'method',
        signature: 'void open() {',
      ),
      VDocApiMember(
        name: 'toggle',
        kind: 'method',
        signature: 'void toggle() {',
      ),
    ],
  ),
  'VPopoverTriggerBuilder': VDocApiSymbol(
    name: 'VPopoverTriggerBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/overlays/v_popover.dart',
    members: [
      VDocApiMember(
        name: 'VPopoverTriggerBuilder',
        kind: 'typedef',
        signature: 'typedef VPopoverTriggerBuilder = Widget Function(',
      ),
    ],
  ),
  'VPrimitiveColors': VDocApiSymbol(
    name: 'VPrimitiveColors',
    kind: 'class',
    library: 'lib/src/foundation/primitive_tokens.dart',
    members: [
      VDocApiMember(
        name: 'amber300',
        kind: 'method',
        signature: 'static const Color amber300 = Color(0xFFFCD34D); // oklch(84.1% 0.150 75)',
      ),
      VDocApiMember(
        name: 'amber400',
        kind: 'method',
        signature: 'static const Color amber400 = Color(0xFFFBBF24); // oklch(78.5% 0.180 75)',
      ),
      VDocApiMember(
        name: 'amber50',
        kind: 'method',
        signature: 'static const Color amber50  = Color(0xFFFFFBEB); // oklch(98.2% 0.015 75)',
      ),
      VDocApiMember(
        name: 'amber600',
        kind: 'method',
        signature: 'static const Color amber600 = Color(0xFFD97706); // oklch(60.2% 0.160 75)',
      ),
      VDocApiMember(
        name: 'amber700',
        kind: 'method',
        signature: 'static const Color amber700 = Color(0xFFB45309); // oklch(49.1% 0.140 75)',
      ),
      VDocApiMember(
        name: 'amber950',
        kind: 'method',
        signature: 'static const Color amber950 = Color(0xFF451A03); // oklch(20.5% 0.070 75)',
      ),
      VDocApiMember(
        name: 'black',
        kind: 'method',
        signature: 'static const Color black = Color(0xFF0A0B0D); // oklch(8% 0.01 261)',
      ),
      VDocApiMember(
        name: 'blue400',
        kind: 'method',
        signature: 'static const Color blue400 = Color(0xFF60A5FA); // oklch(72.7% 0.147 261.2)',
      ),
      VDocApiMember(
        name: 'blue50',
        kind: 'method',
        signature: 'static const Color blue50  = Color(0xFFEFF6FF); // oklch(96.5% 0.021 261.2)',
      ),
      VDocApiMember(
        name: 'blue500',
        kind: 'method',
        signature: 'static const Color blue500 = Color(0xFF3B82F6); // oklch(62.3% 0.186 261.2)',
      ),
      VDocApiMember(
        name: 'blue600',
        kind: 'method',
        signature: 'static const Color blue600 = Color(0xFF2563EB); // oklch(55.2% 0.195 261.2)',
      ),
      VDocApiMember(
        name: 'blue700',
        kind: 'method',
        signature: 'static const Color blue700 = Color(0xFF1D4ED8); // oklch(47.3% 0.195 261.2)',
      ),
      VDocApiMember(
        name: 'blue800',
        kind: 'method',
        signature: 'static const Color blue800 = Color(0xFF1E40AF); // oklch(37.5% 0.158 261.2)',
      ),
      VDocApiMember(
        name: 'gray100',
        kind: 'method',
        signature: 'static const Color gray100 = Color(0xFFF3F4F6); // oklch(96.2% 0.006 261)',
      ),
      VDocApiMember(
        name: 'gray200',
        kind: 'method',
        signature: 'static const Color gray200 = Color(0xFFE5E7EB); // oklch(91.7% 0.006 261)',
      ),
      VDocApiMember(
        name: 'gray300',
        kind: 'method',
        signature: 'static const Color gray300 = Color(0xFFD1D5DB); // oklch(85.4% 0.006 261)',
      ),
      VDocApiMember(
        name: 'gray400',
        kind: 'method',
        signature: 'static const Color gray400 = Color(0xFF9CA3AF); // oklch(68.5% 0.006 261)',
      ),
      VDocApiMember(
        name: 'gray50',
        kind: 'method',
        signature: 'static const Color gray50  = Color(0xFFF9FAFB); // oklch(98.1% 0.006 261)',
      ),
      VDocApiMember(
        name: 'gray500',
        kind: 'method',
        signature: 'static const Color gray500 = Color(0xFF6B7280); // oklch(52.7% 0.006 261)',
      ),
      VDocApiMember(
        name: 'gray600',
        kind: 'method',
        signature: 'static const Color gray600 = Color(0xFF4B5563); // oklch(42.5% 0.006 261)',
      ),
      VDocApiMember(
        name: 'gray700',
        kind: 'method',
        signature: 'static const Color gray700 = Color(0xFF374151); // oklch(34.8% 0.006 261)',
      ),
      VDocApiMember(
        name: 'gray800',
        kind: 'method',
        signature: 'static const Color gray800 = Color(0xFF1F2937); // oklch(25.4% 0.006 261)',
      ),
      VDocApiMember(
        name: 'gray900',
        kind: 'method',
        signature: 'static const Color gray900 = Color(0xFF111827); // oklch(18.5% 0.006 261)',
      ),
      VDocApiMember(
        name: 'gray950',
        kind: 'method',
        signature: 'static const Color gray950 = Color(0xFF030712); // oklch(11.2% 0.006 261)',
      ),
      VDocApiMember(
        name: 'green400',
        kind: 'method',
        signature: 'static const Color green400 = Color(0xFF4ADE80); // oklch(79.5% 0.170 145)',
      ),
      VDocApiMember(
        name: 'green50',
        kind: 'method',
        signature: 'static const Color green50  = Color(0xFFF0FDF4); // oklch(97.2% 0.015 145)',
      ),
      VDocApiMember(
        name: 'green500',
        kind: 'method',
        signature: 'static const Color green500 = Color(0xFF22C55E); // oklch(69.8% 0.200 145)',
      ),
      VDocApiMember(
        name: 'green600',
        kind: 'method',
        signature: 'static const Color green600 = Color(0xFF16A34A); // oklch(60.2% 0.180 145)',
      ),
      VDocApiMember(
        name: 'green700',
        kind: 'method',
        signature: 'static const Color green700 = Color(0xFF15803D); // oklch(49.1% 0.150 145)',
      ),
      VDocApiMember(
        name: 'green950',
        kind: 'method',
        signature: 'static const Color green950 = Color(0xFF052E16); // oklch(18.5% 0.070 145)',
      ),
      VDocApiMember(
        name: 'red200',
        kind: 'method',
        signature: 'static const Color red200 = Color(0xFFFECACA); // oklch(83.2% 0.085 25)',
      ),
      VDocApiMember(
        name: 'red300',
        kind: 'method',
        signature: 'static const Color red300 = Color(0xFFF87171); // oklch(65.4% 0.170 25)',
      ),
      VDocApiMember(
        name: 'red50',
        kind: 'method',
        signature: 'static const Color red50  = Color(0xFFFEF2F2); // oklch(96.5% 0.015 25)',
      ),
      VDocApiMember(
        name: 'red500',
        kind: 'method',
        signature: 'static const Color red500 = Color(0xFFEF4444); // oklch(57.1% 0.220 25)',
      ),
      VDocApiMember(
        name: 'red600',
        kind: 'method',
        signature: 'static const Color red600 = Color(0xFFDC2626); // oklch(49.8% 0.210 25)',
      ),
      VDocApiMember(
        name: 'red950',
        kind: 'method',
        signature: 'static const Color red950 = Color(0xFF450A0A); // oklch(16.5% 0.080 25)',
      ),
      VDocApiMember(
        name: 'transparent',
        kind: 'method',
        signature: 'static const Color transparent = Color(0x00000000);',
      ),
      VDocApiMember(
        name: 'white',
        kind: 'method',
        signature: 'static const Color white = Color(0xFFFEFBFF); // oklch(100% 0.005 261)',
      ),
    ],
  ),
  'VProgressBar': VDocApiSymbol(
    name: 'VProgressBar',
    kind: 'class',
    library: 'lib/src/widgets/feedback/v_progress.dart',
    members: [
      VDocApiMember(
        name: 'VProgressBar',
        kind: 'constructor',
        signature: 'const VProgressBar({',
      ),
      VDocApiMember(
        name: 'backgroundColor',
        kind: 'field',
        signature: 'final Color? backgroundColor;',
      ),
      VDocApiMember(
        name: 'foregroundColor',
        kind: 'field',
        signature: 'final Color? foregroundColor;',
      ),
      VDocApiMember(
        name: 'height',
        kind: 'field',
        signature: 'final double height;',
      ),
      VDocApiMember(
        name: 'value',
        kind: 'field',
        signature: 'final double? value;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VRadii': VDocApiSymbol(
    name: 'VRadii',
    kind: 'class',
    library: 'lib/src/foundation/radii.dart',
    members: [
      VDocApiMember(
        name: 'VRadii',
        kind: 'constructor',
        signature: 'const VRadii({',
      ),
      VDocApiMember(
        name: 'VRadii.defaults',
        kind: 'constructor',
        signature: 'factory VRadii.defaults() {',
      ),
      VDocApiMember(
        name: 'full',
        kind: 'field',
        signature: 'final double full;',
      ),
      VDocApiMember(
        name: 'lg',
        kind: 'field',
        signature: 'final double lg;',
      ),
      VDocApiMember(
        name: 'md',
        kind: 'field',
        signature: 'final double md;',
      ),
      VDocApiMember(
        name: 'sm',
        kind: 'field',
        signature: 'final double sm;',
      ),
      VDocApiMember(
        name: 'xl',
        kind: 'field',
        signature: 'final double xl;',
      ),
      VDocApiMember(
        name: 'xs',
        kind: 'field',
        signature: 'final double xs;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VRadii copyWith({',
      ),
      VDocApiMember(
        name: 'debugFillProperties',
        kind: 'method',
        signature: 'void debugFillProperties(DiagnosticPropertiesBuilder properties) {',
      ),
      VDocApiMember(
        name: 'hashCode',
        kind: 'method',
        signature: 'int get hashCode => _\$VRadiiHash(this);',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VRadii lerp(VRadii a, VRadii b, double t) =>',
      ),
      VDocApiMember(
        name: 'operator',
        kind: 'method',
        signature: 'bool operator ==(Object other) => _\$VRadiiEq(this, other);',
      ),
    ],
  ),
  'VRadio': VDocApiSymbol(
    name: 'VRadio',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_radio.dart',
    members: [
      VDocApiMember(
        name: 'VRadio',
        kind: 'constructor',
        signature: 'const VRadio({',
      ),
      VDocApiMember(
        name: 'autofocus',
        kind: 'field',
        signature: 'final bool autofocus;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'focusNode',
        kind: 'field',
        signature: 'final FocusNode? focusNode;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String? label;',
      ),
      VDocApiMember(
        name: 'onSelected',
        kind: 'field',
        signature: 'final VoidCallback? onSelected;',
      ),
      VDocApiMember(
        name: 'selected',
        kind: 'field',
        signature: 'final bool selected;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'value',
        kind: 'field',
        signature: 'final T? value;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VRadioGroup': VDocApiSymbol(
    name: 'VRadioGroup',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_radio.dart',
    members: [
      VDocApiMember(
        name: 'VRadioGroup',
        kind: 'constructor',
        signature: 'const VRadioGroup({',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<T> onChanged;',
      ),
      VDocApiMember(
        name: 'value',
        kind: 'field',
        signature: 'final T? value;',
      ),
      VDocApiMember(
        name: 'updateShouldNotify',
        kind: 'method',
        signature: 'bool updateShouldNotify(VRadioGroup<T> oldWidget) =>',
      ),
    ],
  ),
  'VRadioTheme': VDocApiSymbol(
    name: 'VRadioTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VRadioTheme',
        kind: 'constructor',
        signature: 'const VRadioTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VRadioTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VRadioTokens': VDocApiSymbol(
    name: 'VRadioTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_radio_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VRadioTokens',
        kind: 'constructor',
        signature: 'const VRadioTokens({',
      ),
      VDocApiMember(
        name: 'VRadioTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VRadioTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'checkedBorder',
        kind: 'field',
        signature: 'final Color checkedBorder;',
      ),
      VDocApiMember(
        name: 'checkedDot',
        kind: 'field',
        signature: 'final Color checkedDot;',
      ),
      VDocApiMember(
        name: 'focusRing',
        kind: 'field',
        signature: 'final Color focusRing;',
      ),
      VDocApiMember(
        name: 'uncheckedBackground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> uncheckedBackground;',
      ),
      VDocApiMember(
        name: 'uncheckedBorder',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> uncheckedBorder;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VRadioTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VRadioTokens lerp(VRadioTokens a, VRadioTokens b, double t) {',
      ),
    ],
  ),
  'VResizable': VDocApiSymbol(
    name: 'VResizable',
    kind: 'class',
    library: 'lib/src/widgets/layout/v_resizable.dart',
    members: [
      VDocApiMember(
        name: 'VResizable',
        kind: 'constructor',
        signature: 'const VResizable({',
      ),
      VDocApiMember(
        name: 'VResizable.positioned',
        kind: 'constructor',
        signature: 'const VResizable.positioned({',
      ),
      VDocApiMember(
        name: 'boundaryBehavior',
        kind: 'field',
        signature: 'final VResizeBoundaryBehavior boundaryBehavior;',
      ),
      VDocApiMember(
        name: 'boundaryPadding',
        kind: 'field',
        signature: 'final EdgeInsets boundaryPadding;',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'constrainToParent',
        kind: 'field',
        signature: 'final bool constrainToParent;',
      ),
      VDocApiMember(
        name: 'constraints',
        kind: 'field',
        signature: 'final BoxConstraints constraints;',
      ),
      VDocApiMember(
        name: 'enabledHandles',
        kind: 'field',
        signature: 'final Set<VResizeHandle> enabledHandles;',
      ),
      VDocApiMember(
        name: 'handleBuilder',
        kind: 'field',
        signature: 'final VResizeHandleBuilder? handleBuilder;',
      ),
      VDocApiMember(
        name: 'handleHitSize',
        kind: 'field',
        signature: 'final double? handleHitSize;',
      ),
      VDocApiMember(
        name: 'handleSize',
        kind: 'field',
        signature: 'final double? handleSize;',
      ),
      VDocApiMember(
        name: 'initialSize',
        kind: 'field',
        signature: 'final Size? initialSize;',
      ),
      VDocApiMember(
        name: 'onRectChanged',
        kind: 'field',
        signature: 'final ValueChanged<Rect>? onRectChanged;',
      ),
      VDocApiMember(
        name: 'onResizeEnd',
        kind: 'field',
        signature: 'final ValueChanged<VResizeEndDetails>? onResizeEnd;',
      ),
      VDocApiMember(
        name: 'onResizeStart',
        kind: 'field',
        signature: 'final ValueChanged<VResizeStartDetails>? onResizeStart;',
      ),
      VDocApiMember(
        name: 'onResizeUpdate',
        kind: 'field',
        signature: 'final ValueChanged<VResizeUpdateDetails>? onResizeUpdate;',
      ),
      VDocApiMember(
        name: 'onSizeChanged',
        kind: 'field',
        signature: 'final ValueChanged<Size>? onSizeChanged;',
      ),
      VDocApiMember(
        name: 'rect',
        kind: 'field',
        signature: 'final Rect? rect;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'showHandles',
        kind: 'field',
        signature: 'final bool showHandles;',
      ),
      VDocApiMember(
        name: 'size',
        kind: 'field',
        signature: 'final Size? size;',
      ),
      VDocApiMember(
        name: 'Function',
        kind: 'method',
        signature: 'final Widget Function(BuildContext, Size, VResizeHandle?, Widget)?',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VResizable> createState() => _VResizableState();',
      ),
    ],
  ),
  'VResponsive': VDocApiSymbol(
    name: 'VResponsive',
    kind: 'class',
    library: 'lib/src/theme/v_screen.dart',
    members: [
    ],
  ),
  'VRichText': VDocApiSymbol(
    name: 'VRichText',
    kind: 'class',
    library: 'lib/src/widgets/basic/v_rich_text.dart',
    members: [
      VDocApiMember(
        name: 'VRichText',
        kind: 'constructor',
        signature: 'const VRichText({',
      ),
      VDocApiMember(
        name: 'alignment',
        kind: 'field',
        signature: 'final TextAlign alignment;',
      ),
      VDocApiMember(
        name: 'maxLines',
        kind: 'field',
        signature: 'final int? maxLines;',
      ),
      VDocApiMember(
        name: 'overflow',
        kind: 'field',
        signature: 'final TextOverflow overflow;',
      ),
      VDocApiMember(
        name: 'spans',
        kind: 'field',
        signature: 'final List<VTextSpan> spans;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VRouteAdapter': VDocApiSymbol(
    name: 'VRouteAdapter',
    kind: 'class',
    library: 'lib/src/app/v_route_adapter.dart',
    members: [
      VDocApiMember(
        name: 'VRouteAdapter',
        kind: 'constructor',
        signature: 'const VRouteAdapter();',
      ),
      VDocApiMember(
        name: 'buildApp',
        kind: 'method',
        signature: 'Widget buildApp({',
      ),
    ],
  ),
  'VRouterConfigAdapter': VDocApiSymbol(
    name: 'VRouterConfigAdapter',
    kind: 'class',
    library: 'lib/src/app/v_router_config_adapter.dart',
    members: [
      VDocApiMember(
        name: 'VRouterConfigAdapter',
        kind: 'constructor',
        signature: 'const VRouterConfigAdapter({',
      ),
      VDocApiMember(
        name: 'routerConfig',
        kind: 'field',
        signature: 'final RouterConfig<Object> routerConfig;',
      ),
      VDocApiMember(
        name: 'buildApp',
        kind: 'method',
        signature: 'Widget buildApp({',
      ),
    ],
  ),
  'VScaffold': VDocApiSymbol(
    name: 'VScaffold',
    kind: 'class',
    library: 'lib/src/widgets/layout/v_scaffold.dart',
    members: [
      VDocApiMember(
        name: 'VScaffold',
        kind: 'constructor',
        signature: 'const VScaffold({',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'field',
        signature: 'final VBackground? background;',
      ),
      VDocApiMember(
        name: 'body',
        kind: 'field',
        signature: 'final Widget body;',
      ),
      VDocApiMember(
        name: 'bottomSheet',
        kind: 'field',
        signature: 'final Widget? bottomSheet;',
      ),
      VDocApiMember(
        name: 'footer',
        kind: 'field',
        signature: 'final Widget? footer;',
      ),
      VDocApiMember(
        name: 'header',
        kind: 'field',
        signature: 'final Widget? header;',
      ),
      VDocApiMember(
        name: 'safeArea',
        kind: 'field',
        signature: 'final bool safeArea;',
      ),
      VDocApiMember(
        name: 'safeAreaBottom',
        kind: 'field',
        signature: 'final bool safeAreaBottom;',
      ),
      VDocApiMember(
        name: 'safeAreaTop',
        kind: 'field',
        signature: 'final bool safeAreaTop;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VScopedTokenOverride': VDocApiSymbol(
    name: 'VScopedTokenOverride',
    kind: 'typedef',
    library: 'lib/src/theme/v_theme.dart',
    members: [
      VDocApiMember(
        name: 'VScopedTokenOverride',
        kind: 'typedef',
        signature: 'typedef VScopedTokenOverride<T> = T Function(VThemeData theme, T tokens);',
      ),
    ],
  ),
  'VScrollArea': VDocApiSymbol(
    name: 'VScrollArea',
    kind: 'class',
    library: 'lib/src/widgets/scrolling/v_scroll_area.dart',
    members: [
      VDocApiMember(
        name: 'VScrollArea',
        kind: 'constructor',
        signature: 'const VScrollArea({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'controller',
        kind: 'field',
        signature: 'final ScrollController? controller;',
      ),
      VDocApiMember(
        name: 'interactiveScrollbar',
        kind: 'field',
        signature: 'final bool interactiveScrollbar;',
      ),
      VDocApiMember(
        name: 'padding',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry? padding;',
      ),
      VDocApiMember(
        name: 'physics',
        kind: 'field',
        signature: 'final ScrollPhysics? physics;',
      ),
      VDocApiMember(
        name: 'scrollDirection',
        kind: 'field',
        signature: 'final Axis scrollDirection;',
      ),
      VDocApiMember(
        name: 'scrollbarPadding',
        kind: 'field',
        signature: 'final EdgeInsets? scrollbarPadding;',
      ),
      VDocApiMember(
        name: 'showScrollbar',
        kind: 'field',
        signature: 'final bool showScrollbar;',
      ),
      VDocApiMember(
        name: 'thumbVisibility',
        kind: 'field',
        signature: 'final bool? thumbVisibility;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VScrollArea> createState() => _VScrollAreaState();',
      ),
    ],
  ),
  'VScrollBehavior': VDocApiSymbol(
    name: 'VScrollBehavior',
    kind: 'class',
    library: 'lib/src/foundation/v_scroll_behavior.dart',
    members: [
      VDocApiMember(
        name: 'VScrollBehavior',
        kind: 'constructor',
        signature: 'const VScrollBehavior();',
      ),
      VDocApiMember(
        name: 'buildOverscrollIndicator',
        kind: 'method',
        signature: 'Widget buildOverscrollIndicator(',
      ),
      VDocApiMember(
        name: 'buildScrollbar',
        kind: 'method',
        signature: 'Widget buildScrollbar(',
      ),
      VDocApiMember(
        name: 'getScrollPhysics',
        kind: 'method',
        signature: 'ScrollPhysics getScrollPhysics(BuildContext context) =>',
      ),
    ],
  ),
  'VScrollableGrid': VDocApiSymbol(
    name: 'VScrollableGrid',
    kind: 'class',
    library: 'lib/src/widgets/data/v_scrollable_grid.dart',
    members: [
      VDocApiMember(
        name: 'VScrollableGrid',
        kind: 'constructor',
        signature: 'const VScrollableGrid({',
      ),
      VDocApiMember(
        name: 'cacheExtent',
        kind: 'field',
        signature: 'final double? cacheExtent;',
      ),
      VDocApiMember(
        name: 'childAspectRatio',
        kind: 'field',
        signature: 'final double childAspectRatio;',
      ),
      VDocApiMember(
        name: 'controller',
        kind: 'field',
        signature: 'final ScrollController? controller;',
      ),
      VDocApiMember(
        name: 'crossAxisCount',
        kind: 'field',
        signature: 'final int crossAxisCount;',
      ),
      VDocApiMember(
        name: 'emptyBuilder',
        kind: 'field',
        signature: 'final WidgetBuilder? emptyBuilder;',
      ),
      VDocApiMember(
        name: 'error',
        kind: 'field',
        signature: 'final Object? error;',
      ),
      VDocApiMember(
        name: 'hasMore',
        kind: 'field',
        signature: 'final bool hasMore;',
      ),
      VDocApiMember(
        name: 'isLoadingMore',
        kind: 'field',
        signature: 'final bool isLoadingMore;',
      ),
      VDocApiMember(
        name: 'itemBuilder',
        kind: 'field',
        signature: 'final VGridItemBuilder<T> itemBuilder;',
      ),
      VDocApiMember(
        name: 'items',
        kind: 'field',
        signature: 'final List<T> items;',
      ),
      VDocApiMember(
        name: 'layout',
        kind: 'field',
        signature: 'final VGridLayout layout;',
      ),
      VDocApiMember(
        name: 'loadMoreThreshold',
        kind: 'field',
        signature: 'final double loadMoreThreshold;',
      ),
      VDocApiMember(
        name: 'loadingMoreBuilder',
        kind: 'field',
        signature: 'final WidgetBuilder? loadingMoreBuilder;',
      ),
      VDocApiMember(
        name: 'noMoreBuilder',
        kind: 'field',
        signature: 'final WidgetBuilder? noMoreBuilder;',
      ),
      VDocApiMember(
        name: 'padding',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry? padding;',
      ),
      VDocApiMember(
        name: 'physics',
        kind: 'field',
        signature: 'final ScrollPhysics? physics;',
      ),
      VDocApiMember(
        name: 'runSpacing',
        kind: 'field',
        signature: 'final double runSpacing;',
      ),
      VDocApiMember(
        name: 'shrinkWrap',
        kind: 'field',
        signature: 'final bool shrinkWrap;',
      ),
      VDocApiMember(
        name: 'spacing',
        kind: 'field',
        signature: 'final double spacing;',
      ),
      VDocApiMember(
        name: 'Function',
        kind: 'method',
        signature: 'final Future<void> Function()? onRefresh;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VScrollableGrid<T>> createState() => _VScrollableGridState<T>();',
      ),
    ],
  ),
  'VScrollableList': VDocApiSymbol(
    name: 'VScrollableList',
    kind: 'class',
    library: 'lib/src/widgets/data/v_scrollable_list.dart',
    members: [
      VDocApiMember(
        name: 'VScrollableList.animatedBuilder',
        kind: 'constructor',
        signature: 'const VScrollableList.animatedBuilder({',
      ),
      VDocApiMember(
        name: 'VScrollableList.builder',
        kind: 'constructor',
        signature: 'const VScrollableList.builder({',
      ),
      VDocApiMember(
        name: 'addAutomaticKeepAlives',
        kind: 'field',
        signature: 'final bool addAutomaticKeepAlives;',
      ),
      VDocApiMember(
        name: 'addRepaintBoundaries',
        kind: 'field',
        signature: 'final bool addRepaintBoundaries;',
      ),
      VDocApiMember(
        name: 'addSemanticIndexes',
        kind: 'field',
        signature: 'final bool addSemanticIndexes;',
      ),
      VDocApiMember(
        name: 'cacheExtent',
        kind: 'field',
        signature: 'final double? cacheExtent;',
      ),
      VDocApiMember(
        name: 'controller',
        kind: 'field',
        signature: 'final ScrollController? controller;',
      ),
      VDocApiMember(
        name: 'hasMore',
        kind: 'field',
        signature: 'final bool hasMore;',
      ),
      VDocApiMember(
        name: 'isLoadingMore',
        kind: 'field',
        signature: 'final bool isLoadingMore;',
      ),
      VDocApiMember(
        name: 'itemBuilder',
        kind: 'field',
        signature: 'final VScrollableListItemBuilder itemBuilder;',
      ),
      VDocApiMember(
        name: 'itemCount',
        kind: 'field',
        signature: 'final int itemCount;',
      ),
      VDocApiMember(
        name: 'listController',
        kind: 'field',
        signature: 'final VScrollableListController? listController;',
      ),
      VDocApiMember(
        name: 'loadMoreBuilder',
        kind: 'field',
        signature: 'final WidgetBuilder? loadMoreBuilder;',
      ),
      VDocApiMember(
        name: 'loadMoreThreshold',
        kind: 'field',
        signature: 'final double loadMoreThreshold;',
      ),
      VDocApiMember(
        name: 'padding',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry? padding;',
      ),
      VDocApiMember(
        name: 'physics',
        kind: 'field',
        signature: 'final ScrollPhysics? physics;',
      ),
      VDocApiMember(
        name: 'refreshBuilder',
        kind: 'field',
        signature: 'final VScrollableListRefreshBuilder? refreshBuilder;',
      ),
      VDocApiMember(
        name: 'refreshTriggerDistance',
        kind: 'field',
        signature: 'final double refreshTriggerDistance;',
      ),
      VDocApiMember(
        name: 'scrollToBottomBuilder',
        kind: 'field',
        signature: 'final VScrollableListScrollButtonBuilder? scrollToBottomBuilder;',
      ),
      VDocApiMember(
        name: 'scrollToTopBuilder',
        kind: 'field',
        signature: 'final VScrollableListScrollButtonBuilder? scrollToTopBuilder;',
      ),
      VDocApiMember(
        name: 'separatorBuilder',
        kind: 'field',
        signature: 'final VScrollableListSeparatorBuilder? separatorBuilder;',
      ),
      VDocApiMember(
        name: 'showScrollToBottomAfter',
        kind: 'field',
        signature: 'final double? showScrollToBottomAfter;',
      ),
      VDocApiMember(
        name: 'showScrollToTopAfter',
        kind: 'field',
        signature: 'final double? showScrollToTopAfter;',
      ),
      VDocApiMember(
        name: 'shrinkWrap',
        kind: 'field',
        signature: 'final bool shrinkWrap;',
      ),
      VDocApiMember(
        name: 'Function',
        kind: 'method',
        signature: 'final Future<void> Function()? onRefresh;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VScrollableList> createState() => _VScrollableListState();',
      ),
    ],
  ),
  'VScrollableListController': VDocApiSymbol(
    name: 'VScrollableListController',
    kind: 'class',
    library: 'lib/src/widgets/data/v_scrollable_list.dart',
    members: [
      VDocApiMember(
        name: 'hasClients',
        kind: 'field',
        signature: 'bool get hasClients => _state?._effectiveController.hasClients ?? false;',
      ),
      VDocApiMember(
        name: 'scrollToBottom',
        kind: 'method',
        signature: 'Future<void> scrollToBottom({',
      ),
      VDocApiMember(
        name: 'scrollToTop',
        kind: 'method',
        signature: 'Future<void> scrollToTop({',
      ),
    ],
  ),
  'VScrollableListItemBuilder': VDocApiSymbol(
    name: 'VScrollableListItemBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/data/v_scrollable_list.dart',
    members: [
      VDocApiMember(
        name: 'VScrollableListItemBuilder',
        kind: 'typedef',
        signature: 'typedef VScrollableListItemBuilder = Widget Function(',
      ),
    ],
  ),
  'VScrollableListRefreshBuilder': VDocApiSymbol(
    name: 'VScrollableListRefreshBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/data/v_scrollable_list.dart',
    members: [
      VDocApiMember(
        name: 'VScrollableListRefreshBuilder',
        kind: 'typedef',
        signature: 'typedef VScrollableListRefreshBuilder = Widget Function(',
      ),
    ],
  ),
  'VScrollableListScrollButtonBuilder': VDocApiSymbol(
    name: 'VScrollableListScrollButtonBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/data/v_scrollable_list.dart',
    members: [
      VDocApiMember(
        name: 'VScrollableListScrollButtonBuilder',
        kind: 'typedef',
        signature: 'typedef VScrollableListScrollButtonBuilder = Widget Function(',
      ),
    ],
  ),
  'VScrollableListSeparatorBuilder': VDocApiSymbol(
    name: 'VScrollableListSeparatorBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/data/v_scrollable_list.dart',
    members: [
      VDocApiMember(
        name: 'VScrollableListSeparatorBuilder',
        kind: 'typedef',
        signature: 'typedef VScrollableListSeparatorBuilder = Widget Function(',
      ),
    ],
  ),
  'VScrollbar': VDocApiSymbol(
    name: 'VScrollbar',
    kind: 'class',
    library: 'lib/src/widgets/scrolling/v_scrollbar.dart',
    members: [
      VDocApiMember(
        name: 'VScrollbar',
        kind: 'constructor',
        signature: 'const VScrollbar({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'controller',
        kind: 'field',
        signature: 'final ScrollController? controller;',
      ),
      VDocApiMember(
        name: 'interactive',
        kind: 'field',
        signature: 'final bool interactive;',
      ),
      VDocApiMember(
        name: 'padding',
        kind: 'field',
        signature: 'final EdgeInsets? padding;',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'field',
        signature: 'final Radius? radius;',
      ),
      VDocApiMember(
        name: 'scrollbarOrientation',
        kind: 'field',
        signature: 'final ScrollbarOrientation? scrollbarOrientation;',
      ),
      VDocApiMember(
        name: 'thickness',
        kind: 'field',
        signature: 'final double? thickness;',
      ),
      VDocApiMember(
        name: 'thumbColor',
        kind: 'field',
        signature: 'final Color? thumbColor;',
      ),
      VDocApiMember(
        name: 'thumbVisibility',
        kind: 'field',
        signature: 'final bool? thumbVisibility;',
      ),
      VDocApiMember(
        name: 'trackColor',
        kind: 'field',
        signature: 'final Color? trackColor;',
      ),
      VDocApiMember(
        name: 'trackVisibility',
        kind: 'field',
        signature: 'final bool? trackVisibility;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VScrollbar> createState() => _VScrollbarState();',
      ),
    ],
  ),
  'VScrollbarTokens': VDocApiSymbol(
    name: 'VScrollbarTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_scrollbar_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VScrollbarTokens',
        kind: 'constructor',
        signature: 'const VScrollbarTokens({',
      ),
      VDocApiMember(
        name: 'VScrollbarTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VScrollbarTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'minThumbLength',
        kind: 'field',
        signature: 'final double minThumbLength;',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'field',
        signature: 'final double radius;',
      ),
      VDocApiMember(
        name: 'thickness',
        kind: 'field',
        signature: 'final double thickness;',
      ),
      VDocApiMember(
        name: 'thicknessHover',
        kind: 'field',
        signature: 'final double thicknessHover;',
      ),
      VDocApiMember(
        name: 'thumbColor',
        kind: 'field',
        signature: 'final Color thumbColor;',
      ),
      VDocApiMember(
        name: 'thumbColorHover',
        kind: 'field',
        signature: 'final Color thumbColorHover;',
      ),
      VDocApiMember(
        name: 'trackColor',
        kind: 'field',
        signature: 'final Color trackColor;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VScrollbarTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VScrollbarTokens lerp(',
      ),
    ],
  ),
  'VSegmentedControl': VDocApiSymbol(
    name: 'VSegmentedControl',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_segmented_control.dart',
    members: [
      VDocApiMember(
        name: 'VSegmentedControl',
        kind: 'constructor',
        signature: 'const VSegmentedControl({',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<T> onChanged;',
      ),
      VDocApiMember(
        name: 'options',
        kind: 'field',
        signature: 'final List<VSegmentedControlOption<T>> options;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'size',
        kind: 'field',
        signature: 'final VControlSize size;',
      ),
      VDocApiMember(
        name: 'value',
        kind: 'field',
        signature: 'final T value;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VSegmentedControl<T>> createState() => _VSegmentedControlState<T>();',
      ),
    ],
  ),
  'VSegmentedControlOption': VDocApiSymbol(
    name: 'VSegmentedControlOption',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_segmented_control.dart',
    members: [
      VDocApiMember(
        name: 'VSegmentedControlOption',
        kind: 'constructor',
        signature: 'const VSegmentedControlOption({',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'icon',
        kind: 'field',
        signature: 'final Widget? icon;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String label;',
      ),
      VDocApiMember(
        name: 'value',
        kind: 'field',
        signature: 'final T value;',
      ),
    ],
  ),
  'VSegmentedControlTheme': VDocApiSymbol(
    name: 'VSegmentedControlTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VSegmentedControlTheme',
        kind: 'constructor',
        signature: 'const VSegmentedControlTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VSegmentedControlTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VSegmentedControlTokens': VDocApiSymbol(
    name: 'VSegmentedControlTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_segmented_control_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VSegmentedControlTokens',
        kind: 'constructor',
        signature: 'const VSegmentedControlTokens({',
      ),
      VDocApiMember(
        name: 'VSegmentedControlTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VSegmentedControlTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> background;',
      ),
      VDocApiMember(
        name: 'border',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> border;',
      ),
      VDocApiMember(
        name: 'focusRing',
        kind: 'field',
        signature: 'final Color focusRing;',
      ),
      VDocApiMember(
        name: 'foreground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> foreground;',
      ),
      VDocApiMember(
        name: 'heightLg',
        kind: 'field',
        signature: 'final double heightLg;',
      ),
      VDocApiMember(
        name: 'heightMd',
        kind: 'field',
        signature: 'final double heightMd;',
      ),
      VDocApiMember(
        name: 'heightSm',
        kind: 'field',
        signature: 'final double heightSm;',
      ),
      VDocApiMember(
        name: 'indicatorBackground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> indicatorBackground;',
      ),
      VDocApiMember(
        name: 'indicatorRadius',
        kind: 'field',
        signature: 'final double indicatorRadius;',
      ),
      VDocApiMember(
        name: 'indicatorShadow',
        kind: 'field',
        signature: 'final List<BoxShadow> indicatorShadow;',
      ),
      VDocApiMember(
        name: 'paddingHorizontalLg',
        kind: 'field',
        signature: 'final double paddingHorizontalLg;',
      ),
      VDocApiMember(
        name: 'paddingHorizontalMd',
        kind: 'field',
        signature: 'final double paddingHorizontalMd;',
      ),
      VDocApiMember(
        name: 'paddingHorizontalSm',
        kind: 'field',
        signature: 'final double paddingHorizontalSm;',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'field',
        signature: 'final double radius;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VSegmentedControlTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VSegmentedControlTokens lerp(',
      ),
    ],
  ),
  'VSelect': VDocApiSymbol(
    name: 'VSelect',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_select.dart',
    members: [
      VDocApiMember(
        name: 'VSelect',
        kind: 'constructor',
        signature: 'const VSelect({',
      ),
      VDocApiMember(
        name: 'VSelect.multiple',
        kind: 'constructor',
        signature: 'const VSelect.multiple({',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'focusNode',
        kind: 'field',
        signature: 'final FocusNode? focusNode;',
      ),
      VDocApiMember(
        name: 'icon',
        kind: 'field',
        signature: 'final Widget? icon;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String? label;',
      ),
      VDocApiMember(
        name: 'maxMenuHeight',
        kind: 'field',
        signature: 'final double maxMenuHeight;',
      ),
      VDocApiMember(
        name: 'menuPlacement',
        kind: 'field',
        signature: 'final VAnchoredOverlayPlacement menuPlacement;',
      ),
      VDocApiMember(
        name: 'multiple',
        kind: 'field',
        signature: 'final bool multiple;',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<T>? onChanged;',
      ),
      VDocApiMember(
        name: 'onChangedMultiple',
        kind: 'field',
        signature: 'final ValueChanged<Set<T>>? onChangedMultiple;',
      ),
      VDocApiMember(
        name: 'onMenuOpenChanged',
        kind: 'field',
        signature: 'final ValueChanged<bool>? onMenuOpenChanged;',
      ),
      VDocApiMember(
        name: 'options',
        kind: 'field',
        signature: 'final List<VSelectOption<T>> options;',
      ),
      VDocApiMember(
        name: 'placeholder',
        kind: 'field',
        signature: 'final String? placeholder;',
      ),
      VDocApiMember(
        name: 'searchable',
        kind: 'field',
        signature: 'final bool searchable;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'value',
        kind: 'field',
        signature: 'final T? value;',
      ),
      VDocApiMember(
        name: 'values',
        kind: 'field',
        signature: 'final Set<T>? values;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VSelect<T>> createState() => _VSelectState<T>();',
      ),
    ],
  ),
  'VSelectOption': VDocApiSymbol(
    name: 'VSelectOption',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_select.dart',
    members: [
      VDocApiMember(
        name: 'VSelectOption',
        kind: 'constructor',
        signature: 'const VSelectOption({',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String label;',
      ),
      VDocApiMember(
        name: 'leading',
        kind: 'field',
        signature: 'final Widget? leading;',
      ),
      VDocApiMember(
        name: 'value',
        kind: 'field',
        signature: 'final T value;',
      ),
    ],
  ),
  'VSelectTheme': VDocApiSymbol(
    name: 'VSelectTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VSelectTheme',
        kind: 'constructor',
        signature: 'const VSelectTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VSelectTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VSelectTokens': VDocApiSymbol(
    name: 'VSelectTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_select_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VSelectTokens',
        kind: 'constructor',
        signature: 'const VSelectTokens({',
      ),
      VDocApiMember(
        name: 'VSelectTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VSelectTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> background;',
      ),
      VDocApiMember(
        name: 'border',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> border;',
      ),
      VDocApiMember(
        name: 'checkboxBorderWidth',
        kind: 'field',
        signature: 'final double checkboxBorderWidth;',
      ),
      VDocApiMember(
        name: 'checkboxSize',
        kind: 'field',
        signature: 'final double checkboxSize;',
      ),
      VDocApiMember(
        name: 'checkmarkSize',
        kind: 'field',
        signature: 'final double checkmarkSize;',
      ),
      VDocApiMember(
        name: 'focusRing',
        kind: 'field',
        signature: 'final Color focusRing;',
      ),
      VDocApiMember(
        name: 'indicatorSize',
        kind: 'field',
        signature: 'final double indicatorSize;',
      ),
      VDocApiMember(
        name: 'itemHeight',
        kind: 'field',
        signature: 'final double itemHeight;',
      ),
      VDocApiMember(
        name: 'itemPaddingHorizontal',
        kind: 'field',
        signature: 'final double itemPaddingHorizontal;',
      ),
      VDocApiMember(
        name: 'itemPaddingVertical',
        kind: 'field',
        signature: 'final double itemPaddingVertical;',
      ),
      VDocApiMember(
        name: 'menuBackground',
        kind: 'field',
        signature: 'final Color menuBackground;',
      ),
      VDocApiMember(
        name: 'menuBorder',
        kind: 'field',
        signature: 'final Color menuBorder;',
      ),
      VDocApiMember(
        name: 'menuBorderWidth',
        kind: 'field',
        signature: 'final double menuBorderWidth;',
      ),
      VDocApiMember(
        name: 'menuDisabledText',
        kind: 'field',
        signature: 'final Color menuDisabledText;',
      ),
      VDocApiMember(
        name: 'menuHover',
        kind: 'field',
        signature: 'final Color menuHover;',
      ),
      VDocApiMember(
        name: 'menuRadius',
        kind: 'field',
        signature: 'final double menuRadius;',
      ),
      VDocApiMember(
        name: 'menuSelectedBackground',
        kind: 'field',
        signature: 'final Color menuSelectedBackground;',
      ),
      VDocApiMember(
        name: 'menuSelectedText',
        kind: 'field',
        signature: 'final Color menuSelectedText;',
      ),
      VDocApiMember(
        name: 'menuText',
        kind: 'field',
        signature: 'final Color menuText;',
      ),
      VDocApiMember(
        name: 'placeholder',
        kind: 'field',
        signature: 'final Color placeholder;',
      ),
      VDocApiMember(
        name: 'searchFieldHeight',
        kind: 'field',
        signature: 'final double searchFieldHeight;',
      ),
      VDocApiMember(
        name: 'text',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> text;',
      ),
      VDocApiMember(
        name: 'triggerBorderWidth',
        kind: 'field',
        signature: 'final double triggerBorderWidth;',
      ),
      VDocApiMember(
        name: 'triggerHeight',
        kind: 'field',
        signature: 'final double triggerHeight;',
      ),
      VDocApiMember(
        name: 'triggerPaddingHorizontal',
        kind: 'field',
        signature: 'final double triggerPaddingHorizontal;',
      ),
      VDocApiMember(
        name: 'triggerPaddingVertical',
        kind: 'field',
        signature: 'final double triggerPaddingVertical;',
      ),
      VDocApiMember(
        name: 'triggerRadius',
        kind: 'field',
        signature: 'final double triggerRadius;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VSelectTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VSelectTokens lerp(VSelectTokens a, VSelectTokens b, double t) {',
      ),
    ],
  ),
  'VSelectableText': VDocApiSymbol(
    name: 'VSelectableText',
    kind: 'class',
    library: 'lib/src/widgets/selection/v_selectable_text.dart',
    members: [
      VDocApiMember(
        name: 'VSelectableText',
        kind: 'constructor',
        signature: 'const VSelectableText(',
      ),
      VDocApiMember(
        name: 'contextMenuBuilder',
        kind: 'field',
        signature: 'final EditableTextContextMenuBuilder? contextMenuBuilder;',
      ),
      VDocApiMember(
        name: 'cursorColor',
        kind: 'field',
        signature: 'final Color? cursorColor;',
      ),
      VDocApiMember(
        name: 'data',
        kind: 'field',
        signature: 'final String data;',
      ),
      VDocApiMember(
        name: 'maxLines',
        kind: 'field',
        signature: 'final int? maxLines;',
      ),
      VDocApiMember(
        name: 'minLines',
        kind: 'field',
        signature: 'final int? minLines;',
      ),
      VDocApiMember(
        name: 'overflow',
        kind: 'field',
        signature: 'final TextOverflow? overflow;',
      ),
      VDocApiMember(
        name: 'selectionColor',
        kind: 'field',
        signature: 'final Color? selectionColor;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'textAlign',
        kind: 'field',
        signature: 'final TextAlign? textAlign;',
      ),
      VDocApiMember(
        name: 'variant',
        kind: 'field',
        signature: 'final VTextVariant variant;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VSelectableText> createState() => _VSelectableTextState();',
      ),
    ],
  ),
  'VShadows': VDocApiSymbol(
    name: 'VShadows',
    kind: 'class',
    library: 'lib/src/foundation/shadows.dart',
    members: [
      VDocApiMember(
        name: 'VShadows',
        kind: 'constructor',
        signature: 'const VShadows({',
      ),
      VDocApiMember(
        name: 'VShadows.dark',
        kind: 'constructor',
        signature: 'factory VShadows.dark([Color scrim = const Color(0xFF0A0B0D)]) {',
      ),
      VDocApiMember(
        name: 'VShadows.light',
        kind: 'constructor',
        signature: 'factory VShadows.light([Color scrim = const Color(0xFF0A0B0D)]) {',
      ),
      VDocApiMember(
        name: 'card',
        kind: 'field',
        signature: 'BoxShadow get card => level1;',
      ),
      VDocApiMember(
        name: 'dialog',
        kind: 'field',
        signature: 'BoxShadow get dialog => level3;',
      ),
      VDocApiMember(
        name: 'dropdown',
        kind: 'field',
        signature: 'BoxShadow get dropdown => level2;',
      ),
      VDocApiMember(
        name: 'level1',
        kind: 'field',
        signature: 'final BoxShadow level1;',
      ),
      VDocApiMember(
        name: 'level2',
        kind: 'field',
        signature: 'final BoxShadow level2;',
      ),
      VDocApiMember(
        name: 'level3',
        kind: 'field',
        signature: 'final BoxShadow level3;',
      ),
      VDocApiMember(
        name: 'level4',
        kind: 'field',
        signature: 'final BoxShadow level4;',
      ),
      VDocApiMember(
        name: 'panel',
        kind: 'field',
        signature: 'BoxShadow get panel => level1;',
      ),
      VDocApiMember(
        name: 'debugFillProperties',
        kind: 'method',
        signature: 'void debugFillProperties(DiagnosticPropertiesBuilder properties) {',
      ),
      VDocApiMember(
        name: 'hashCode',
        kind: 'method',
        signature: 'int get hashCode => _\$VShadowsHash(this);',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VShadows lerp(VShadows a, VShadows b, double t) =>',
      ),
      VDocApiMember(
        name: 'operator',
        kind: 'method',
        signature: 'bool operator ==(Object other) => _\$VShadowsEq(this, other);',
      ),
      VDocApiMember(
        name: 'resolve',
        kind: 'method',
        signature: 'BoxShadow? resolve(VElevation elevation) {',
      ),
    ],
  ),
  'VSheet': VDocApiSymbol(
    name: 'VSheet',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_sheet.dart',
    members: [
    ],
  ),
  'VSheetEdge': VDocApiSymbol(
    name: 'VSheetEdge',
    kind: 'enum',
    library: 'lib/src/widgets/overlays/v_sheet.dart',
    members: [
      VDocApiMember(
        name: 'top',
        kind: 'value',
        signature: 'top',
      ),
      VDocApiMember(
        name: 'right',
        kind: 'value',
        signature: 'right',
      ),
      VDocApiMember(
        name: 'bottom',
        kind: 'value',
        signature: 'bottom',
      ),
      VDocApiMember(
        name: 'left',
        kind: 'value',
        signature: 'left',
      ),
    ],
  ),
  'VSheetKeyboardBehavior': VDocApiSymbol(
    name: 'VSheetKeyboardBehavior',
    kind: 'enum',
    library: 'lib/src/widgets/overlays/v_sheet.dart',
    members: [
      VDocApiMember(
        name: 'resize',
        kind: 'value',
        signature: 'resize',
      ),
      VDocApiMember(
        name: 'overlay',
        kind: 'value',
        signature: 'overlay',
      ),
      VDocApiMember(
        name: 'none',
        kind: 'value',
        signature: 'none',
      ),
    ],
  ),
  'VSheetScope': VDocApiSymbol(
    name: 'VSheetScope',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_sheet.dart',
    members: [
      VDocApiMember(
        name: 'VSheetScope',
        kind: 'constructor',
        signature: 'const VSheetScope({',
      ),
      VDocApiMember(
        name: 'Function',
        kind: 'method',
        signature: 'final void Function([T? result]) close;',
      ),
      VDocApiMember(
        name: 'updateShouldNotify',
        kind: 'method',
        signature: 'bool updateShouldNotify(VSheetScope<T> oldWidget) => close != oldWidget.close;',
      ),
    ],
  ),
  'VSheetSize': VDocApiSymbol(
    name: 'VSheetSize',
    kind: 'enum',
    library: 'lib/src/widgets/overlays/v_sheet.dart',
    members: [
      VDocApiMember(
        name: 'auto',
        kind: 'value',
        signature: 'auto',
      ),
      VDocApiMember(
        name: 'intrinsic',
        kind: 'value',
        signature: 'intrinsic',
      ),
      VDocApiMember(
        name: 'half',
        kind: 'value',
        signature: 'half',
      ),
      VDocApiMember(
        name: 'full',
        kind: 'value',
        signature: 'full',
      ),
    ],
  ),
  'VSheetSurface': VDocApiSymbol(
    name: 'VSheetSurface',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_sheet.dart',
    members: [
      VDocApiMember(
        name: 'VSheetSurface',
        kind: 'constructor',
        signature: 'const VSheetSurface({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'edge',
        kind: 'field',
        signature: 'final VSheetEdge? edge;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'showDragHandle',
        kind: 'field',
        signature: 'final bool showDragHandle;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VShimmer': VDocApiSymbol(
    name: 'VShimmer',
    kind: 'class',
    library: 'lib/src/widgets/feedback/v_skeleton.dart',
    members: [
      VDocApiMember(
        name: 'VShimmer',
        kind: 'constructor',
        signature: 'const VShimmer({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VShimmer> createState() => _VShimmerState();',
      ),
    ],
  ),
  'VSizes': VDocApiSymbol(
    name: 'VSizes',
    kind: 'class',
    library: 'lib/src/foundation/sizes.dart',
    members: [
      VDocApiMember(
        name: 'VSizes',
        kind: 'constructor',
        signature: 'const VSizes({',
      ),
      VDocApiMember(
        name: 'VSizes.defaults',
        kind: 'constructor',
        signature: 'factory VSizes.defaults() {',
      ),
      VDocApiMember(
        name: 'avatarLg',
        kind: 'field',
        signature: 'final double avatarLg;',
      ),
      VDocApiMember(
        name: 'avatarMd',
        kind: 'field',
        signature: 'final double avatarMd;',
      ),
      VDocApiMember(
        name: 'avatarSm',
        kind: 'field',
        signature: 'final double avatarSm;',
      ),
      VDocApiMember(
        name: 'borderThick',
        kind: 'field',
        signature: 'final double borderThick;',
      ),
      VDocApiMember(
        name: 'borderThin',
        kind: 'field',
        signature: 'final double borderThin;',
      ),
      VDocApiMember(
        name: 'buttonPaddingHorizontalLg',
        kind: 'field',
        signature: 'final double buttonPaddingHorizontalLg;',
      ),
      VDocApiMember(
        name: 'buttonPaddingHorizontalMd',
        kind: 'field',
        signature: 'final double buttonPaddingHorizontalMd;',
      ),
      VDocApiMember(
        name: 'buttonPaddingHorizontalSm',
        kind: 'field',
        signature: 'final double buttonPaddingHorizontalSm;',
      ),
      VDocApiMember(
        name: 'buttonPaddingVerticalLg',
        kind: 'field',
        signature: 'final double buttonPaddingVerticalLg;',
      ),
      VDocApiMember(
        name: 'buttonPaddingVerticalMd',
        kind: 'field',
        signature: 'final double buttonPaddingVerticalMd;',
      ),
      VDocApiMember(
        name: 'buttonPaddingVerticalSm',
        kind: 'field',
        signature: 'final double buttonPaddingVerticalSm;',
      ),
      VDocApiMember(
        name: 'checkboxSize',
        kind: 'field',
        signature: 'final double checkboxSize;',
      ),
      VDocApiMember(
        name: 'controlLg',
        kind: 'field',
        signature: 'final double controlLg;',
      ),
      VDocApiMember(
        name: 'controlMd',
        kind: 'field',
        signature: 'final double controlMd;',
      ),
      VDocApiMember(
        name: 'controlSm',
        kind: 'field',
        signature: 'final double controlSm;',
      ),
      VDocApiMember(
        name: 'dialogMaxWidth',
        kind: 'field',
        signature: 'final double dialogMaxWidth;',
      ),
      VDocApiMember(
        name: 'iconLg',
        kind: 'field',
        signature: 'final double iconLg;',
      ),
      VDocApiMember(
        name: 'iconMd',
        kind: 'field',
        signature: 'final double iconMd;',
      ),
      VDocApiMember(
        name: 'iconSm',
        kind: 'field',
        signature: 'final double iconSm;',
      ),
      VDocApiMember(
        name: 'radioSize',
        kind: 'field',
        signature: 'final double radioSize;',
      ),
      VDocApiMember(
        name: 'sliderThumb',
        kind: 'field',
        signature: 'final double sliderThumb;',
      ),
      VDocApiMember(
        name: 'sliderTrack',
        kind: 'field',
        signature: 'final double sliderTrack;',
      ),
      VDocApiMember(
        name: 'switchHeight',
        kind: 'field',
        signature: 'final double switchHeight;',
      ),
      VDocApiMember(
        name: 'switchThumb',
        kind: 'field',
        signature: 'final double switchThumb;',
      ),
      VDocApiMember(
        name: 'switchWidth',
        kind: 'field',
        signature: 'final double switchWidth;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VSizes copyWith({',
      ),
      VDocApiMember(
        name: 'debugFillProperties',
        kind: 'method',
        signature: 'void debugFillProperties(DiagnosticPropertiesBuilder properties) {',
      ),
      VDocApiMember(
        name: 'hashCode',
        kind: 'method',
        signature: 'int get hashCode => _\$VSizesHash(this);',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VSizes lerp(VSizes a, VSizes b, double t) =>',
      ),
      VDocApiMember(
        name: 'operator',
        kind: 'method',
        signature: 'bool operator ==(Object other) => _\$VSizesEq(this, other);',
      ),
    ],
  ),
  'VSkeletonBox': VDocApiSymbol(
    name: 'VSkeletonBox',
    kind: 'class',
    library: 'lib/src/widgets/feedback/v_skeleton.dart',
    members: [
      VDocApiMember(
        name: 'VSkeletonBox',
        kind: 'constructor',
        signature: 'const VSkeletonBox({',
      ),
      VDocApiMember(
        name: 'borderRadius',
        kind: 'field',
        signature: 'final double? borderRadius;',
      ),
      VDocApiMember(
        name: 'height',
        kind: 'field',
        signature: 'final double height;',
      ),
      VDocApiMember(
        name: 'width',
        kind: 'field',
        signature: 'final double? width;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VSkeletonCircle': VDocApiSymbol(
    name: 'VSkeletonCircle',
    kind: 'class',
    library: 'lib/src/widgets/feedback/v_skeleton.dart',
    members: [
      VDocApiMember(
        name: 'VSkeletonCircle',
        kind: 'constructor',
        signature: 'const VSkeletonCircle({',
      ),
      VDocApiMember(
        name: 'size',
        kind: 'field',
        signature: 'final double size;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VSlider': VDocApiSymbol(
    name: 'VSlider',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_slider.dart',
    members: [
      VDocApiMember(
        name: 'VSlider',
        kind: 'constructor',
        signature: 'const VSlider({',
      ),
      VDocApiMember(
        name: 'autofocus',
        kind: 'field',
        signature: 'final bool autofocus;',
      ),
      VDocApiMember(
        name: 'axis',
        kind: 'field',
        signature: 'final Axis axis;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'focusNode',
        kind: 'field',
        signature: 'final FocusNode? focusNode;',
      ),
      VDocApiMember(
        name: 'max',
        kind: 'field',
        signature: 'final double max;',
      ),
      VDocApiMember(
        name: 'min',
        kind: 'field',
        signature: 'final double min;',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<double> onChanged;',
      ),
      VDocApiMember(
        name: 'onDragEnd',
        kind: 'field',
        signature: 'final ValueChanged<double>? onDragEnd;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'step',
        kind: 'field',
        signature: 'final double? step;',
      ),
      VDocApiMember(
        name: 'value',
        kind: 'field',
        signature: 'final double value;',
      ),
      VDocApiMember(
        name: 'valueNotifier',
        kind: 'field',
        signature: 'final ValueNotifier<double>? valueNotifier;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VSlider> createState() => _VSliderState();',
      ),
    ],
  ),
  'VSliderTokens': VDocApiSymbol(
    name: 'VSliderTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_slider_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VSliderTokens',
        kind: 'constructor',
        signature: 'const VSliderTokens({',
      ),
      VDocApiMember(
        name: 'VSliderTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VSliderTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'focusRing',
        kind: 'field',
        signature: 'final Color focusRing;',
      ),
      VDocApiMember(
        name: 'thumbBackground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> thumbBackground;',
      ),
      VDocApiMember(
        name: 'trackActive',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> trackActive;',
      ),
      VDocApiMember(
        name: 'trackBackground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> trackBackground;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VSliderTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VSliderTokens lerp(VSliderTokens a, VSliderTokens b, double t) {',
      ),
    ],
  ),
  'VSliverAppBar': VDocApiSymbol(
    name: 'VSliverAppBar',
    kind: 'class',
    library: 'lib/src/widgets/layout/v_app_bar.dart',
    members: [
      VDocApiMember(
        name: 'VSliverAppBar',
        kind: 'constructor',
        signature: 'const VSliverAppBar({',
      ),
      VDocApiMember(
        name: 'actions',
        kind: 'field',
        signature: 'final List<Widget> actions;',
      ),
      VDocApiMember(
        name: 'backgroundColor',
        kind: 'field',
        signature: 'final Color? backgroundColor;',
      ),
      VDocApiMember(
        name: 'bottom',
        kind: 'field',
        signature: 'final Widget? bottom;',
      ),
      VDocApiMember(
        name: 'centerTitle',
        kind: 'field',
        signature: 'final bool? centerTitle;',
      ),
      VDocApiMember(
        name: 'collapsedHeight',
        kind: 'field',
        signature: 'final double? collapsedHeight;',
      ),
      VDocApiMember(
        name: 'expandedHeight',
        kind: 'field',
        signature: 'final double? expandedHeight;',
      ),
      VDocApiMember(
        name: 'flexibleBuilder',
        kind: 'field',
        signature: 'final VSliverAppBarFlexibleBuilder? flexibleBuilder;',
      ),
      VDocApiMember(
        name: 'flexibleSpace',
        kind: 'field',
        signature: 'final Widget? flexibleSpace;',
      ),
      VDocApiMember(
        name: 'foregroundColor',
        kind: 'field',
        signature: 'final Color? foregroundColor;',
      ),
      VDocApiMember(
        name: 'leading',
        kind: 'field',
        signature: 'final Widget? leading;',
      ),
      VDocApiMember(
        name: 'pinned',
        kind: 'field',
        signature: 'final bool pinned;',
      ),
      VDocApiMember(
        name: 'safeArea',
        kind: 'field',
        signature: 'final bool safeArea;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'subtitle',
        kind: 'field',
        signature: 'final Widget? subtitle;',
      ),
      VDocApiMember(
        name: 'title',
        kind: 'field',
        signature: 'final Widget? title;',
      ),
      VDocApiMember(
        name: 'variant',
        kind: 'field',
        signature: 'final VAppBarVariant variant;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VSliverAppBarFlexibleBuilder': VDocApiSymbol(
    name: 'VSliverAppBarFlexibleBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/layout/v_app_bar.dart',
    members: [
      VDocApiMember(
        name: 'VSliverAppBarFlexibleBuilder',
        kind: 'typedef',
        signature: 'typedef VSliverAppBarFlexibleBuilder = Widget Function(',
      ),
    ],
  ),
  'VSoftAppearance': VDocApiSymbol(
    name: 'VSoftAppearance',
    kind: 'class',
    library: 'lib/src/theme/v_appearance.dart',
    members: [
      VDocApiMember(
        name: 'VSoftAppearance',
        kind: 'constructor',
        signature: 'const VSoftAppearance();',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'method',
        signature: 'Color background(Color base, Set<WidgetState> states) {',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'method',
        signature: 'double radius(double base) => base * 1.5;',
      ),
      VDocApiMember(
        name: 'shadows',
        kind: 'method',
        signature: 'List<BoxShadow> shadows(List<BoxShadow> base) {',
      ),
    ],
  ),
  'VSpacing': VDocApiSymbol(
    name: 'VSpacing',
    kind: 'class',
    library: 'lib/src/foundation/spacing.dart',
    members: [
      VDocApiMember(
        name: 'VSpacing',
        kind: 'constructor',
        signature: 'const VSpacing({',
      ),
      VDocApiMember(
        name: 'VSpacing.defaults',
        kind: 'constructor',
        signature: 'factory VSpacing.defaults() {',
      ),
      VDocApiMember(
        name: 'gap',
        kind: 'field',
        signature: 'final double gap;',
      ),
      VDocApiMember(
        name: 'iconGap',
        kind: 'field',
        signature: 'final double iconGap;',
      ),
      VDocApiMember(
        name: 'lg',
        kind: 'field',
        signature: 'final double lg;',
      ),
      VDocApiMember(
        name: 'md',
        kind: 'field',
        signature: 'final double md;',
      ),
      VDocApiMember(
        name: 'sm',
        kind: 'field',
        signature: 'final double sm;',
      ),
      VDocApiMember(
        name: 'x2l',
        kind: 'field',
        signature: 'final double x2l;',
      ),
      VDocApiMember(
        name: 'x3l',
        kind: 'field',
        signature: 'final double x3l;',
      ),
      VDocApiMember(
        name: 'xl',
        kind: 'field',
        signature: 'final double xl;',
      ),
      VDocApiMember(
        name: 'xs',
        kind: 'field',
        signature: 'final double xs;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VSpacing copyWith({',
      ),
      VDocApiMember(
        name: 'debugFillProperties',
        kind: 'method',
        signature: 'void debugFillProperties(DiagnosticPropertiesBuilder properties) {',
      ),
      VDocApiMember(
        name: 'hashCode',
        kind: 'method',
        signature: 'int get hashCode => _\$VSpacingHash(this);',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VSpacing lerp(VSpacing a, VSpacing b, double t) =>',
      ),
      VDocApiMember(
        name: 'operator',
        kind: 'method',
        signature: 'bool operator ==(Object other) => _\$VSpacingEq(this, other);',
      ),
    ],
  ),
  'VSpinner': VDocApiSymbol(
    name: 'VSpinner',
    kind: 'class',
    library: 'lib/src/widgets/feedback/v_progress.dart',
    members: [
      VDocApiMember(
        name: 'VSpinner',
        kind: 'constructor',
        signature: 'const VSpinner({',
      ),
      VDocApiMember(
        name: 'color',
        kind: 'field',
        signature: 'final Color? color;',
      ),
      VDocApiMember(
        name: 'size',
        kind: 'field',
        signature: 'final double size;',
      ),
      VDocApiMember(
        name: 'strokeWidth',
        kind: 'field',
        signature: 'final double strokeWidth;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VSpinner> createState() => _VSpinnerState();',
      ),
    ],
  ),
  'VStagger': VDocApiSymbol(
    name: 'VStagger',
    kind: 'class',
    library: 'lib/src/widgets/animation/v_stagger.dart',
    members: [
      VDocApiMember(
        name: 'VStagger',
        kind: 'constructor',
        signature: 'const VStagger({',
      ),
      VDocApiMember(
        name: 'beginOffset',
        kind: 'field',
        signature: 'final Offset beginOffset;',
      ),
      VDocApiMember(
        name: 'children',
        kind: 'field',
        signature: 'final List<Widget> children;',
      ),
      VDocApiMember(
        name: 'delay',
        kind: 'field',
        signature: 'final Duration delay;',
      ),
      VDocApiMember(
        name: 'initialCount',
        kind: 'field',
        signature: 'final int initialCount;',
      ),
      VDocApiMember(
        name: 'motion',
        kind: 'field',
        signature: 'final VMotionSpec? motion;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VStagger> createState() => _VStaggerState();',
      ),
    ],
  ),
  'VStateProperty': VDocApiSymbol(
    name: 'VStateProperty',
    kind: 'class',
    library: 'lib/src/foundation/state.dart',
    members: [
      VDocApiMember(
        name: 'VStateProperty',
        kind: 'constructor',
        signature: 'const VStateProperty(this._resolver);',
      ),
      VDocApiMember(
        name: 'VStateProperty.all',
        kind: 'constructor',
        signature: 'factory VStateProperty.all(T value) => VStateProperty((_) => value);',
      ),
      VDocApiMember(
        name: 'VStateProperty.resolveWith',
        kind: 'constructor',
        signature: 'factory VStateProperty.resolveWith({',
      ),
      VDocApiMember(
        name: 'VStateProperty.states',
        kind: 'constructor',
        signature: 'factory VStateProperty.states({',
      ),
      VDocApiMember(
        name: 'Function',
        kind: 'method',
        signature: 'final T Function(Set<WidgetState> states) _resolver;',
      ),
      VDocApiMember(
        name: 'resolve',
        kind: 'method',
        signature: 'T resolve(Set<WidgetState> states) => _resolver(states);',
      ),
    ],
  ),
  'VStep': VDocApiSymbol(
    name: 'VStep',
    kind: 'class',
    library: 'lib/src/widgets/navigation/v_steps.dart',
    members: [
      VDocApiMember(
        name: 'VStep',
        kind: 'constructor',
        signature: 'const VStep({',
      ),
      VDocApiMember(
        name: 'description',
        kind: 'field',
        signature: 'final Widget? description;',
      ),
      VDocApiMember(
        name: 'title',
        kind: 'field',
        signature: 'final Widget title;',
      ),
    ],
  ),
  'VStepStatus': VDocApiSymbol(
    name: 'VStepStatus',
    kind: 'enum',
    library: 'lib/src/widgets/navigation/v_steps.dart',
    members: [
      VDocApiMember(
        name: 'completed',
        kind: 'value',
        signature: 'completed',
      ),
      VDocApiMember(
        name: 'active',
        kind: 'value',
        signature: 'active',
      ),
      VDocApiMember(
        name: 'pending',
        kind: 'value',
        signature: 'pending',
      ),
    ],
  ),
  'VSteps': VDocApiSymbol(
    name: 'VSteps',
    kind: 'class',
    library: 'lib/src/widgets/navigation/v_steps.dart',
    members: [
      VDocApiMember(
        name: 'VSteps',
        kind: 'constructor',
        signature: 'const VSteps({',
      ),
      VDocApiMember(
        name: 'activeColor',
        kind: 'field',
        signature: 'final Color? activeColor;',
      ),
      VDocApiMember(
        name: 'current',
        kind: 'field',
        signature: 'final int current;',
      ),
      VDocApiMember(
        name: 'direction',
        kind: 'field',
        signature: 'final Axis direction;',
      ),
      VDocApiMember(
        name: 'inactiveColor',
        kind: 'field',
        signature: 'final Color? inactiveColor;',
      ),
      VDocApiMember(
        name: 'mode',
        kind: 'field',
        signature: 'final VStepsMode mode;',
      ),
      VDocApiMember(
        name: 'steps',
        kind: 'field',
        signature: 'final List<VStep> steps;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VStepsMode': VDocApiSymbol(
    name: 'VStepsMode',
    kind: 'enum',
    library: 'lib/src/widgets/navigation/v_steps.dart',
    members: [
      VDocApiMember(
        name: 'dot',
        kind: 'value',
        signature: 'dot',
      ),
      VDocApiMember(
        name: 'number',
        kind: 'value',
        signature: 'number',
      ),
    ],
  ),
  'VStepsTheme': VDocApiSymbol(
    name: 'VStepsTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VStepsTheme',
        kind: 'constructor',
        signature: 'const VStepsTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VStepsTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VStepsTokens': VDocApiSymbol(
    name: 'VStepsTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_steps_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VStepsTokens',
        kind: 'constructor',
        signature: 'const VStepsTokens({',
      ),
      VDocApiMember(
        name: 'VStepsTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VStepsTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'activeColor',
        kind: 'field',
        signature: 'final Color activeColor;',
      ),
      VDocApiMember(
        name: 'activeText',
        kind: 'field',
        signature: 'final Color activeText;',
      ),
      VDocApiMember(
        name: 'inactiveColor',
        kind: 'field',
        signature: 'final Color inactiveColor;',
      ),
      VDocApiMember(
        name: 'inactiveText',
        kind: 'field',
        signature: 'final Color inactiveText;',
      ),
      VDocApiMember(
        name: 'indicatorSize',
        kind: 'field',
        signature: 'final double indicatorSize;',
      ),
      VDocApiMember(
        name: 'lineHeight',
        kind: 'field',
        signature: 'final double lineHeight;',
      ),
      VDocApiMember(
        name: 'lineMargin',
        kind: 'field',
        signature: 'final double lineMargin;',
      ),
      VDocApiMember(
        name: 'surface',
        kind: 'field',
        signature: 'final Color surface;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VStepsTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VStepsTokens lerp(VStepsTokens a, VStepsTokens b, double t) {',
      ),
    ],
  ),
  'VStickyHeader': VDocApiSymbol(
    name: 'VStickyHeader',
    kind: 'class',
    library: 'lib/src/widgets/layout/v_sticky_header.dart',
    members: [
      VDocApiMember(
        name: 'VStickyHeader',
        kind: 'constructor',
        signature: 'const VStickyHeader({',
      ),
      VDocApiMember(
        name: 'floating',
        kind: 'field',
        signature: 'final bool floating;',
      ),
      VDocApiMember(
        name: 'maxHeight',
        kind: 'field',
        signature: 'final double maxHeight;',
      ),
      VDocApiMember(
        name: 'minHeight',
        kind: 'field',
        signature: 'final double minHeight;',
      ),
      VDocApiMember(
        name: 'pinned',
        kind: 'field',
        signature: 'final bool pinned;',
      ),
      VDocApiMember(
        name: 'Function',
        kind: 'method',
        signature: 'final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent) builder;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VStickyHeaderDelegate': VDocApiSymbol(
    name: 'VStickyHeaderDelegate',
    kind: 'class',
    library: 'lib/src/widgets/layout/v_sticky_header.dart',
    members: [
      VDocApiMember(
        name: 'VStickyHeaderDelegate',
        kind: 'constructor',
        signature: 'const VStickyHeaderDelegate({',
      ),
      VDocApiMember(
        name: 'maxExtent',
        kind: 'field',
        signature: 'double get maxExtent => maxHeight;',
      ),
      VDocApiMember(
        name: 'maxHeight',
        kind: 'field',
        signature: 'final double maxHeight;',
      ),
      VDocApiMember(
        name: 'minExtent',
        kind: 'field',
        signature: 'double get minExtent => minHeight;',
      ),
      VDocApiMember(
        name: 'minHeight',
        kind: 'field',
        signature: 'final double minHeight;',
      ),
      VDocApiMember(
        name: 'Function',
        kind: 'method',
        signature: 'final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent) builder;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {',
      ),
      VDocApiMember(
        name: 'shouldRebuild',
        kind: 'method',
        signature: 'bool shouldRebuild(covariant VStickyHeaderDelegate oldDelegate) {',
      ),
    ],
  ),
  'VSurface': VDocApiSymbol(
    name: 'VSurface',
    kind: 'class',
    library: 'lib/src/widgets/basic/v_surface.dart',
    members: [
      VDocApiMember(
        name: 'VSurface',
        kind: 'constructor',
        signature: 'const VSurface({',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'field',
        signature: 'final VBackground? background;',
      ),
      VDocApiMember(
        name: 'borderStyle',
        kind: 'field',
        signature: 'final VBorderStyle borderStyle;',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'dotRadius',
        kind: 'field',
        signature: 'final double dotRadius;',
      ),
      VDocApiMember(
        name: 'dotStep',
        kind: 'field',
        signature: 'final double dotStep;',
      ),
      VDocApiMember(
        name: 'elevation',
        kind: 'field',
        signature: 'final VElevation? elevation;',
      ),
      VDocApiMember(
        name: 'height',
        kind: 'field',
        signature: 'final double? height;',
      ),
      VDocApiMember(
        name: 'margin',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry? margin;',
      ),
      VDocApiMember(
        name: 'padding',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry? padding;',
      ),
      VDocApiMember(
        name: 'variant',
        kind: 'field',
        signature: 'final VSurfaceVariant variant;',
      ),
      VDocApiMember(
        name: 'width',
        kind: 'field',
        signature: 'final double? width;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VSurfaceTheme': VDocApiSymbol(
    name: 'VSurfaceTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VSurfaceTheme',
        kind: 'constructor',
        signature: 'const VSurfaceTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VSurfaceTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VSurfaceTokens': VDocApiSymbol(
    name: 'VSurfaceTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_surface_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VSurfaceTokens',
        kind: 'constructor',
        signature: 'const VSurfaceTokens({',
      ),
      VDocApiMember(
        name: 'VSurfaceTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VSurfaceTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'baseBackground',
        kind: 'field',
        signature: 'final Color baseBackground;',
      ),
      VDocApiMember(
        name: 'baseBorder',
        kind: 'field',
        signature: 'final Color baseBorder;',
      ),
      VDocApiMember(
        name: 'cardBackground',
        kind: 'field',
        signature: 'final Color cardBackground;',
      ),
      VDocApiMember(
        name: 'cardBorder',
        kind: 'field',
        signature: 'final Color cardBorder;',
      ),
      VDocApiMember(
        name: 'elevatedBackground',
        kind: 'field',
        signature: 'final Color elevatedBackground;',
      ),
      VDocApiMember(
        name: 'elevatedBorder',
        kind: 'field',
        signature: 'final Color elevatedBorder;',
      ),
      VDocApiMember(
        name: 'panelBackground',
        kind: 'field',
        signature: 'final Color panelBackground;',
      ),
      VDocApiMember(
        name: 'panelBorder',
        kind: 'field',
        signature: 'final Color panelBorder;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VSurfaceTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VSurfaceTokens lerp(VSurfaceTokens a, VSurfaceTokens b, double t) {',
      ),
    ],
  ),
  'VSurfaceVariant': VDocApiSymbol(
    name: 'VSurfaceVariant',
    kind: 'enum',
    library: 'lib/src/widgets/basic/v_surface.dart',
    members: [
      VDocApiMember(
        name: 'base',
        kind: 'value',
        signature: 'base',
      ),
      VDocApiMember(
        name: 'elevated',
        kind: 'value',
        signature: 'elevated',
      ),
      VDocApiMember(
        name: 'card',
        kind: 'value',
        signature: 'card',
      ),
      VDocApiMember(
        name: 'panel',
        kind: 'value',
        signature: 'panel',
      ),
    ],
  ),
  'VSwipeActionBehavior': VDocApiSymbol(
    name: 'VSwipeActionBehavior',
    kind: 'enum',
    library: 'lib/src/widgets/interaction/v_swipe_actions.dart',
    members: [
      VDocApiMember(
        name: 'reveal',
        kind: 'value',
        signature: 'reveal',
      ),
      VDocApiMember(
        name: 'transient',
        kind: 'value',
        signature: 'transient',
      ),
    ],
  ),
  'VSwipeActionSide': VDocApiSymbol(
    name: 'VSwipeActionSide',
    kind: 'enum',
    library: 'lib/src/widgets/interaction/v_swipe_actions.dart',
    members: [
      VDocApiMember(
        name: 'start',
        kind: 'value',
        signature: 'start',
      ),
      VDocApiMember(
        name: 'end',
        kind: 'value',
        signature: 'end',
      ),
    ],
  ),
  'VSwipeActions': VDocApiSymbol(
    name: 'VSwipeActions',
    kind: 'class',
    library: 'lib/src/widgets/interaction/v_swipe_actions.dart',
    members: [
      VDocApiMember(
        name: 'VSwipeActions',
        kind: 'constructor',
        signature: 'const VSwipeActions({',
      ),
      VDocApiMember(
        name: 'autoClose',
        kind: 'field',
        signature: 'final bool autoClose;',
      ),
      VDocApiMember(
        name: 'behavior',
        kind: 'field',
        signature: 'final VSwipeActionBehavior behavior;',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'closeOnTap',
        kind: 'field',
        signature: 'final bool closeOnTap;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'endAction',
        kind: 'field',
        signature: 'final Widget? endAction;',
      ),
      VDocApiMember(
        name: 'endActions',
        kind: 'field',
        signature: 'final List<Widget>? endActions;',
      ),
      VDocApiMember(
        name: 'onOpenChanged',
        kind: 'field',
        signature: 'final ValueChanged<VSwipeActionSide?>? onOpenChanged;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'startAction',
        kind: 'field',
        signature: 'final Widget? startAction;',
      ),
      VDocApiMember(
        name: 'startActions',
        kind: 'field',
        signature: 'final List<Widget>? startActions;',
      ),
      VDocApiMember(
        name: 'threshold',
        kind: 'field',
        signature: 'final double threshold;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VSwipeActions> createState() => _VSwipeActionsState();',
      ),
    ],
  ),
  'VSwitch': VDocApiSymbol(
    name: 'VSwitch',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_switch.dart',
    members: [
      VDocApiMember(
        name: 'VSwitch',
        kind: 'constructor',
        signature: 'const VSwitch({',
      ),
      VDocApiMember(
        name: 'autofocus',
        kind: 'field',
        signature: 'final bool autofocus;',
      ),
      VDocApiMember(
        name: 'checked',
        kind: 'field',
        signature: 'final bool checked;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'focusNode',
        kind: 'field',
        signature: 'final FocusNode? focusNode;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String? label;',
      ),
      VDocApiMember(
        name: 'labelWidget',
        kind: 'field',
        signature: 'final Widget? labelWidget;',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<bool>? onChanged;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VSwitchTheme': VDocApiSymbol(
    name: 'VSwitchTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VSwitchTheme',
        kind: 'constructor',
        signature: 'const VSwitchTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VSwitchTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VSwitchTokens': VDocApiSymbol(
    name: 'VSwitchTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_switch_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VSwitchTokens',
        kind: 'constructor',
        signature: 'const VSwitchTokens({',
      ),
      VDocApiMember(
        name: 'VSwitchTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VSwitchTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'focusRing',
        kind: 'field',
        signature: 'final Color focusRing;',
      ),
      VDocApiMember(
        name: 'thumbBackground',
        kind: 'field',
        signature: 'final Color thumbBackground;',
      ),
      VDocApiMember(
        name: 'trackBackground',
        kind: 'field',
        signature: 'final WidgetStateProperty<Color> trackBackground;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VSwitchTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VSwitchTokens lerp(VSwitchTokens a, VSwitchTokens b, double t) {',
      ),
    ],
  ),
  'VTabBar': VDocApiSymbol(
    name: 'VTabBar',
    kind: 'class',
    library: 'lib/src/widgets/layout/v_tabs.dart',
    members: [
      VDocApiMember(
        name: 'VTabBar',
        kind: 'constructor',
        signature: 'const VTabBar({',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<int> onChanged;',
      ),
      VDocApiMember(
        name: 'selectedIndex',
        kind: 'field',
        signature: 'final int selectedIndex;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'tabs',
        kind: 'field',
        signature: 'final List<Object> tabs;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VTabBar> createState() => _VTabBarState();',
      ),
    ],
  ),
  'VTabItem': VDocApiSymbol(
    name: 'VTabItem',
    kind: 'class',
    library: 'lib/src/widgets/layout/v_tabs.dart',
    members: [
      VDocApiMember(
        name: 'VTabItem',
        kind: 'constructor',
        signature: 'const VTabItem({',
      ),
      VDocApiMember(
        name: 'icon',
        kind: 'field',
        signature: 'final Widget? icon;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String label;',
      ),
    ],
  ),
  'VTable': VDocApiSymbol(
    name: 'VTable',
    kind: 'class',
    library: 'lib/src/widgets/data/v_table.dart',
    members: [
      VDocApiMember(
        name: 'VTable',
        kind: 'constructor',
        signature: 'const VTable({',
      ),
      VDocApiMember(
        name: 'columns',
        kind: 'field',
        signature: 'final List<VTableColumn> columns;',
      ),
      VDocApiMember(
        name: 'maxBodyHeight',
        kind: 'field',
        signature: 'final double maxBodyHeight;',
      ),
      VDocApiMember(
        name: 'rowHeight',
        kind: 'field',
        signature: 'final double rowHeight;',
      ),
      VDocApiMember(
        name: 'rows',
        kind: 'field',
        signature: 'final List<List<String>> rows;',
      ),
      VDocApiMember(
        name: 'sortAscending',
        kind: 'field',
        signature: 'final bool sortAscending;',
      ),
      VDocApiMember(
        name: 'sortColumnIndex',
        kind: 'field',
        signature: 'final int? sortColumnIndex;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VTable> createState() => _VTableState();',
      ),
    ],
  ),
  'VTableColumn': VDocApiSymbol(
    name: 'VTableColumn',
    kind: 'class',
    library: 'lib/src/widgets/data/v_table.dart',
    members: [
      VDocApiMember(
        name: 'VTableColumn',
        kind: 'constructor',
        signature: 'const VTableColumn({',
      ),
      VDocApiMember(
        name: 'alignment',
        kind: 'field',
        signature: 'final Alignment alignment;',
      ),
      VDocApiMember(
        name: 'header',
        kind: 'field',
        signature: 'final String header;',
      ),
      VDocApiMember(
        name: 'width',
        kind: 'field',
        signature: 'final double? width;',
      ),
    ],
  ),
  'VTableTheme': VDocApiSymbol(
    name: 'VTableTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VTableTheme',
        kind: 'constructor',
        signature: 'const VTableTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VTableTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VTableTokens': VDocApiSymbol(
    name: 'VTableTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_table_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VTableTokens',
        kind: 'constructor',
        signature: 'const VTableTokens({',
      ),
      VDocApiMember(
        name: 'VTableTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VTableTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'alternateRowBackground',
        kind: 'field',
        signature: 'final Color alternateRowBackground;',
      ),
      VDocApiMember(
        name: 'bodyForeground',
        kind: 'field',
        signature: 'final Color bodyForeground;',
      ),
      VDocApiMember(
        name: 'borderColor',
        kind: 'field',
        signature: 'final Color borderColor;',
      ),
      VDocApiMember(
        name: 'cellPaddingHorizontal',
        kind: 'field',
        signature: 'final double cellPaddingHorizontal;',
      ),
      VDocApiMember(
        name: 'cellPaddingVertical',
        kind: 'field',
        signature: 'final double cellPaddingVertical;',
      ),
      VDocApiMember(
        name: 'dividerColor',
        kind: 'field',
        signature: 'final Color dividerColor;',
      ),
      VDocApiMember(
        name: 'emptyForeground',
        kind: 'field',
        signature: 'final Color emptyForeground;',
      ),
      VDocApiMember(
        name: 'emptyPaddingHorizontal',
        kind: 'field',
        signature: 'final double emptyPaddingHorizontal;',
      ),
      VDocApiMember(
        name: 'emptyPaddingVertical',
        kind: 'field',
        signature: 'final double emptyPaddingVertical;',
      ),
      VDocApiMember(
        name: 'emptyTextSize',
        kind: 'field',
        signature: 'final double emptyTextSize;',
      ),
      VDocApiMember(
        name: 'headerBackground',
        kind: 'field',
        signature: 'final Color headerBackground;',
      ),
      VDocApiMember(
        name: 'headerDividerWidth',
        kind: 'field',
        signature: 'final double headerDividerWidth;',
      ),
      VDocApiMember(
        name: 'headerFocusOutlineColor',
        kind: 'field',
        signature: 'final Color headerFocusOutlineColor;',
      ),
      VDocApiMember(
        name: 'headerFocusOutlineWidth',
        kind: 'field',
        signature: 'final double headerFocusOutlineWidth;',
      ),
      VDocApiMember(
        name: 'headerForeground',
        kind: 'field',
        signature: 'final Color headerForeground;',
      ),
      VDocApiMember(
        name: 'headerHoverBackground',
        kind: 'field',
        signature: 'final Color headerHoverBackground;',
      ),
      VDocApiMember(
        name: 'headerPaddingHorizontal',
        kind: 'field',
        signature: 'final double headerPaddingHorizontal;',
      ),
      VDocApiMember(
        name: 'headerPaddingVertical',
        kind: 'field',
        signature: 'final double headerPaddingVertical;',
      ),
      VDocApiMember(
        name: 'rowBackground',
        kind: 'field',
        signature: 'final Color rowBackground;',
      ),
      VDocApiMember(
        name: 'rowDividerWidth',
        kind: 'field',
        signature: 'final double rowDividerWidth;',
      ),
      VDocApiMember(
        name: 'sortIndicatorActiveColor',
        kind: 'field',
        signature: 'final Color sortIndicatorActiveColor;',
      ),
      VDocApiMember(
        name: 'sortIndicatorColor',
        kind: 'field',
        signature: 'final Color sortIndicatorColor;',
      ),
      VDocApiMember(
        name: 'sortIndicatorSize',
        kind: 'field',
        signature: 'final double sortIndicatorSize;',
      ),
      VDocApiMember(
        name: 'sortIndicatorSpacing',
        kind: 'field',
        signature: 'final double sortIndicatorSpacing;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VTableTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VTableTokens lerp(VTableTokens a, VTableTokens b, double t) {',
      ),
    ],
  ),
  'VTabs': VDocApiSymbol(
    name: 'VTabs',
    kind: 'class',
    library: 'lib/src/widgets/layout/v_tabs.dart',
    members: [
      VDocApiMember(
        name: 'VTabs',
        kind: 'constructor',
        signature: 'const VTabs({',
      ),
      VDocApiMember(
        name: 'children',
        kind: 'field',
        signature: 'final List<Widget> children;',
      ),
      VDocApiMember(
        name: 'initialIndex',
        kind: 'field',
        signature: 'final int initialIndex;',
      ),
      VDocApiMember(
        name: 'tabs',
        kind: 'field',
        signature: 'final List<Object> tabs;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VTabs> createState() => _VTabsState();',
      ),
    ],
  ),
  'VTeachingTip': VDocApiSymbol(
    name: 'VTeachingTip',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_teaching_tip.dart',
    members: [
      VDocApiMember(
        name: 'VTeachingTip',
        kind: 'constructor',
        signature: 'const VTeachingTip({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'controller',
        kind: 'field',
        signature: 'final VPopoverController? controller;',
      ),
      VDocApiMember(
        name: 'gap',
        kind: 'field',
        signature: 'final double? gap;',
      ),
      VDocApiMember(
        name: 'illustration',
        kind: 'field',
        signature: 'final Widget? illustration;',
      ),
      VDocApiMember(
        name: 'onClose',
        kind: 'field',
        signature: 'final VoidCallback? onClose;',
      ),
      VDocApiMember(
        name: 'placement',
        kind: 'field',
        signature: 'final VAnchoredOverlayPlacement placement;',
      ),
      VDocApiMember(
        name: 'primaryButton',
        kind: 'field',
        signature: 'final Widget? primaryButton;',
      ),
      VDocApiMember(
        name: 'secondaryButton',
        kind: 'field',
        signature: 'final Widget? secondaryButton;',
      ),
      VDocApiMember(
        name: 'showCloseButton',
        kind: 'field',
        signature: 'final bool showCloseButton;',
      ),
      VDocApiMember(
        name: 'subtitle',
        kind: 'field',
        signature: 'final String? subtitle;',
      ),
      VDocApiMember(
        name: 'title',
        kind: 'field',
        signature: 'final String? title;',
      ),
      VDocApiMember(
        name: 'transitionStyle',
        kind: 'field',
        signature: 'final VTeachingTipTransitionStyle transitionStyle;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VTeachingTip> createState() => _VTeachingTipState();',
      ),
    ],
  ),
  'VTeachingTipArrowDirection': VDocApiSymbol(
    name: 'VTeachingTipArrowDirection',
    kind: 'enum',
    library: 'lib/src/widgets/overlays/v_teaching_tip.dart',
    members: [
      VDocApiMember(
        name: 'up',
        kind: 'value',
        signature: 'up',
      ),
      VDocApiMember(
        name: 'down',
        kind: 'value',
        signature: 'down',
      ),
      VDocApiMember(
        name: 'left',
        kind: 'value',
        signature: 'left',
      ),
      VDocApiMember(
        name: 'right',
        kind: 'value',
        signature: 'right',
      ),
    ],
  ),
  'VTeachingTipTokens': VDocApiSymbol(
    name: 'VTeachingTipTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_teaching_tip_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VTeachingTipTokens',
        kind: 'constructor',
        signature: 'const VTeachingTipTokens({',
      ),
      VDocApiMember(
        name: 'VTeachingTipTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VTeachingTipTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'actionButtonGap',
        kind: 'field',
        signature: 'final double actionButtonGap;',
      ),
      VDocApiMember(
        name: 'arrowSize',
        kind: 'field',
        signature: 'final double arrowSize;',
      ),
      VDocApiMember(
        name: 'background',
        kind: 'field',
        signature: 'final Color background;',
      ),
      VDocApiMember(
        name: 'border',
        kind: 'field',
        signature: 'final Color border;',
      ),
      VDocApiMember(
        name: 'closeButtonSize',
        kind: 'field',
        signature: 'final double closeButtonSize;',
      ),
      VDocApiMember(
        name: 'contentActionGap',
        kind: 'field',
        signature: 'final double contentActionGap;',
      ),
      VDocApiMember(
        name: 'estimatedActionsHeight',
        kind: 'field',
        signature: 'final double estimatedActionsHeight;',
      ),
      VDocApiMember(
        name: 'estimatedSubtitleHeightIllustration',
        kind: 'field',
        signature: 'final double estimatedSubtitleHeightIllustration;',
      ),
      VDocApiMember(
        name: 'estimatedSubtitleHeightNormal',
        kind: 'field',
        signature: 'final double estimatedSubtitleHeightNormal;',
      ),
      VDocApiMember(
        name: 'gap',
        kind: 'field',
        signature: 'final double gap;',
      ),
      VDocApiMember(
        name: 'illustrationHeight',
        kind: 'field',
        signature: 'final double illustrationHeight;',
      ),
      VDocApiMember(
        name: 'margin',
        kind: 'field',
        signature: 'final double margin;',
      ),
      VDocApiMember(
        name: 'padding',
        kind: 'field',
        signature: 'final EdgeInsetsGeometry padding;',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'field',
        signature: 'final double radius;',
      ),
      VDocApiMember(
        name: 'subtitleColor',
        kind: 'field',
        signature: 'final Color subtitleColor;',
      ),
      VDocApiMember(
        name: 'surfaceWidth',
        kind: 'field',
        signature: 'final double surfaceWidth;',
      ),
      VDocApiMember(
        name: 'titleColor',
        kind: 'field',
        signature: 'final Color titleColor;',
      ),
      VDocApiMember(
        name: 'titleSubtitleGap',
        kind: 'field',
        signature: 'final double titleSubtitleGap;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VTeachingTipTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VTeachingTipTokens lerp(',
      ),
    ],
  ),
  'VTeachingTipTransitionStyle': VDocApiSymbol(
    name: 'VTeachingTipTransitionStyle',
    kind: 'enum',
    library: 'lib/src/widgets/overlays/v_teaching_tip.dart',
    members: [
      VDocApiMember(
        name: 'spring',
        kind: 'value',
        signature: 'spring',
      ),
      VDocApiMember(
        name: 'fade',
        kind: 'value',
        signature: 'fade',
      ),
      VDocApiMember(
        name: 'scale',
        kind: 'value',
        signature: 'scale',
      ),
      VDocApiMember(
        name: 'slide',
        kind: 'value',
        signature: 'slide',
      ),
    ],
  ),
  'VText': VDocApiSymbol(
    name: 'VText',
    kind: 'class',
    library: 'lib/src/widgets/basic/v_text.dart',
    members: [
      VDocApiMember(
        name: 'VText',
        kind: 'constructor',
        signature: 'const VText(',
      ),
      VDocApiMember(
        name: 'color',
        kind: 'field',
        signature: 'final Color? color;',
      ),
      VDocApiMember(
        name: 'data',
        kind: 'field',
        signature: 'final String data;',
      ),
      VDocApiMember(
        name: 'maxLines',
        kind: 'field',
        signature: 'final int? maxLines;',
      ),
      VDocApiMember(
        name: 'overflow',
        kind: 'field',
        signature: 'final TextOverflow? overflow;',
      ),
      VDocApiMember(
        name: 'softWrap',
        kind: 'field',
        signature: 'final bool softWrap;',
      ),
      VDocApiMember(
        name: 'style',
        kind: 'field',
        signature: 'final TextStyle? style;',
      ),
      VDocApiMember(
        name: 'textAlign',
        kind: 'field',
        signature: 'final TextAlign? textAlign;',
      ),
      VDocApiMember(
        name: 'variant',
        kind: 'field',
        signature: 'final VTextVariant variant;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VTextAnimationEffect': VDocApiSymbol(
    name: 'VTextAnimationEffect',
    kind: 'enum',
    library: 'lib/src/widgets/animation/animated_text/v_animated_text_data.dart',
    members: [
      VDocApiMember(
        name: 'reveal',
        kind: 'value',
        signature: 'reveal',
      ),
      VDocApiMember(
        name: 'typewriter',
        kind: 'value',
        signature: 'typewriter',
      ),
      VDocApiMember(
        name: 'fade',
        kind: 'value',
        signature: 'fade',
      ),
      VDocApiMember(
        name: 'scale',
        kind: 'value',
        signature: 'scale',
      ),
      VDocApiMember(
        name: 'wavy',
        kind: 'value',
        signature: 'wavy',
      ),
      VDocApiMember(
        name: 'scramble',
        kind: 'value',
        signature: 'scramble',
      ),
      VDocApiMember(
        name: 'flicker',
        kind: 'value',
        signature: 'flicker',
      ),
      VDocApiMember(
        name: 'bounce',
        kind: 'value',
        signature: 'bounce',
      ),
    ],
  ),
  'VTextField': VDocApiSymbol(
    name: 'VTextField',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_text_field.dart',
    members: [
      VDocApiMember(
        name: 'VTextField',
        kind: 'constructor',
        signature: 'const VTextField({',
      ),
      VDocApiMember(
        name: 'autofocus',
        kind: 'field',
        signature: 'final bool autofocus;',
      ),
      VDocApiMember(
        name: 'contextMenuBuilder',
        kind: 'field',
        signature: 'final VTextFieldContextMenuBuilder? contextMenuBuilder;',
      ),
      VDocApiMember(
        name: 'controller',
        kind: 'field',
        signature: 'final TextEditingController? controller;',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'errorText',
        kind: 'field',
        signature: 'final String? errorText;',
      ),
      VDocApiMember(
        name: 'focusNode',
        kind: 'field',
        signature: 'final FocusNode? focusNode;',
      ),
      VDocApiMember(
        name: 'hint',
        kind: 'field',
        signature: 'final String? hint;',
      ),
      VDocApiMember(
        name: 'inputFormatters',
        kind: 'field',
        signature: 'final List<TextInputFormatter>? inputFormatters;',
      ),
      VDocApiMember(
        name: 'keyboardType',
        kind: 'field',
        signature: 'final TextInputType? keyboardType;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String? label;',
      ),
      VDocApiMember(
        name: 'leading',
        kind: 'field',
        signature: 'final Widget? leading;',
      ),
      VDocApiMember(
        name: 'maxLines',
        kind: 'field',
        signature: 'final int maxLines;',
      ),
      VDocApiMember(
        name: 'minLines',
        kind: 'field',
        signature: 'final int? minLines;',
      ),
      VDocApiMember(
        name: 'obscureText',
        kind: 'field',
        signature: 'final bool obscureText;',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<String>? onChanged;',
      ),
      VDocApiMember(
        name: 'onSubmitted',
        kind: 'field',
        signature: 'final ValueChanged<String>? onSubmitted;',
      ),
      VDocApiMember(
        name: 'readOnly',
        kind: 'field',
        signature: 'final bool readOnly;',
      ),
      VDocApiMember(
        name: 'semanticLabel',
        kind: 'field',
        signature: 'final String? semanticLabel;',
      ),
      VDocApiMember(
        name: 'textCapitalization',
        kind: 'field',
        signature: 'final TextCapitalization textCapitalization;',
      ),
      VDocApiMember(
        name: 'textInputAction',
        kind: 'field',
        signature: 'final TextInputAction? textInputAction;',
      ),
      VDocApiMember(
        name: 'trailing',
        kind: 'field',
        signature: 'final Widget? trailing;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VTextField> createState() => _VTextFieldState();',
      ),
    ],
  ),
  'VTextFieldContextMenuBuilder': VDocApiSymbol(
    name: 'VTextFieldContextMenuBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/forms/v_text_field.dart',
    members: [
      VDocApiMember(
        name: 'VTextFieldContextMenuBuilder',
        kind: 'typedef',
        signature: 'typedef VTextFieldContextMenuBuilder = Widget Function(',
      ),
    ],
  ),
  'VTextFieldContextMenuData': VDocApiSymbol(
    name: 'VTextFieldContextMenuData',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_text_field.dart',
    members: [
      VDocApiMember(
        name: 'VTextFieldContextMenuData',
        kind: 'constructor',
        signature: 'const VTextFieldContextMenuData({',
      ),
      VDocApiMember(
        name: 'hasSelection',
        kind: 'field',
        signature: 'final bool hasSelection;',
      ),
      VDocApiMember(
        name: 'hasText',
        kind: 'field',
        signature: 'final bool hasText;',
      ),
      VDocApiMember(
        name: 'isDesktop',
        kind: 'field',
        signature: 'final bool isDesktop;',
      ),
      VDocApiMember(
        name: 'items',
        kind: 'field',
        signature: 'final List<VTextFieldContextMenuItem> items;',
      ),
      VDocApiMember(
        name: 'obscureText',
        kind: 'field',
        signature: 'final bool obscureText;',
      ),
      VDocApiMember(
        name: 'readOnly',
        kind: 'field',
        signature: 'final bool readOnly;',
      ),
    ],
  ),
  'VTextFieldContextMenuItem': VDocApiSymbol(
    name: 'VTextFieldContextMenuItem',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_text_field.dart',
    members: [
      VDocApiMember(
        name: 'VTextFieldContextMenuItem',
        kind: 'constructor',
        signature: 'const VTextFieldContextMenuItem({',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String label;',
      ),
      VDocApiMember(
        name: 'onTap',
        kind: 'field',
        signature: 'final VoidCallback onTap;',
      ),
      VDocApiMember(
        name: 'shortcut',
        kind: 'field',
        signature: 'final String? shortcut;',
      ),
    ],
  ),
  'VTextSelectionMenu': VDocApiSymbol(
    name: 'VTextSelectionMenu',
    kind: 'class',
    library: 'lib/src/widgets/selection/v_text_selection_menu.dart',
    members: [
      VDocApiMember(
        name: 'VTextSelectionMenu',
        kind: 'constructor',
        signature: 'const VTextSelectionMenu({',
      ),
      VDocApiMember(
        name: 'isDesktop',
        kind: 'field',
        signature: 'final bool? isDesktop;',
      ),
      VDocApiMember(
        name: 'items',
        kind: 'field',
        signature: 'final List<VTextSelectionMenuItem> items;',
      ),
      VDocApiMember(
        name: 'state',
        kind: 'field',
        signature: 'final EditableTextState state;',
      ),
      VDocApiMember(
        name: 'theme',
        kind: 'field',
        signature: 'final VThemeData theme;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VTextSelectionMenu> createState() => _VTextSelectionMenuState();',
      ),
    ],
  ),
  'VTextSelectionMenuItem': VDocApiSymbol(
    name: 'VTextSelectionMenuItem',
    kind: 'class',
    library: 'lib/src/widgets/selection/v_text_selection_menu.dart',
    members: [
      VDocApiMember(
        name: 'VTextSelectionMenuItem',
        kind: 'constructor',
        signature: 'const VTextSelectionMenuItem({',
      ),
      VDocApiMember(
        name: 'enabled',
        kind: 'field',
        signature: 'final bool enabled;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final String label;',
      ),
      VDocApiMember(
        name: 'onTap',
        kind: 'field',
        signature: 'final VoidCallback onTap;',
      ),
      VDocApiMember(
        name: 'shortcut',
        kind: 'field',
        signature: 'final String? shortcut;',
      ),
    ],
  ),
  'VTextSelectionMenuLayoutDelegate': VDocApiSymbol(
    name: 'VTextSelectionMenuLayoutDelegate',
    kind: 'class',
    library: 'lib/src/widgets/selection/v_text_selection_menu.dart',
    members: [
      VDocApiMember(
        name: 'VTextSelectionMenuLayoutDelegate',
        kind: 'constructor',
        signature: 'VTextSelectionMenuLayoutDelegate({',
      ),
      VDocApiMember(
        name: 'isDesktop',
        kind: 'field',
        signature: 'final bool isDesktop;',
      ),
      VDocApiMember(
        name: 'margin',
        kind: 'field',
        signature: 'final double margin;',
      ),
      VDocApiMember(
        name: 'primaryAnchor',
        kind: 'field',
        signature: 'final Offset primaryAnchor;',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'field',
        signature: 'final double radius;',
      ),
      VDocApiMember(
        name: 'secondaryAnchor',
        kind: 'field',
        signature: 'final Offset secondaryAnchor;',
      ),
      VDocApiMember(
        name: 'getConstraintsForChild',
        kind: 'method',
        signature: 'BoxConstraints getConstraintsForChild(BoxConstraints constraints) {',
      ),
      VDocApiMember(
        name: 'getPositionForChild',
        kind: 'method',
        signature: 'Offset getPositionForChild(Size size, Size childSize) {',
      ),
      VDocApiMember(
        name: 'shouldRelayout',
        kind: 'method',
        signature: 'bool shouldRelayout(VTextSelectionMenuLayoutDelegate oldDelegate) {',
      ),
    ],
  ),
  'VTextSpan': VDocApiSymbol(
    name: 'VTextSpan',
    kind: 'class',
    library: 'lib/src/widgets/basic/v_rich_text.dart',
    members: [
      VDocApiMember(
        name: 'VTextSpan',
        kind: 'constructor',
        signature: 'const VTextSpan(',
      ),
      VDocApiMember(
        name: 'bold',
        kind: 'field',
        signature: 'final bool bold;',
      ),
      VDocApiMember(
        name: 'color',
        kind: 'field',
        signature: 'final Color? color;',
      ),
      VDocApiMember(
        name: 'italic',
        kind: 'field',
        signature: 'final bool italic;',
      ),
      VDocApiMember(
        name: 'size',
        kind: 'field',
        signature: 'final double? size;',
      ),
      VDocApiMember(
        name: 'text',
        kind: 'field',
        signature: 'final String text;',
      ),
      VDocApiMember(
        name: 'underline',
        kind: 'field',
        signature: 'final bool underline;',
      ),
    ],
  ),
  'VTextVariant': VDocApiSymbol(
    name: 'VTextVariant',
    kind: 'enum',
    library: 'lib/src/widgets/basic/v_text.dart',
    members: [
      VDocApiMember(
        name: 'heading',
        kind: 'value',
        signature: 'heading',
      ),
      VDocApiMember(
        name: 'title',
        kind: 'value',
        signature: 'title',
      ),
      VDocApiMember(
        name: 'subtitle',
        kind: 'value',
        signature: 'subtitle',
      ),
      VDocApiMember(
        name: 'body',
        kind: 'value',
        signature: 'body',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'value',
        signature: 'label',
      ),
      VDocApiMember(
        name: 'caption',
        kind: 'value',
        signature: 'caption',
      ),
    ],
  ),
  'VTheme': VDocApiSymbol(
    name: 'VTheme',
    kind: 'class',
    library: 'lib/src/theme/v_theme.dart',
    members: [
      VDocApiMember(
        name: 'VTheme',
        kind: 'constructor',
        signature: 'const VTheme({',
      ),
      VDocApiMember(
        name: 'data',
        kind: 'field',
        signature: 'final VThemeData data;',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VThemeData of(BuildContext context) {',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
      VDocApiMember(
        name: 'updateShouldNotify',
        kind: 'method',
        signature: 'bool updateShouldNotify(VTheme oldWidget) => data != oldWidget.data;',
      ),
    ],
  ),
  'VThemeData': VDocApiSymbol(
    name: 'VThemeData',
    kind: 'class',
    library: 'lib/src/theme/v_theme_data.dart',
    members: [
      VDocApiMember(
        name: 'VThemeData',
        kind: 'constructor',
        signature: 'const VThemeData({',
      ),
      VDocApiMember(
        name: 'VThemeData.dark',
        kind: 'constructor',
        signature: 'factory VThemeData.dark() {',
      ),
      VDocApiMember(
        name: 'VThemeData.light',
        kind: 'constructor',
        signature: 'factory VThemeData.light() {',
      ),
      VDocApiMember(
        name: 'breakpoints',
        kind: 'field',
        signature: 'final VBreakpointValues breakpoints;',
      ),
      VDocApiMember(
        name: 'colors',
        kind: 'field',
        signature: 'final VColors colors;',
      ),
      VDocApiMember(
        name: 'components',
        kind: 'field',
        signature: 'final VComponentTokens components;',
      ),
      VDocApiMember(
        name: 'motion',
        kind: 'field',
        signature: 'final VMotion motion;',
      ),
      VDocApiMember(
        name: 'radii',
        kind: 'field',
        signature: 'final VRadii radii;',
      ),
      VDocApiMember(
        name: 'shadows',
        kind: 'field',
        signature: 'final VShadows shadows;',
      ),
      VDocApiMember(
        name: 'sizes',
        kind: 'field',
        signature: 'final VSizes sizes;',
      ),
      VDocApiMember(
        name: 'spacing',
        kind: 'field',
        signature: 'final VSpacing spacing;',
      ),
      VDocApiMember(
        name: 'typography',
        kind: 'field',
        signature: 'final VTypography typography;',
      ),
      VDocApiMember(
        name: 'applyOverrides',
        kind: 'method',
        signature: 'VThemeData applyOverrides({',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VThemeData copyWith({',
      ),
      VDocApiMember(
        name: 'debugFillProperties',
        kind: 'method',
        signature: 'void debugFillProperties(DiagnosticPropertiesBuilder properties) {',
      ),
      VDocApiMember(
        name: 'hashCode',
        kind: 'method',
        signature: 'int get hashCode => Object.hash(colors, typography, spacing, radii, sizes,',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VThemeData lerp(VThemeData a, VThemeData b, double t) {',
      ),
      VDocApiMember(
        name: 'operator',
        kind: 'method',
        signature: 'bool operator ==(Object other) {',
      ),
      VDocApiMember(
        name: 'shadow',
        kind: 'method',
        signature: 'BoxShadow? shadow(VElevation elevation) => shadows.resolve(elevation);',
      ),
      VDocApiMember(
        name: 'surfaceColor',
        kind: 'method',
        signature: 'Color surfaceColor(VElevation elevation) => colors.surfaceColor(elevation);',
      ),
    ],
  ),
  'VThemeDataTween': VDocApiSymbol(
    name: 'VThemeDataTween',
    kind: 'class',
    library: 'lib/src/theme/v_animated_theme.dart',
    members: [
      VDocApiMember(
        name: 'VThemeDataTween',
        kind: 'constructor',
        signature: 'VThemeDataTween({super.begin, super.end});',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'VThemeData lerp(double t) {',
      ),
    ],
  ),
  'VThemeMode': VDocApiSymbol(
    name: 'VThemeMode',
    kind: 'enum',
    library: 'lib/src/theme/v_theme_mode.dart',
    members: [
      VDocApiMember(
        name: 'light',
        kind: 'value',
        signature: 'light',
      ),
      VDocApiMember(
        name: 'dark',
        kind: 'value',
        signature: 'dark',
      ),
      VDocApiMember(
        name: 'system',
        kind: 'value',
        signature: 'system',
      ),
    ],
  ),
  'VThemeTokenOverride': VDocApiSymbol(
    name: 'VThemeTokenOverride',
    kind: 'typedef',
    library: 'lib/src/theme/v_theme_data.dart',
    members: [
      VDocApiMember(
        name: 'VThemeTokenOverride',
        kind: 'typedef',
        signature: 'typedef VThemeTokenOverride<T> = T Function(T value);',
      ),
    ],
  ),
  'VTimeLine': VDocApiSymbol(
    name: 'VTimeLine',
    kind: 'class',
    library: 'lib/src/widgets/feedback/v_timeline.dart',
    members: [
      VDocApiMember(
        name: 'VTimeLine',
        kind: 'constructor',
        signature: 'const VTimeLine({',
      ),
      VDocApiMember(
        name: 'items',
        kind: 'field',
        signature: 'final List<VTimeLineItem> items;',
      ),
      VDocApiMember(
        name: 'spacing',
        kind: 'field',
        signature: 'final double spacing;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
  'VTimeLineItem': VDocApiSymbol(
    name: 'VTimeLineItem',
    kind: 'class',
    library: 'lib/src/widgets/feedback/v_timeline.dart',
    members: [
      VDocApiMember(
        name: 'VTimeLineItem',
        kind: 'constructor',
        signature: 'const VTimeLineItem({',
      ),
      VDocApiMember(
        name: 'description',
        kind: 'field',
        signature: 'final Widget? description;',
      ),
      VDocApiMember(
        name: 'leading',
        kind: 'field',
        signature: 'final Widget? leading;',
      ),
      VDocApiMember(
        name: 'onTap',
        kind: 'field',
        signature: 'final VoidCallback? onTap;',
      ),
      VDocApiMember(
        name: 'status',
        kind: 'field',
        signature: 'final VTimeLineStatus status;',
      ),
      VDocApiMember(
        name: 'subtitle',
        kind: 'field',
        signature: 'final Widget? subtitle;',
      ),
      VDocApiMember(
        name: 'title',
        kind: 'field',
        signature: 'final Widget? title;',
      ),
    ],
  ),
  'VTimeLineStatus': VDocApiSymbol(
    name: 'VTimeLineStatus',
    kind: 'enum',
    library: 'lib/src/widgets/feedback/v_timeline.dart',
    members: [
      VDocApiMember(
        name: 'pending',
        kind: 'value',
        signature: 'pending',
      ),
      VDocApiMember(
        name: 'active',
        kind: 'value',
        signature: 'active',
      ),
      VDocApiMember(
        name: 'completed',
        kind: 'value',
        signature: 'completed',
      ),
      VDocApiMember(
        name: 'error',
        kind: 'value',
        signature: 'error',
      ),
    ],
  ),
  'VTimeLineTheme': VDocApiSymbol(
    name: 'VTimeLineTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VTimeLineTheme',
        kind: 'constructor',
        signature: 'const VTimeLineTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VTimeLineTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VTimeLineTokens': VDocApiSymbol(
    name: 'VTimeLineTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_timeline_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VTimeLineTokens',
        kind: 'constructor',
        signature: 'const VTimeLineTokens({',
      ),
      VDocApiMember(
        name: 'VTimeLineTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VTimeLineTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'activeLineColor',
        kind: 'field',
        signature: 'final Color activeLineColor;',
      ),
      VDocApiMember(
        name: 'activeNodeColor',
        kind: 'field',
        signature: 'final Color activeNodeColor;',
      ),
      VDocApiMember(
        name: 'activeNodeFg',
        kind: 'field',
        signature: 'final Color activeNodeFg;',
      ),
      VDocApiMember(
        name: 'completedLineColor',
        kind: 'field',
        signature: 'final Color completedLineColor;',
      ),
      VDocApiMember(
        name: 'completedNodeColor',
        kind: 'field',
        signature: 'final Color completedNodeColor;',
      ),
      VDocApiMember(
        name: 'completedNodeFg',
        kind: 'field',
        signature: 'final Color completedNodeFg;',
      ),
      VDocApiMember(
        name: 'errorLineColor',
        kind: 'field',
        signature: 'final Color errorLineColor;',
      ),
      VDocApiMember(
        name: 'errorNodeColor',
        kind: 'field',
        signature: 'final Color errorNodeColor;',
      ),
      VDocApiMember(
        name: 'errorNodeFg',
        kind: 'field',
        signature: 'final Color errorNodeFg;',
      ),
      VDocApiMember(
        name: 'lineWidth',
        kind: 'field',
        signature: 'final double lineWidth;',
      ),
      VDocApiMember(
        name: 'nodeSize',
        kind: 'field',
        signature: 'final double nodeSize;',
      ),
      VDocApiMember(
        name: 'pendingLineColor',
        kind: 'field',
        signature: 'final Color pendingLineColor;',
      ),
      VDocApiMember(
        name: 'pendingNodeColor',
        kind: 'field',
        signature: 'final Color pendingNodeColor;',
      ),
      VDocApiMember(
        name: 'pendingNodeFg',
        kind: 'field',
        signature: 'final Color pendingNodeFg;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VTimeLineTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VTimeLineTokens lerp(VTimeLineTokens a, VTimeLineTokens b, double t) {',
      ),
    ],
  ),
  'VTimeOfDay': VDocApiSymbol(
    name: 'VTimeOfDay',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_time_picker.dart',
    members: [
      VDocApiMember(
        name: 'VTimeOfDay',
        kind: 'constructor',
        signature: 'const VTimeOfDay({required this.hour, required this.minute})',
      ),
      VDocApiMember(
        name: 'hour',
        kind: 'field',
        signature: 'final int hour;',
      ),
      VDocApiMember(
        name: 'minute',
        kind: 'field',
        signature: 'final int minute;',
      ),
      VDocApiMember(
        name: 'toString',
        kind: 'method',
        signature: 'String toString() =>',
      ),
    ],
  ),
  'VTimePicker': VDocApiSymbol(
    name: 'VTimePicker',
    kind: 'class',
    library: 'lib/src/widgets/forms/v_time_picker.dart',
    members: [
      VDocApiMember(
        name: 'VTimePicker',
        kind: 'constructor',
        signature: 'const VTimePicker({',
      ),
      VDocApiMember(
        name: 'onChanged',
        kind: 'field',
        signature: 'final ValueChanged<VTimeOfDay>? onChanged;',
      ),
      VDocApiMember(
        name: 'selected',
        kind: 'field',
        signature: 'final VTimeOfDay? selected;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VTimePicker> createState() => _VTimePickerState();',
      ),
    ],
  ),
  'VTimePickerTheme': VDocApiSymbol(
    name: 'VTimePickerTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VTimePickerTheme',
        kind: 'constructor',
        signature: 'const VTimePickerTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VTimePickerTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VTimePickerTokens': VDocApiSymbol(
    name: 'VTimePickerTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_time_picker_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VTimePickerTokens',
        kind: 'constructor',
        signature: 'const VTimePickerTokens({',
      ),
      VDocApiMember(
        name: 'VTimePickerTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VTimePickerTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'columnWidth',
        kind: 'field',
        signature: 'final double columnWidth;',
      ),
      VDocApiMember(
        name: 'diameterRatio',
        kind: 'field',
        signature: 'final double diameterRatio;',
      ),
      VDocApiMember(
        name: 'itemForeground',
        kind: 'field',
        signature: 'final Color itemForeground;',
      ),
      VDocApiMember(
        name: 'itemHeight',
        kind: 'field',
        signature: 'final double itemHeight;',
      ),
      VDocApiMember(
        name: 'selectedForeground',
        kind: 'field',
        signature: 'final Color selectedForeground;',
      ),
      VDocApiMember(
        name: 'wheelHeight',
        kind: 'field',
        signature: 'final double wheelHeight;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VTimePickerTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VTimePickerTokens lerp(',
      ),
    ],
  ),
  'VToast': VDocApiSymbol(
    name: 'VToast',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_toast.dart',
    members: [
      VDocApiMember(
        name: 'show',
        kind: 'method',
        signature: 'static void show(',
      ),
    ],
  ),
  'VToastActionBuilder': VDocApiSymbol(
    name: 'VToastActionBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/overlays/v_toast.dart',
    members: [
      VDocApiMember(
        name: 'VToastActionBuilder',
        kind: 'typedef',
        signature: 'typedef VToastActionBuilder = Widget Function(',
      ),
    ],
  ),
  'VToastHandle': VDocApiSymbol(
    name: 'VToastHandle',
    kind: 'class',
    library: 'lib/src/foundation/overlay.dart',
    members: [
      VDocApiMember(
        name: 'position',
        kind: 'field',
        signature: 'VToastPosition get position;',
      ),
      VDocApiMember(
        name: 'stackMode',
        kind: 'field',
        signature: 'VToastStackMode get stackMode;',
      ),
    ],
  ),
  'VToastPosition': VDocApiSymbol(
    name: 'VToastPosition',
    kind: 'enum',
    library: 'lib/src/foundation/toast.dart',
    members: [
      VDocApiMember(
        name: 'bottom',
        kind: 'value',
        signature: 'bottom',
      ),
      VDocApiMember(
        name: 'top',
        kind: 'value',
        signature: 'top',
      ),
      VDocApiMember(
        name: 'center',
        kind: 'value',
        signature: 'center',
      ),
    ],
  ),
  'VToastStackMode': VDocApiSymbol(
    name: 'VToastStackMode',
    kind: 'enum',
    library: 'lib/src/foundation/toast.dart',
    members: [
      VDocApiMember(
        name: 'replace',
        kind: 'value',
        signature: 'replace',
      ),
      VDocApiMember(
        name: 'stack',
        kind: 'value',
        signature: 'stack',
      ),
    ],
  ),
  'VToastTheme': VDocApiSymbol(
    name: 'VToastTheme',
    kind: 'class',
    library: 'lib/src/theme/v_component_themes.g.dart',
    members: [
      VDocApiMember(
        name: 'VToastTheme',
        kind: 'constructor',
        signature: 'const VToastTheme({',
      ),
      VDocApiMember(
        name: 'of',
        kind: 'method',
        signature: 'static VToastTokens? of(BuildContext context) =>',
      ),
      VDocApiMember(
        name: 'override',
        kind: 'method',
        signature: 'static Widget override({',
      ),
    ],
  ),
  'VToastTokens': VDocApiSymbol(
    name: 'VToastTokens',
    kind: 'class',
    library: 'lib/src/theme/component_tokens/v_toast_tokens.dart',
    members: [
      VDocApiMember(
        name: 'VToastTokens',
        kind: 'constructor',
        signature: 'const VToastTokens({',
      ),
      VDocApiMember(
        name: 'VToastTokens.fromColors',
        kind: 'constructor',
        signature: 'factory VToastTokens.fromColors(VColors colors) {',
      ),
      VDocApiMember(
        name: 'borderColor',
        kind: 'field',
        signature: 'final Color borderColor;',
      ),
      VDocApiMember(
        name: 'borderWidth',
        kind: 'field',
        signature: 'final double borderWidth;',
      ),
      VDocApiMember(
        name: 'errorBackground',
        kind: 'field',
        signature: 'final Color errorBackground;',
      ),
      VDocApiMember(
        name: 'errorForeground',
        kind: 'field',
        signature: 'final Color errorForeground;',
      ),
      VDocApiMember(
        name: 'horizontalInset',
        kind: 'field',
        signature: 'final double horizontalInset;',
      ),
      VDocApiMember(
        name: 'iconSize',
        kind: 'field',
        signature: 'final double iconSize;',
      ),
      VDocApiMember(
        name: 'infoBackground',
        kind: 'field',
        signature: 'final Color infoBackground;',
      ),
      VDocApiMember(
        name: 'infoForeground',
        kind: 'field',
        signature: 'final Color infoForeground;',
      ),
      VDocApiMember(
        name: 'paddingHorizontal',
        kind: 'field',
        signature: 'final double paddingHorizontal;',
      ),
      VDocApiMember(
        name: 'paddingVertical',
        kind: 'field',
        signature: 'final double paddingVertical;',
      ),
      VDocApiMember(
        name: 'radius',
        kind: 'field',
        signature: 'final double radius;',
      ),
      VDocApiMember(
        name: 'shadow',
        kind: 'field',
        signature: 'final BoxShadow? shadow;',
      ),
      VDocApiMember(
        name: 'slideOffsetY',
        kind: 'field',
        signature: 'final double slideOffsetY;',
      ),
      VDocApiMember(
        name: 'spacing',
        kind: 'field',
        signature: 'final double spacing;',
      ),
      VDocApiMember(
        name: 'successBackground',
        kind: 'field',
        signature: 'final Color successBackground;',
      ),
      VDocApiMember(
        name: 'successForeground',
        kind: 'field',
        signature: 'final Color successForeground;',
      ),
      VDocApiMember(
        name: 'textSize',
        kind: 'field',
        signature: 'final double textSize;',
      ),
      VDocApiMember(
        name: 'verticalInset',
        kind: 'field',
        signature: 'final double verticalInset;',
      ),
      VDocApiMember(
        name: 'warningBackground',
        kind: 'field',
        signature: 'final Color warningBackground;',
      ),
      VDocApiMember(
        name: 'warningForeground',
        kind: 'field',
        signature: 'final Color warningForeground;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VToastTokens copyWith({',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VToastTokens lerp(VToastTokens a, VToastTokens b, double t) {',
      ),
    ],
  ),
  'VToastVariant': VDocApiSymbol(
    name: 'VToastVariant',
    kind: 'enum',
    library: 'lib/src/widgets/overlays/v_toast.dart',
    members: [
      VDocApiMember(
        name: 'info',
        kind: 'value',
        signature: 'info',
      ),
      VDocApiMember(
        name: 'success',
        kind: 'value',
        signature: 'success',
      ),
      VDocApiMember(
        name: 'warning',
        kind: 'value',
        signature: 'warning',
      ),
      VDocApiMember(
        name: 'error',
        kind: 'value',
        signature: 'error',
      ),
    ],
  ),
  'VTokenTheme': VDocApiSymbol(
    name: 'VTokenTheme',
    kind: 'class',
    library: 'lib/src/theme/v_token_theme.dart',
    members: [
      VDocApiMember(
        name: 'VTokenTheme',
        kind: 'constructor',
        signature: 'const VTokenTheme({',
      ),
      VDocApiMember(
        name: 'data',
        kind: 'field',
        signature: 'final T data;',
      ),
      VDocApiMember(
        name: 'updateShouldNotify',
        kind: 'method',
        signature: 'bool updateShouldNotify(VTokenTheme<T> oldWidget) => data != oldWidget.data;',
      ),
    ],
  ),
  'VTooltip': VDocApiSymbol(
    name: 'VTooltip',
    kind: 'class',
    library: 'lib/src/widgets/overlays/v_tooltip.dart',
    members: [
      VDocApiMember(
        name: 'VTooltip',
        kind: 'constructor',
        signature: 'const VTooltip({',
      ),
      VDocApiMember(
        name: 'child',
        kind: 'field',
        signature: 'final Widget child;',
      ),
      VDocApiMember(
        name: 'maxWidth',
        kind: 'field',
        signature: 'final double maxWidth;',
      ),
      VDocApiMember(
        name: 'message',
        kind: 'field',
        signature: 'final String message;',
      ),
      VDocApiMember(
        name: 'showDuration',
        kind: 'field',
        signature: 'final Duration showDuration;',
      ),
      VDocApiMember(
        name: 'waitDuration',
        kind: 'field',
        signature: 'final Duration waitDuration;',
      ),
      VDocApiMember(
        name: 'createState',
        kind: 'method',
        signature: 'State<VTooltip> createState() => _VTooltipState();',
      ),
    ],
  ),
  'VTransitionBuilder': VDocApiSymbol(
    name: 'VTransitionBuilder',
    kind: 'typedef',
    library: 'lib/src/widgets/animation/v_animated_switcher.dart',
    members: [
      VDocApiMember(
        name: 'VTransitionBuilder',
        kind: 'typedef',
        signature: 'typedef VTransitionBuilder = Widget Function(',
      ),
    ],
  ),
  'VTypography': VDocApiSymbol(
    name: 'VTypography',
    kind: 'class',
    library: 'lib/src/foundation/typography.dart',
    members: [
      VDocApiMember(
        name: 'VTypography',
        kind: 'constructor',
        signature: 'const VTypography({',
      ),
      VDocApiMember(
        name: 'VTypography.defaults',
        kind: 'constructor',
        signature: 'factory VTypography.defaults() {',
      ),
      VDocApiMember(
        name: 'body',
        kind: 'field',
        signature: 'final TextStyle body;',
      ),
      VDocApiMember(
        name: 'caption',
        kind: 'field',
        signature: 'final TextStyle caption;',
      ),
      VDocApiMember(
        name: 'heading',
        kind: 'field',
        signature: 'final TextStyle heading;',
      ),
      VDocApiMember(
        name: 'label',
        kind: 'field',
        signature: 'final TextStyle label;',
      ),
      VDocApiMember(
        name: 'subtitle',
        kind: 'field',
        signature: 'final TextStyle subtitle;',
      ),
      VDocApiMember(
        name: 'title',
        kind: 'field',
        signature: 'final TextStyle title;',
      ),
      VDocApiMember(
        name: 'copyWith',
        kind: 'method',
        signature: 'VTypography copyWith({',
      ),
      VDocApiMember(
        name: 'debugFillProperties',
        kind: 'method',
        signature: 'void debugFillProperties(DiagnosticPropertiesBuilder properties) {',
      ),
      VDocApiMember(
        name: 'hashCode',
        kind: 'method',
        signature: 'int get hashCode => _\$VTypographyHash(this);',
      ),
      VDocApiMember(
        name: 'lerp',
        kind: 'method',
        signature: 'static VTypography lerp(VTypography a, VTypography b, double t) =>',
      ),
      VDocApiMember(
        name: 'operator',
        kind: 'method',
        signature: 'bool operator ==(Object other) => _\$VTypographyEq(this, other);',
      ),
    ],
  ),
  'VidraApp': VDocApiSymbol(
    name: 'VidraApp',
    kind: 'class',
    library: 'lib/src/app/vidra_app.dart',
    members: [
      VDocApiMember(
        name: 'VidraApp.navigator',
        kind: 'constructor',
        signature: 'factory VidraApp.navigator({',
      ),
      VDocApiMember(
        name: 'VidraApp.router',
        kind: 'constructor',
        signature: 'factory VidraApp.router({',
      ),
      VDocApiMember(
        name: 'actions',
        kind: 'field',
        signature: 'final Map<Type, Action<Intent>>? actions;',
      ),
      VDocApiMember(
        name: 'adapter',
        kind: 'field',
        signature: 'final VRouteAdapter adapter;',
      ),
      VDocApiMember(
        name: 'darkTheme',
        kind: 'field',
        signature: 'final VThemeData? darkTheme;',
      ),
      VDocApiMember(
        name: 'locale',
        kind: 'field',
        signature: 'final Locale? locale;',
      ),
      VDocApiMember(
        name: 'shortcuts',
        kind: 'field',
        signature: 'final Map<ShortcutActivator, Intent>? shortcuts;',
      ),
      VDocApiMember(
        name: 'supportedLocales',
        kind: 'field',
        signature: 'final Iterable<Locale> supportedLocales;',
      ),
      VDocApiMember(
        name: 'textDirection',
        kind: 'field',
        signature: 'final TextDirection textDirection;',
      ),
      VDocApiMember(
        name: 'theme',
        kind: 'field',
        signature: 'final VThemeData? theme;',
      ),
      VDocApiMember(
        name: 'themeMode',
        kind: 'field',
        signature: 'final VThemeMode themeMode;',
      ),
      VDocApiMember(
        name: 'title',
        kind: 'field',
        signature: 'final String title;',
      ),
      VDocApiMember(
        name: 'build',
        kind: 'method',
        signature: 'Widget build(BuildContext context) {',
      ),
    ],
  ),
};
