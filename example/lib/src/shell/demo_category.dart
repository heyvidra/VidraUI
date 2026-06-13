part of '../../main.dart';

enum _DemoCategory {
  chips('Chips'),
  buttons('Buttons'),
  toggles('Toggles'),
  appearance('Appearance'),
  overlay('Overlay'),
  bottomSheet('Sheet'),
  animation('Animation'),
  motion('Motion'),
  select('Select'),
  menu('Menu'),
  tabs('Tabs'),
  tooltip('Tooltip'),
  slider('Slider'),
  media('Media'),
  progress('Progress'),
  divider('Divider'),
  misc('Misc'),
  table('Table'),
  form('Form'),
  animatedList('Animated List'),
  scrollableList('Scrollable List'),
  scrollableGrid('Scrollable Grid'),
  skeleton('Skeleton'),
  carousel('Carousel'),
  richText('Rich Text'),
  listTile('List Tile'),
  datePicker('Date Picker'),
  appShell('App Shell'),
  layout('Layout'),
  resizable('Resizable'),
  tokens('Tokens'),
  responsive('Responsive'),
  swipeActions('Swipe Actions'),
  appBar('App Bar'),
  theme('Theme Override'),
  surface('Surface Variants'),
  typography('Typography'),
  selectableText('Selectable Text'),
  textField('Text Field'),
  scrollArea('Scroll Area'),
  pageTransitions('Page Transitions'),
  emptyState('Empty State'),
  segmentedControl('Segmented Control'),
  accordion('Accordion'),
  autoSuggest('Auto Suggest'),
  teachingTip('Teaching Tip'),
  dynamicLoading('Dynamic Loading'),
  heroMasonry('Hero Masonry'),
  stickyHeader('Sticky Header'),
  navigationBar('Navigation Bar'),
  contextMenu('Context Menu'),
  pagination('Pagination'),
  animatedSwitcher('Animated Switcher'),
  numberBox('Number Box'),
  timeline('TimeLine'),
  steps('Steps'),
  elevation('Elevation'),
  animatedText('Animated Text');

  const _DemoCategory(this.label);
  final String label;
}

class _SidebarSection {
  const _SidebarSection(this.title, this.categories);

  final String title;
  final List<_DemoCategory> categories;
}

