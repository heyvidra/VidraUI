part of '../../main.dart';

class _ContextMenuDemo extends StatefulWidget {
  const _ContextMenuDemo();

  @override
  State<_ContextMenuDemo> createState() => _ContextMenuDemoState();
}

class _ContextMenuDemoState extends State<_ContextMenuDemo> {
  String _lastAction = '无 (请长按下方卡片尝试)';
  VContextMenuStyle _style = VContextMenuStyle.modern;

  void _triggerAction(String actionName) {
    setState(() {
      _lastAction = actionName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    // List of standard actions
    final actionsList = [
      VContextMenuItem(
        label: '复制文档链接',
        icon: const VIcon(LucideIcons.copy),
        onTap: () => _triggerAction('复制文档链接'),
      ),
      VContextMenuItem(
        label: '置顶显示',
        icon: const VIcon(LucideIcons.pin),
        onTap: () => _triggerAction('置顶显示'),
      ),
      VContextMenuItem(
        label: '发送给朋友',
        icon: const VIcon(LucideIcons.share2),
        onTap: () => _triggerAction('发送给朋友'),
      ),
      VContextMenuItem(
        label: '暂不可用操作',
        icon: const VIcon(LucideIcons.lock),
        enabled: false,
        onTap: () => _triggerAction('暂不可用操作'),
      ),
      VContextMenuItem(
        label: '删除文档',
        icon: const VIcon(LucideIcons.trash2),
        isDestructive: true,
        onTap: () => _triggerAction('删除文档'),
      ),
    ];

    return VFlex.vertical(
      gap: theme.spacing.lg,
      children: [
        // Header info
        VSurface(
          variant: VSurfaceVariant.panel,
          child: VFlex.vertical(
            gap: theme.spacing.xs,
            children: [
              VText(
                'VContextMenu 上下文菜单',
                variant: VTextVariant.title,
                color: theme.colors.text,
              ),
              VText(
                '长按（iOS/Android）或右击（macOS/Windows/Web）组件，会展示操作动作菜单。支持我们团队自带的 Modern (极简气泡) 风格，也内置了 SwiftUI 的 iOS 风格。',
                variant: VTextVariant.body,
                color: theme.colors.textMuted,
              ),
            ],
          ),
        ),

        // Style Selector Toggle
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.vertical(
            gap: theme.spacing.xs,
            children: [
              VText(
                '菜单展示风格 (Context Menu Style)',
                variant: VTextVariant.label,
                color: theme.colors.textMuted,
              ),
              VSegmentedControl<VContextMenuStyle>(
                value: _style,
                options: const [
                  VSegmentedControlOption(
                    value: VContextMenuStyle.modern,
                    label: 'Modern (当前风格 - 极简相邻气泡)',
                  ),
                  VSegmentedControlOption(
                    value: VContextMenuStyle.ios,
                    label: 'iOS (SwiftUI 风格 - 缩放抬起加毛玻璃)',
                  ),
                ],
                onChanged: (newStyle) {
                  setState(() {
                    _style = newStyle;
                  });
                },
              ),
            ],
          ),
        ),

        // Console logger
        VSurface(
          variant: VSurfaceVariant.card,
          child: Row(
            children: [
              VText(
                '最后触发的动作: ',
                variant: VTextVariant.label,
                color: theme.colors.textMuted,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: VText(
                  _lastAction,
                  variant: VTextVariant.body,
                  color: _lastAction.contains('删除') 
                      ? theme.colors.danger 
                      : theme.colors.actionPrimary,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),

        // Grid of interactive widgets
        VFlex.vertical(
          gap: theme.spacing.md,
          children: [
            VText(
              '1. 基础卡片长按 (Standard Trigger)',
              variant: VTextVariant.label,
              color: theme.colors.textMuted,
            ),
            Row(
              children: [
                Expanded(
                  child: VContextMenu(
                    style: _style,
                    actions: actionsList,
                    child: VSurface(
                      variant: VSurfaceVariant.card,
                      child: VFlex.vertical(
                        gap: theme.spacing.xs,
                        children: [
                          Row(
                            children: [
                              const VIcon(LucideIcons.fileText, color: Color(0xFF3B82F6)),
                              const SizedBox(width: 8.0),
                              VText(
                                '2026 季度设计规范.pdf',
                                variant: VTextVariant.body,
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          VText(
                            '大小: 12.4 MB • 修改于 2小时前',
                            variant: VTextVariant.caption,
                            color: theme.colors.textMuted,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8.0),
            VText(
              '2. SwiftUI 风格自定义大预览区 (Custom Preview Builder)',
              variant: VTextVariant.label,
              color: theme.colors.textMuted,
            ),
            Row(
              children: [
                Expanded(
                  child: VContextMenu(
                    style: _style,
                    actions: actionsList,
                    previewBuilder: (context) {
                      // Custom larger, more complete preview card popped inside overlay
                      return Container(
                        width: 320.0,
                        padding: EdgeInsets.all(theme.spacing.md),
                        decoration: BoxDecoration(
                          color: theme.colors.surfaceElevated,
                          borderRadius: BorderRadius.circular(theme.radii.lg),
                          border: Border.all(color: theme.colors.border, width: 1.5),
                        ),
                        child: VFlex.vertical(
                          gap: theme.spacing.sm,
                          children: [
                            Row(
                              children: [
                                const VIcon(LucideIcons.image, color: Color(0xFF10B981)),
                                const SizedBox(width: 8.0),
                                VText(
                                  '团队合影_最终版.png',
                                  variant: VTextVariant.body,
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Container(
                              height: 120.0,
                              decoration: BoxDecoration(
                                color: theme.colors.surface,
                                borderRadius: BorderRadius.circular(theme.radii.md),
                              ),
                              child: const Center(
                                child: VIcon(LucideIcons.camera, size: 36.0, color: Color(0x66000000)),
                              ),
                            ),
                            VText(
                              '宽: 3840px • 高: 2160px • 格式: PNG',
                              variant: VTextVariant.caption,
                              color: theme.colors.textMuted,
                            ),
                          ],
                        ),
                      );
                    },
                    child: VSurface(
                      variant: VSurfaceVariant.card,
                      child: Row(
                        children: [
                          const VIcon(LucideIcons.image, color: Color(0xFF10B981)),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: VFlex.vertical(
                              gap: 2.0,
                              children: [
                                VText(
                                  '团队合影_最终版.png',
                                  variant: VTextVariant.body,
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                VText(
                                  _style == VContextMenuStyle.ios
                                      ? '长按可加载大图高精度预览卡片并操作 (iOS 风格专用)'
                                      : '长按或右击打开上下文菜单',
                                  variant: VTextVariant.caption,
                                  color: theme.colors.textMuted,
                                ),
                              ],
                            ),
                          ),
                          const VIcon(LucideIcons.chevronRight, size: 16.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8.0),
            VText(
              '3. 列表中集成上下文菜单 (List Integration)',
              variant: VTextVariant.label,
              color: theme.colors.textMuted,
            ),
            VSurface(
              variant: VSurfaceVariant.panel,
              child: VFlex.vertical(
                gap: 0,
                children: [
                  VContextMenu(
                    style: _style,
                    actions: actionsList,
                    child: Container(
                      padding: EdgeInsets.all(theme.spacing.sm + 4.0),
                      child: Row(
                        children: [
                          const VIcon(LucideIcons.user, color: Color(0xFF8B5CF6)),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: VText('联系人: 阿里 (长按打开上下文菜单)', variant: VTextVariant.body),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VDivider(thickness: 1),
                  VContextMenu(
                    style: _style,
                    actions: actionsList,
                    child: Container(
                      padding: EdgeInsets.all(theme.spacing.sm + 4.0),
                      child: Row(
                        children: [
                          const VIcon(LucideIcons.user, color: Color(0xFF8B5CF6)),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: VText('联系人: 鲍勃 (长按打开上下文菜单)', variant: VTextVariant.body),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
