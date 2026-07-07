import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

/// A hover/long-press tooltip styled from design tokens. Named
/// `DSTooltip` (not `Tooltip`) to avoid colliding with Flutter's
/// built-in [Tooltip].
class DSTooltip extends StatelessWidget {
  const DSTooltip({super.key, required this.message, required this.child});

  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;

    return Tooltip(
      message: message,
      textStyle: theme.typography.bodySmall.copyWith(color: colors.surface),
      decoration: BoxDecoration(
        color: colors.textPrimary,
        borderRadius: BorderRadius.circular(DSRadius.sm),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DSSpacing.sm,
        vertical: DSSpacing.xs,
      ),
      child: child,
    );
  }
}
