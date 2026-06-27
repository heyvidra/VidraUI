import 'docs.dart';

const vDocSnippets = <String, VDocCodeSnippet>{
  'accordion-collapsible': VDocCodeSnippet(
    id: 'accordion-collapsible',
    source: r'''
VCollapsible(
  header: const VText('Section title'),
  child: VFlex.vertical(
    gap: 8,
    children: const [
      VText('Expanded body content'),
      VText('Can hold any widget tree.'),
    ],
  ),
)
''',
  ),
  'accordion-exclusive': VDocCodeSnippet(
    id: 'accordion-exclusive',
    source: r'''
VAccordion(
  multiple: false,
  items: [
    VAccordionItem(
      header: const VText('Device Configuration'),
      child: const VText('Input: Built-in Microphone'),
    ),
    VAccordionItem(
      header: const VText('ASR Engine'),
      child: const VText('Model: Local Balanced'),
    ),
  ],
)
''',
  ),
  'accordion-multi': VDocCodeSnippet(
    id: 'accordion-multi',
    source: r'''
VAccordion(
  multiple: true,
  items: [
    VAccordionItem(
      header: const VText('Recent Logs'),
      initiallyExpanded: true,
      child: const VText('No entries yet'),
    ),
    VAccordionItem(
      header: const VText('Quality Metrics'),
      child: const VText('Echo delay: 12ms'),
    ),
  ],
)
''',
  ),
  'app-bar-basic': VDocCodeSnippet(
    id: 'app-bar-basic',
    source: r'''
VAppBar(
  leading: VIcon(LucideIcons.chevronLeft, semanticLabel: 'Back'),
  title: const VText('Title'),
  actions: [VIcon(LucideIcons.settings, semanticLabel: 'Settings')],
)
''',
  ),
  'app-shell-basic': VDocCodeSnippet(
    id: 'app-shell-basic',
    source: r'''
void main() {
  runApp(
    VidraApp.navigator(
      title: 'My App',
      theme: VThemeData.light(),
      darkTheme: VThemeData.dark(),
      home: const MyHomePage(),
    ),
  );
}
''',
  ),
  'appearance-basic': VDocCodeSnippet(
    id: 'appearance-basic',
    source: r'''
VAppearanceScope(
  appearance: const VSoftAppearance(),
  child: VButton(
    onPressed: save,
    child: const VText('Save', variant: VTextVariant.label),
  ),
)
''',
  ),
  'auto-suggest-basic': VDocCodeSnippet(
    id: 'auto-suggest-basic',
    source: r'''
VAutoSuggestBox(
  label: 'Country',
  hint: 'Start typing...',
  suggestionsBuilder: (query) => countries
      .where((c) => c.toLowerCase().contains(query.toLowerCase()))
      .map((c) => VAutoSuggestItem(value: c, label: c))
      .toList(),
  onSelected: (item) => print('Selected: ${item.label}'),
)
''',
  ),
  'button-icon-loading': VDocCodeSnippet(
    id: 'button-icon-loading',
    source: r'''
VFlex.horizontal(
  gap: 8,
  children: [
    VButton(
      leadingIcon: VIcon(LucideIcons.save),
      loading: saving,
      loadingSemanticLabel: 'Saving changes',
      onPressed: saving ? null : save,
      child: const VText('Save', variant: VTextVariant.label),
    ),
    VButton(
      shape: VButtonShape.circle,
      semanticLabel: 'Search',
      onPressed: search,
      child: VIcon(LucideIcons.search),
    ),
  ],
)
''',
  ),
  'button-variants': VDocCodeSnippet(
    id: 'button-variants',
    source: r'''
VFlex.horizontal(
  gap: 8,
  children: const [
    VButton(onPressed: save, child: VText('Primary')),
    VButton(
      onPressed: cancel,
      variant: VButtonVariant.secondary,
      child: VText('Secondary'),
    ),
    VButton(
      onPressed: delete,
      variant: VButtonVariant.danger,
      child: VText('Danger'),
    ),
  ],
)
''',
  ),
  'carousel-basic': VDocCodeSnippet(
    id: 'carousel-basic',
    source: r'''
VCarousel(
  height: 160,
  children: [
    VSurface(child: const Center(child: VText('Slide 1'))),
    VSurface(child: const Center(child: VText('Slide 2'))),
  ],
)
''',
  ),
  'chip-variants': VDocCodeSnippet(
    id: 'chip-variants',
    source: r'''
Wrap(
  spacing: 8,
  children: const [
    VChip(label: Text('Soft')),
    VChip(label: Text('Filled'), variant: VChipVariant.filled),
    VChip(label: Text('Selected'), selected: true),
  ],
)
''',
  ),
  'date-picker-basic': VDocCodeSnippet(
    id: 'date-picker-basic',
    source: r'''
VDatePicker(
  selected: selectedDate,
  onChanged: (date) => setState(() => selectedDate = date),
)
''',
  ),
  'date-picker-range': VDocCodeSnippet(
    id: 'date-picker-range',
    source: r'''
VDatePicker(
  selected: selectedDate,
  firstDate: DateTime(2026, 1, 1),
  lastDate: DateTime(2026, 12, 31),
  onChanged: (date) => setState(() => selectedDate = date),
)
''',
  ),
  'dialog-basic': VDocCodeSnippet(
    id: 'dialog-basic',
    source: r'''
final confirmed = await VDialog.show<bool>(
  context,
  builder: (ctx) => VDialogSurface(
    child: VFlex.vertical(
crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('Delete item?', variant: VTextVariant.title),
        const VText('This action cannot be undone.'),
        VButton(
          onPressed: () => VDialogScope.of<bool>(ctx)(true),
          variant: VButtonVariant.danger,
          child: const VText('Delete', variant: VTextVariant.label),
        ),
      ],
    ),
  ),
);
''',
  ),
  'feedback-basic': VDocCodeSnippet(
    id: 'feedback-basic',
    source: r'''
VFlex.vertical(
crossAxisAlignment: CrossAxisAlignment.stretch,
  gap: 12,
  children: const [
    VProgressBar(value: 0.7),
    VProgressBar(value: null),
    VSpinner(),
  ],
)
''',
  ),
  'form-basic': VDocCodeSnippet(
    id: 'form-basic',
    source: r'''
VForm(
  key: formKey,
  children: const [
    VFormField(
      errors: [VFormFieldError('This field is required')],
      child: VTextField(label: 'Email', hint: 'you@example.com'),
    ),
  ],
)
''',
  ),
  'form-submit': VDocCodeSnippet(
    id: 'form-submit',
    source: r'''
final formKey = GlobalKey<VFormState>();

VButton(
  onPressed: () {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid) submit();
  },
  child: const VText('Submit', variant: VTextVariant.label),
)
''',
  ),
  'layout-basic': VDocCodeSnippet(
    id: 'layout-basic',
    source: r'''
VScaffold(
  header: const VAppBar(title: VText('Settings')),
  body: VFlex.vertical(
crossAxisAlignment: CrossAxisAlignment.stretch,
    padding: const EdgeInsets.all(16),
    gap: 12,
    children: const [VText('Content')],
  ),
)
''',
  ),
  'list-tile-basic': VDocCodeSnippet(
    id: 'list-tile-basic',
    source: r'''
VListTile(
  leading: const VAvatar(name: 'AC'),
  title: 'Alice Chen',
  subtitle: 'alice@example.com',
  trailing: const VText('Admin', variant: VTextVariant.caption),
)
''',
  ),
  'media-basic': VDocCodeSnippet(
    id: 'media-basic',
    source: r'''
VImage.network(
  'https://picsum.photos/400/200',
  width: 200,
  height: 120,
  radius: 8,
  placeholder: const Center(child: VSpinner()),
)
''',
  ),
  'menu-action-basic': VDocCodeSnippet(
    id: 'menu-action-basic',
    source: r'''
VMenuAnchor<String>(
  items: [
    VMenuItem(label: 'Duplicate', value: 'duplicate', onPressed: duplicate),
    const VMenuItem.separator(),
    VMenuItem(
      label: 'Delete',
      value: 'delete',
      role: VMenuItemRole.destructive,
      onPressed: delete,
    ),
  ],
  builder: (context, controller, isOpen) {
    return VButton(
      onPressed: controller.toggle,
      child: VText(isOpen ? 'Close' : 'Actions'),
    );
  },
)
''',
  ),
  'menu-selection-basic': VDocCodeSnippet(
    id: 'menu-selection-basic',
    source: r'''
VMenuAnchor<String>(
  selectionMode: VMenuSelectionMode.multiple,
  selectedValues: selectedColumns,
  onSelectionChanged: (values) => setState(() => selectedColumns = values),
  items: const [
    VMenuItem(value: 'name', label: 'Name'),
    VMenuItem(value: 'status', label: 'Status'),
  ],
  builder: (context, controller, isOpen) {
    return VButton(
      onPressed: controller.toggle,
      child: VText('${selectedColumns.length} columns'),
    );
  },
)
''',
  ),
  'motion-basic': VDocCodeSnippet(
    id: 'motion-basic',
    source: r'''
VMotionScope(
  motion: VTheme.of(context).motion.copyWith(reducedMotion: true),
  child: VAnimatedScaleFade(
    visible: visible,
    child: const VSurface(child: VText('Motion-aware content')),
  ),
)
''',
  ),
  'navigation-bar-basic': VDocCodeSnippet(
    id: 'navigation-bar-basic',
    source: r'''
VNavigationBar(
  shape: VNavigationBarShape.floating,
  indicator: VNavigationBarIndicator.pill,
  contentMode: VNavigationBarContentMode.labeled,
  destinations: [
    VNavigationDestination(
      icon: Icon(LucideIcons.home),
      label: 'Home',
    ),
    VNavigationDestination(
      icon: Icon(LucideIcons.search),
      label: 'Search',
      badge: VBadge(count: 3, child: SizedBox.shrink()),
    ),
  ],
  selectedIndex: _currentIndex,
  onChanged: (i) => setState(() => _currentIndex = i),
)
''',
  ),
  'navigation-bar-center-fab': VDocCodeSnippet(
    id: 'navigation-bar-center-fab',
    source: r'''
VNavigationBar(
  shape: VNavigationBarShape.floating,
  destinations: [...],
  selectedIndex: 0,
  onChanged: (_) {},
  centerDestination: VNavigationDestination(
    icon: Icon(LucideIcons.plus),
    label: 'Create',
  ),
)
''',
  ),
  'overlay-basic': VDocCodeSnippet(
    id: 'overlay-basic',
    source: r'''
VToast.show(
  context,
  message: 'Item saved successfully',
  variant: VToastVariant.success,
)
''',
  ),
  'page-transitions-basic': VDocCodeSnippet(
    id: 'page-transitions-basic',
    source: r'''
VidraApp.navigator(
  title: 'Example',
  theme: VThemeData.light().copyWith(
    motion: VThemeData.light().motion.copyWith(
      pageTransition: VPageTransition.iosDepthSlide,
    ),
  ),
  home: const HomePage(),
);

// Push a page with the app-wide transition:
Navigator.of(context).push(
  VPageRoute<void>(
    motion: VTheme.of(context).motion,
    builder: (_) => const DetailPage(),
  ),
);

// Override the transition for one route:
VMotionScope(
  motion: VTheme.of(context).motion.copyWith(
    pageTransition: VPageTransition.sharedAxisX,
  ),
  child: Builder(
    builder: (ctx) => VButton(
      onPressed: () => Navigator.of(ctx).push(
        VPageRoute<void>(
          motion: VMotionResolver.of(ctx),
          builder: (_) => const DetailPage(),
        ),
      ),
      child: const VText('Go', variant: VTextVariant.label),
    ),
  ),
)
''',
  ),
  'responsive-basic': VDocCodeSnippet(
    id: 'responsive-basic',
    source: r'''
final columns = VResponsive.value<int>(
  context,
  xs: 1,
  sm: 2,
  md: 3,
  lg: 4,
);
''',
  ),
  'scaffold-background-gradient': VDocCodeSnippet(
    id: 'scaffold-background-gradient',
    source: r'''
VScaffold(
  background: VBackground.gradient(
    LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [theme.colors.background, theme.colors.surfaceElevated],
    ),
  ),
  body: const VText('Page content'),
)
''',
  ),
  'scroll-area-basic': VDocCodeSnippet(
    id: 'scroll-area-basic',
    source: r'''
VScrollArea(
  showScrollbar: true,
  child: Column(
    children: [
      Text('Item 1'),
      Text('Item 2'),
      Text('Item 3'),
    ],
  ),
)
''',
  ),
  'scrollable-list-basic': VDocCodeSnippet(
    id: 'scrollable-list-basic',
    source: r'''
VScrollableList.builder(
  itemCount: items.length,
  onRefresh: refreshItems,
  onLoadMore: loadMoreItems,
  hasMore: hasMoreItems,
  showScrollToTopAfter: 240,
  itemBuilder: (context, index) => VListTile(title: items[index].title),
)
''',
  ),
  'segmented-control-basic': VDocCodeSnippet(
    id: 'segmented-control-basic',
    source: r'''
VSegmentedControl<String>(
  value: selected,
  options: const [
    VSegmentedControlOption(value: 'day', label: 'Day'),
    VSegmentedControlOption(value: 'week', label: 'Week'),
    VSegmentedControlOption(value: 'month', label: 'Month'),
  ],
  onChanged: (v) => setState(() => selected = v),
)
''',
  ),
  'segmented-control-sizes': VDocCodeSnippet(
    id: 'segmented-control-sizes',
    source: r'''
VFlex.vertical(
  gap: 12,
  children: [
    VSegmentedControl<String>(
      value: selected,
      size: VControlSize.sm,
      options: const [
        VSegmentedControlOption(value: 'a', label: 'Small'),
        VSegmentedControlOption(value: 'b', label: 'Controls'),
      ],
      onChanged: (v) => setState(() => selected = v),
    ),
    VSegmentedControl<String>(
      value: selected,
      size: VControlSize.lg,
      options: const [
        VSegmentedControlOption(value: 'a', label: 'Large'),
        VSegmentedControlOption(value: 'b', label: 'Controls'),
        VSegmentedControlOption(value: 'c', label: 'Disabled', enabled: false),
      ],
      onChanged: (v) => setState(() => selected = v),
    ),
  ],
)
''',
  ),
  'select-basic': VDocCodeSnippet(
    id: 'select-basic',
    source: r'''
VSelect<String>(
  label: 'Choose an option',
  options: const [
    VSelectOption(value: 'a', label: 'Option A'),
    VSelectOption(value: 'b', label: 'Option B'),
  ],
  value: selected,
  onChanged: (value) => setState(() => selected = value),
)
''',
  ),
  'selectable-text-basic': VDocCodeSnippet(
    id: 'selectable-text-basic',
    source: r'''
const VSelectableText(
  'This text can be selected.',
  variant: VTextVariant.body,
)
''',
  ),
  'sheet-basic': VDocCodeSnippet(
    id: 'sheet-basic',
    source: r'''
VSheet.show<void>(
  context,
  edge: VSheetEdge.bottom,
  size: VSheetSize.auto,
  builder: (ctx) => VSheetSurface(
    child: VButton(
      onPressed: () => VSheetScope.of<void>(ctx)(null),
      child: const VText('Close', variant: VTextVariant.label),
    ),
  ),
)
''',
  ),
  'slider-basic': VDocCodeSnippet(
    id: 'slider-basic',
    source: r'''
VSlider(
  value: value,
  onChanged: (next) => setState(() => value = next),
)
''',
  ),
  'state-property-basic': VDocCodeSnippet(
    id: 'state-property-basic',
    source: r'''
final background = VStateProperty<Color>.resolveWith(
  normal: theme.colors.surface,
  hovered: theme.colors.surfaceHover,
  pressed: theme.colors.surfacePressed,
  disabled: theme.colors.surfaceDisabled,
);
''',
  ),
  'sticky-header-basic': VDocCodeSnippet(
    id: 'sticky-header-basic',
    source: r'''
VStickyHeader(
  height: 48.0,
  pinned: true,
  builder: (context, shrinkOffset, overlapsContent) => VSurface(
    variant: VSurfaceVariant.panel,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: VText('Section Title'),
      ),
    ),
  ),
)
''',
  ),
  'surface-background-color': VDocCodeSnippet(
    id: 'surface-background-color',
    source: r'''
VSurface(
  background: VBackground.color(theme.colors.surfaceElevated),
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: VText('Local color override'),
  ),
)
''',
  ),
  'surface-background-gradient': VDocCodeSnippet(
    id: 'surface-background-gradient',
    source: r'''
VSurface(
  background: VBackground.gradient(
    LinearGradient(
      colors: [theme.colors.actionPrimary, theme.colors.surfaceElevated],
    ),
  ),
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: VText('Local gradient override'),
  ),
)
''',
  ),
  'surface-variants': VDocCodeSnippet(
    id: 'surface-variants',
    source: r'''
VSurface(
  variant: VSurfaceVariant.card,
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: VText('Card content'),
  ),
)
''',
  ),
  'surface-elevation': VDocCodeSnippet(
    id: 'surface-elevation',
    source: r'''
VSurface(
  elevation: VElevation.level2,
  padding: const EdgeInsets.all(16),
  child: const VText('Elevated content'),
)
''',
  ),
  'table-basic': VDocCodeSnippet(
    id: 'table-basic',
    source: r'''
VTable(
  sortColumnIndex: 0,
  columns: const [
    VTableColumn(header: 'Name', width: 130),
    VTableColumn(header: 'Role', width: 100),
  ],
  rows: const [
    ['Alice Chen', 'Admin'],
    ['Bob Smith', 'Editor'],
  ],
)
''',
  ),
  'table-tokens': VDocCodeSnippet(
    id: 'table-tokens',
    source: r'''
final theme = VTheme.of(context);

VTheme(
  data: theme.copyWith(
    components: theme.components.copyWith(
      table: theme.components.table.copyWith(
        headerBackground: theme.colors.surfaceHover,
        headerForeground: theme.colors.text,
        sortIndicatorColor: theme.colors.actionPrimary,
        rowBackground: theme.colors.surface,
        alternateRowBackground: theme.colors.surfaceSubtle,
      ),
    ),
  ),
  child: const VTable(
    sortColumnIndex: 0,
    columns: [VTableColumn(header: 'Name'), VTableColumn(header: 'Role')],
    rows: [['Alice', 'Admin'], ['Bob', 'Editor']],
  ),
)
''',
  ),
  'tabs-basic': VDocCodeSnippet(
    id: 'tabs-basic',
    source: r'''
VTabs(
  tabs: const ['Overview', 'Details'],
  children: const [
    VText('Overview content'),
    VText('Details content'),
  ],
)
''',
  ),
  'teaching-tip-basic': VDocCodeSnippet(
    id: 'teaching-tip-basic',
    source: r'''
VTeachingTip(
  controller: controller,
  title: 'New Workspace Layout',
  subtitle: 'Create folders, sort projects, and configure templates dynamically.',
  placement: VAnchoredOverlayPlacement.up,
  primaryButton: VButton(
    onPressed: controller.close,
    child: const VText('Got it'),
  ),
  child: VButton(
    onPressed: controller.toggle,
    child: const VText('Toggle Basic Tip'),
  ),
)
''',
  ),
  'text-field-basic': VDocCodeSnippet(
    id: 'text-field-basic',
    source: r'''
const VTextField(
  label: 'Email',
  hint: 'you@example.com',
  keyboardType: TextInputType.emailAddress,
  errorText: 'Invalid email address',
)
''',
  ),
  'text-field-owned-state': VDocCodeSnippet(
    id: 'text-field-owned-state',
    source: r'''
final controller = TextEditingController();
final focusNode = FocusNode();

VTextField(
  controller: controller,
  focusNode: focusNode,
  label: 'Search',
  hint: 'Type to filter results',
  leading: VIcon(LucideIcons.search, size: 18),
  onSubmitted: runSearch,
)
''',
  ),
  'theme-basic': VDocCodeSnippet(
    id: 'theme-basic',
    source: r'''
VTheme.override(
  colors: (colors) => colors.copyWith(
    actionPrimary: colors.success,
    actionPrimaryHover: colors.successHover,
    actionPrimaryPressed: colors.successHover,
  ),
  child: child,
)
''',
  ),
  'theme-component-override': VDocCodeSnippet(
    id: 'theme-component-override',
    source: r'''
VButtonTheme.override(
  data: (theme, button) => button.copyWith(
    primaryBackground: VStateProperty.states(
      normal: theme.colors.success,
      hovered: theme.colors.successHover,
    ),
  ),
  child: const VButton(
    onPressed: save,
    child: VText('Save', variant: VTextVariant.label),
  ),
)
''',
  ),
  'theme-token-override': VDocCodeSnippet(
    id: 'theme-token-override',
    source: r'''
VTokenTheme<VButtonTokens>.override(
  data: (theme, button) => button.copyWith(
    focusRing: theme.colors.success,
  ),
  fallback: (theme) => theme.components.button,
  child: child,
)
''',
  ),
  'time-picker-basic': VDocCodeSnippet(
    id: 'time-picker-basic',
    source: r'''
VTimePicker(
  selected: selectedTime,
  onChanged: (time) => setState(() => selectedTime = time),
)
''',
  ),
  'toggle-controls': VDocCodeSnippet(
    id: 'toggle-controls',
    source: r'''
VCheckbox(
  checked: accepted,
  label: 'Accept terms',
  onChanged: (value) => setState(() => accepted = value),
)
''',
  ),
  'tokens-basic': VDocCodeSnippet(
    id: 'tokens-basic',
    source: r'''
final theme = VTheme.of(context);
return VSurface(
  child: Padding(
    padding: EdgeInsets.all(theme.spacing.md),
    child: VText('Tokenized spacing and typography'),
  ),
);
''',
  ),
  'typography-basic': VDocCodeSnippet(
    id: 'typography-basic',
    source: r'''
VFlex.vertical(
crossAxisAlignment: CrossAxisAlignment.stretch,
  gap: 8,
  children: const [
    VText('Heading', variant: VTextVariant.heading),
    VText('Body copy', variant: VTextVariant.body),
    VText('Caption', variant: VTextVariant.caption),
  ],
)
''',
  ),
};
