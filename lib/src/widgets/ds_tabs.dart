import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_colors.dart';
import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';

/// One tab's label for [DSTabs].
class DSTabItem {
  const DSTabItem({required this.label, this.icon});

  final String label;
  final IconData? icon;
}

/// A horizontal tab strip with an underline indicator, styled from
/// design tokens. Fully controlled: pass [selectedIndex] and react to
/// [onChanged].
class DSTabs extends StatelessWidget {
  const DSTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<DSTabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.border)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < tabs.length; i++)
            _DSTab(
              item: tabs[i],
              selected: i == selectedIndex,
              onTap: () => onChanged(i),
              colors: colors,
              typography: theme.typography,
            ),
        ],
      ),
    );
  }
}

class _DSTab extends StatelessWidget {
  const _DSTab({
    required this.item,
    required this.selected,
    required this.onTap,
    required this.colors,
    required this.typography,
  });

  final DSTabItem item;
  final bool selected;
  final VoidCallback onTap;
  final DSColorScheme colors;
  final DSTypography typography;

  @override
  Widget build(BuildContext context) {
    final color = selected ? colors.accent : colors.textSecondary;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DSSpacing.lg,
          vertical: DSSpacing.md,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? colors.accent : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.icon != null) ...[
              Icon(item.icon, size: 16, color: color),
              const SizedBox(width: DSSpacing.xs),
            ],
            Text(
              item.label,
              style: typography.bodyMedium.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
