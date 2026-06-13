part of '../../main.dart';

/// Registry mapping each _DemoCategory to its metadata and builder.
/// Adding a new demo: add one case to each switch below + one entry
/// to _sidebarSections in main.dart. The `part` directive + `_DemoCategory`
/// enum value are no longer required — the category is inferred from the
/// registry entry.

// ---------------------------------------------------------------------------
// Section grouping
// ---------------------------------------------------------------------------

_DemoSection _sectionFor(_DemoCategory c) => switch (c) {
  _DemoCategory.tokens ||
  _DemoCategory.theme ||
  _DemoCategory.appearance ||
  _DemoCategory.typography ||
  _DemoCategory.selectableText ||
  _DemoCategory.richText ||
  _DemoCategory.responsive =>
    _DemoSection('基础与主题'),
  _DemoCategory.appShell ||
  _DemoCategory.layout ||
  _DemoCategory.surface ||
  _DemoCategory.elevation ||
  _DemoCategory.appBar ||
  _DemoCategory.resizable ||
  _DemoCategory.scrollArea ||
  _DemoCategory.stickyHeader =>
    _DemoSection('页面结构'),
  _DemoCategory.buttons ||
  _DemoCategory.chips ||
  _DemoCategory.toggles ||
  _DemoCategory.textField ||
  _DemoCategory.autoSuggest ||
  _DemoCategory.form ||
  _DemoCategory.select ||
  _DemoCategory.slider ||
  _DemoCategory.datePicker ||
  _DemoCategory.segmentedControl =>
    _DemoSection('输入与选择'),
  _DemoCategory.tabs ||
  _DemoCategory.listTile ||
  _DemoCategory.swipeActions ||
  _DemoCategory.table ||
  _DemoCategory.carousel ||
  _DemoCategory.accordion ||
  _DemoCategory.navigationBar ||
  _DemoCategory.pagination ||
  _DemoCategory.numberBox ||
  _DemoCategory.steps ||
  _DemoCategory.timeline =>
    _DemoSection('导航与数据展示'),
  _DemoCategory.overlay ||
  _DemoCategory.menu ||
  _DemoCategory.contextMenu ||
  _DemoCategory.bottomSheet ||
  _DemoCategory.tooltip ||
  _DemoCategory.teachingTip ||
  _DemoCategory.progress ||
  _DemoCategory.divider ||
  _DemoCategory.skeleton ||
  _DemoCategory.emptyState ||
  _DemoCategory.misc =>
    _DemoSection('反馈与浮层'),
  _DemoCategory.media ||
  _DemoCategory.motion ||
  _DemoCategory.animation ||
  _DemoCategory.animatedList ||
  _DemoCategory.scrollableList ||
  _DemoCategory.scrollableGrid ||
  _DemoCategory.animatedSwitcher ||
  _DemoCategory.pageTransitions ||
  _DemoCategory.dynamicLoading ||
  _DemoCategory.heroMasonry ||
  _DemoCategory.animatedText =>
    _DemoSection('媒体与动效'),
};

// ---------------------------------------------------------------------------
// Chinese titles
// ---------------------------------------------------------------------------

String _zhTitleFor(_DemoCategory c) => switch (c) {
  _DemoCategory.tokens => '设计令牌',
  _DemoCategory.theme => '主题覆写',
  _DemoCategory.appearance => '外观系统',
  _DemoCategory.typography => '排版',
  _DemoCategory.selectableText => '可选文本',
  _DemoCategory.richText => '富文本',
  _DemoCategory.responsive => '响应式',
  _DemoCategory.appShell => '应用壳',
  _DemoCategory.layout => '布局',
  _DemoCategory.surface => '表面变体',
  _DemoCategory.elevation => '高程',
  _DemoCategory.appBar => '应用栏',
  _DemoCategory.resizable => '可调整大小',
  _DemoCategory.scrollArea => '滚动区域',
  _DemoCategory.stickyHeader => '粘性头部',
  _DemoCategory.buttons => '按钮',
  _DemoCategory.chips => '碎片',
  _DemoCategory.toggles => '开关',
  _DemoCategory.textField => '文本字段',
  _DemoCategory.autoSuggest => '自动建议',
  _DemoCategory.form => '表单',
  _DemoCategory.select => '选择器',
  _DemoCategory.slider => '滑块',
  _DemoCategory.datePicker => '日期选择',
  _DemoCategory.segmentedControl => '分段控件',
  _DemoCategory.tabs => '选项卡',
  _DemoCategory.listTile => '列表项',
  _DemoCategory.swipeActions => '滑动操作',
  _DemoCategory.table => '表格',
  _DemoCategory.carousel => '轮播',
  _DemoCategory.accordion => '手风琴',
  _DemoCategory.navigationBar => '导航栏',
  _DemoCategory.pagination => '分页',
  _DemoCategory.numberBox => '数字框',
  _DemoCategory.steps => '步骤',
  _DemoCategory.timeline => '时间线',
  _DemoCategory.overlay => '浮层',
  _DemoCategory.menu => '菜单',
  _DemoCategory.contextMenu => '上下文菜单',
  _DemoCategory.bottomSheet => '底部面板',
  _DemoCategory.tooltip => '工具提示',
  _DemoCategory.teachingTip => '教学提示',
  _DemoCategory.progress => '进度',
  _DemoCategory.divider => '分割线',
  _DemoCategory.skeleton => '骨架屏',
  _DemoCategory.emptyState => '空状态',
  _DemoCategory.misc => '杂项',
  _DemoCategory.media => '媒体',
  _DemoCategory.motion => '动效',
  _DemoCategory.animation => '动画',
  _DemoCategory.animatedList => '动画列表',
  _DemoCategory.scrollableList => '可滚动列表',
  _DemoCategory.scrollableGrid => '可滚动网格',
  _DemoCategory.animatedSwitcher => '动画切换',
  _DemoCategory.pageTransitions => '页面过渡',
  _DemoCategory.dynamicLoading => '动态加载',
  _DemoCategory.heroMasonry => '英雄网格',
  _DemoCategory.animatedText => '动画文本',
};

