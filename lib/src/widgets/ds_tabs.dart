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
///
/// The emissive themes mark the active tab in copper. On e-ink that
/// copper is the same ink as the strip's own bottom rule, so the
/// indicator would vanish into it. The e-ink theme re-encodes
/// selection as **rule weight plus label weight** — a 3px underline
/// under a bold label, against a 1px strip rule.
///
/// It would be louder still to invert the selected tab, and that was
/// the obvious first answer. It is the wrong one: inverting fills a
/// large region with ink and then has to clear it again on the next
/// tab change, which is both the slowest kind of repaint and the one
/// that leaves the most visible residue. Underline weight moves a few
/// hundred pixels instead of a few thousand and reads just as clearly.
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
        border: Border(
          bottom: BorderSide(
            color: colors.border,
            width: theme.strokes.hairline,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < tabs.length; i++)
            _DSTab(
              item: tabs[i],
              selected: i == selectedIndex,
              onTap: () => onChanged(i),
              theme: theme,
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
    required this.theme,
  });

  final DSTabItem item;
  final bool selected;
  final VoidCallback onTap;
  final DSThemeData theme;

  @override
  Widget build(BuildContext context) {
    final DSColorScheme colors = theme.colors;
    final DSTypography typography = theme.typography;
    final color = selected ? colors.accent : colors.textSecondary;
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minHeight: theme.minTouchTarget),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: DSSpacing.lg,
          vertical: DSSpacing.md,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? colors.accent : Colors.transparent,
              width: selected ? theme.strokes.emphasis : theme.strokes.regular,
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
                fontWeight: selected
                    ? (theme.isEInk ? FontWeight.w700 : FontWeight.w600)
                    : typography.bodyMedium.fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
