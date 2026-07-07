import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

enum DSBadgeTone { neutral, brand, success, warning, danger, info }

/// A small status/label pill.
class DSBadge extends StatelessWidget {
  const DSBadge({super.key, required this.label, this.tone = DSBadgeTone.neutral});

  final String label;
  final DSBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;

    final (Color background, Color foreground) = switch (tone) {
      DSBadgeTone.neutral => (colors.surfaceVariant, colors.textSecondary),
      DSBadgeTone.brand => (colors.brand.withValues(alpha: 0.12), colors.brand),
      DSBadgeTone.success => (colors.success.withValues(alpha: 0.14), colors.success),
      DSBadgeTone.warning => (colors.warning.withValues(alpha: 0.16), colors.warning),
      DSBadgeTone.danger => (colors.danger.withValues(alpha: 0.12), colors.danger),
      DSBadgeTone.info => (colors.info.withValues(alpha: 0.12), colors.info),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DSSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(DSRadius.full),
      ),
      child: Text(
        label,
        style: theme.typography.caption.copyWith(
          color: foreground,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
