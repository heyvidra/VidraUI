import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vidraui/vidraui.dart';

import 'docs/api_inventory.g.dart';
import 'docs/catalog.dart';
import 'docs/docs.dart';
import 'docs/snippets.g.dart';
import 'experimental/experimental_appearances.dart';

part 'src/shell/demo_category.dart';
part 'src/shell/demo_shell.dart';
part 'src/shell/sidebar.dart';
part 'src/shell/demo_content.dart';
part 'src/shell/demo_registry.dart';
part 'src/docs_viewer/docs_page.dart';
part 'src/docs_viewer/code_block.dart';
part 'src/docs_viewer/api_table.dart';
part 'src/demos/page_transitions_demo.dart';
part 'src/demos/buttons_demo.dart';
part 'src/demos/auto_suggest_demo.dart';
part 'src/demos/list_tile_demo.dart';
part 'src/demos/appearance_demo.dart';
part 'src/demos/menu_demo.dart';
part 'src/demos/tabs_demo.dart';
part 'src/demos/bottom_sheet_demo.dart';
part 'src/demos/responsive_demo.dart';
part 'src/demos/overlay_demo.dart';
part 'src/demos/skeleton_demo.dart';
part 'src/demos/media_demo.dart';
part 'src/demos/typography_demo.dart';
part 'src/demos/table_demo.dart';
part 'src/demos/scroll_area_demo.dart';
part 'src/demos/scrollable_list_demo.dart';
part 'src/demos/text_field_demo.dart';
part 'src/demos/slider_demo.dart';
part 'src/demos/theme_demo.dart';
part 'src/demos/toggles_demo.dart';
part 'src/demos/animated_list_demo.dart';
part 'src/demos/select_demo.dart';
part 'src/demos/surface_demo.dart';
part 'src/demos/tooltip_demo.dart';
part 'src/demos/progress_demo.dart';
part 'src/demos/divider_demo.dart';
part 'src/demos/misc_demo.dart';
part 'src/demos/chips_demo.dart';
part 'src/demos/scrollable_grid_demo.dart';
part 'src/demos/carousel_demo.dart';
part 'src/demos/animation_demo.dart';
part 'src/demos/animated_text_demo.dart';
part 'src/demos/swipe_actions_demo.dart';
part 'src/demos/date_picker_demo.dart';
part 'src/demos/selectable_text_demo.dart';
part 'src/demos/form_demo.dart';
part 'src/demos/rich_text_demo.dart';
part 'src/demos/motion_demo.dart';
part 'src/demos/app_bar_demo.dart';
part 'src/demos/core_docs_demo.dart';
part 'src/demos/resizable_demo.dart';
part 'src/demos/empty_state_demo.dart';
part 'src/demos/misc_snippets.dart';
part 'src/demos/segmented_control_demo.dart';
part 'src/demos/accordion_demo.dart';
part 'src/demos/teaching_tip_demo.dart';
part 'src/demos/dynamic_loading_demo.dart';
part 'src/demos/hero_masonry_demo.dart';
part 'src/demos/sticky_header_demo.dart';
part 'src/demos/navigation_bar_demo.dart';
part 'src/demos/context_menu_demo.dart';
part 'src/demos/animated_switcher_demo.dart';
part 'src/demos/number_box_demo.dart';
part 'src/demos/steps_demo.dart';
part 'src/demos/timeline_demo.dart';
part 'src/demos/pagination_demo.dart';
part 'src/demos/elevation_demo.dart';

void main() {
  // Ensure Flutter debug paint overlays are disabled even when DevTools
  // Widget Inspector is active.
  debugPaintSizeEnabled = false;
  runApp(
    VidraApp.navigator(
      title: 'VidraUI Demo',
      theme: VThemeData.light(),
      darkTheme: VThemeData.dark(),
      home: const DemoShell(),
    ),
  );
}

// Demo categories


extension _DemoCategoryDocs on _DemoCategory {
  VDocPageMetadata get docs => vDocCatalog.firstWhere(
        (page) => page.slug == _docSlug,
      );

  String get _docSlug => switch (this) {
        _DemoCategory.chips => 'chips',
        _DemoCategory.buttons => 'buttons',
        _DemoCategory.toggles => 'toggles',
        _DemoCategory.appearance => 'appearance',
        _DemoCategory.overlay => 'overlay',
        _DemoCategory.bottomSheet => 'sheet',
        _DemoCategory.animation => 'motion',
        _DemoCategory.motion => 'motion',
        _DemoCategory.select => 'select',
        _DemoCategory.menu => 'menu',
        _DemoCategory.tabs => 'tabs',
        _DemoCategory.tooltip => 'overlay',
        _DemoCategory.slider => 'slider',
        _DemoCategory.media => 'media',
        _DemoCategory.progress => 'feedback',
        _DemoCategory.divider => 'feedback',
        _DemoCategory.misc => 'feedback',
        _DemoCategory.table => 'table',
        _DemoCategory.form => 'form',
        _DemoCategory.animatedList => 'motion',
        _DemoCategory.scrollableList => 'motion',
        _DemoCategory.scrollableGrid => 'motion',
        _DemoCategory.skeleton => 'feedback',
        _DemoCategory.carousel => 'carousel',
        _DemoCategory.richText => 'typography',
        _DemoCategory.listTile => 'list-tile',
        _DemoCategory.datePicker => 'date-time',
        _DemoCategory.appShell => 'app-shell',
        _DemoCategory.layout => 'layout',
        _DemoCategory.resizable => 'layout',
        _DemoCategory.tokens => 'tokens',
        _DemoCategory.responsive => 'responsive',
        _DemoCategory.swipeActions => 'list-tile',
        _DemoCategory.appBar => 'app-bar',
        _DemoCategory.theme => 'theme',
        _DemoCategory.surface => 'surface',
        _DemoCategory.typography => 'typography',
        _DemoCategory.selectableText => 'typography',
        _DemoCategory.textField => 'text-field',
        _DemoCategory.scrollArea => 'scroll-area',
        _DemoCategory.pageTransitions => 'page-transitions',
        _DemoCategory.emptyState => 'feedback',
        _DemoCategory.segmentedControl => 'segmented-control',
        _DemoCategory.accordion => 'accordion',
        _DemoCategory.autoSuggest => 'auto-suggest',
        _DemoCategory.teachingTip => 'teaching-tip',
        _DemoCategory.dynamicLoading => 'motion',
        _DemoCategory.heroMasonry => 'motion',
        _DemoCategory.stickyHeader => 'sticky-header',
        _DemoCategory.navigationBar => 'navigation-bar',
        _DemoCategory.contextMenu => 'menu',
        _DemoCategory.animatedSwitcher => 'animated-switcher',
        _DemoCategory.numberBox => 'number-box',
        _DemoCategory.steps => 'steps',
        _DemoCategory.timeline => 'timeline',
        _DemoCategory.pagination => 'pagination',
        _DemoCategory.elevation => 'surface',
        _DemoCategory.animatedText => 'motion',
      };
}



