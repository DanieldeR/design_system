import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

/// A hover/long-press tooltip styled from design tokens. Named
/// `DSTooltip` (not `Tooltip`) to avoid colliding with Flutter's
/// built-in [Tooltip].
///
/// Under the e-ink theme the fade is dropped (it would be a run of
/// partial refreshes rather than a fade) and the tooltip stays up for
/// four seconds instead of one and a half, because the panel spends a
/// good fraction of a second just becoming readable.
///
/// Treat tooltips as desktop-only affordances regardless. On a
/// touch-only reader the only way to reach one is a long press, which
/// is the same gesture most of this system uses for a primary action —
/// so a tooltip is either unreachable or in the way. Anything the user
/// genuinely needs belongs in a visible label.
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
      waitDuration: theme.motion.enabled ? null : Duration.zero,
      showDuration: theme.motion.enabled
          ? null
          : const Duration(seconds: 4),
      textStyle: theme.typography.bodySmall.copyWith(color: colors.surface),
      decoration: BoxDecoration(
        color: colors.textPrimary,
        borderRadius: BorderRadius.circular(theme.shape.sm),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DSSpacing.sm,
        vertical: DSSpacing.xs,
      ),
      child: child,
    );
  }
}