// ---------------------------------------------------------------------------
// Demo widget builders
// ---------------------------------------------------------------------------

Widget _buildDemo(BuildContext context, _DemoCategory category) {
  return switch (category) {
    _DemoCategory.chips => const _ChipsDemo(),
    _DemoCategory.buttons => const _ButtonsDemo(),
    _DemoCategory.toggles => const _TogglesDemo(),
    _DemoCategory.appearance => const _AppearanceDemo(),
    _DemoCategory.overlay => const _OverlayDemo(),
    _DemoCategory.bottomSheet => const _BottomSheetDemo(),
    _DemoCategory.animation => const _AnimationDemo(),
    _DemoCategory.motion => const _MotionDemo(),
    _DemoCategory.surface => const _SurfaceDemo(),
    _DemoCategory.typography => const _TypographyDemo(),
    _DemoCategory.selectableText => const _SelectableTextDemo(),
    _DemoCategory.select => const _SelectDemo(),
    _DemoCategory.menu => const _MenuDemo(),
    _DemoCategory.tabs => const _TabsDemo(),
    _DemoCategory.tooltip => const _TooltipDemo(),
    _DemoCategory.slider => const _SliderDemo(),
    _DemoCategory.media => const _MediaDemo(),
    _DemoCategory.progress => const _ProgressDemo(),
    _DemoCategory.divider => const _DividerDemo(),
    _DemoCategory.table => const _TableDemo(),
    _DemoCategory.form => const _FormDemo(),
    _DemoCategory.animatedList => const _AnimatedListDemo(),
    _DemoCategory.scrollableList => const _ScrollableListDemo(),
    _DemoCategory.scrollableGrid => const _ScrollableGridDemo(),
    _DemoCategory.skeleton => const _SkeletonDemo(),
    _DemoCategory.carousel => const _CarouselDemo(),
    _DemoCategory.richText => const _RichTextDemo(),
    _DemoCategory.listTile => const _ListTileDemo(),
    _DemoCategory.misc => const _MiscDemo(),
    _DemoCategory.datePicker => const _DatePickerDemo(),
    _DemoCategory.appShell => const _CoreDocsDemo(
        title: 'App Shell',
        body: 'VidraUI apps start from VidraApp, which configures WidgetsApp, routing, theme animation, scroll behavior, focus traversal, and overlay hosting.'),
    _DemoCategory.resizable => const _ResizableDemo(),
    _DemoCategory.layout => const _CoreDocsDemo(
        title: 'Layout',
        body: 'Use VScaffold for screen regions and VFlex/VBox for token-aware spacing. Compose surfaces and content directly instead of importing Material layout shells.'),
    _DemoCategory.tokens => const _CoreDocsDemo(
        title: 'Tokens',
        body: 'Theme values flow from primitive tokens to semantic colors, component tokens, and widgets. App code should consume VTheme.of(context) and scoped component themes.'),
    _DemoCategory.appBar => const _AppBarDemo(),
    _DemoCategory.swipeActions => const _SwipeActionsDemo(),
    _DemoCategory.responsive => const _ResponsiveDemo(),
    _DemoCategory.theme => const _ThemeDemo(),
    _DemoCategory.textField => const _TextFieldDemo(),
    _DemoCategory.scrollArea => const _ScrollAreaDemo(),
    _DemoCategory.pageTransitions => const _PageTransitionsDemo(),
    _DemoCategory.emptyState => const _EmptyStateDemo(),
    _DemoCategory.segmentedControl => const _SegmentedControlDemo(),
    _DemoCategory.accordion => const _AccordionDemo(),
    _DemoCategory.autoSuggest => const _AutoSuggestDemo(),
    _DemoCategory.teachingTip => const _TeachingTipDemo(),
    _DemoCategory.dynamicLoading => const _DynamicLoadingDemo(),
    _DemoCategory.heroMasonry => const _HeroMasonryDemo(),
    _DemoCategory.stickyHeader => const _StickyHeaderDemo(),
    _DemoCategory.navigationBar => const _NavigationBarDemo(),
    _DemoCategory.contextMenu => const _ContextMenuDemo(),
    _DemoCategory.animatedSwitcher => const _AnimatedSwitcherDemo(),
    _DemoCategory.numberBox => const _NumberBoxDemo(),
    _DemoCategory.steps => const _StepsDemo(),
    _DemoCategory.timeline => const _TimeLineDemo(),
    _DemoCategory.pagination => const _PaginationDemo(),
    _DemoCategory.elevation => const _ElevationDemo(),
    _DemoCategory.animatedText => const _AnimatedTextDemo(),
  };
}

// Lightweight section metadata used only by the sidebar.
class _DemoSection {
  const _DemoSection(this.title);
  final String title;
}
