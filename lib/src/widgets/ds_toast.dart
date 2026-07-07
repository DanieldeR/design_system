import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

enum DSToastTone { neutral, success, warning, danger }

/// A transient status message, shown via [DSToast.show] using the
/// ambient [ScaffoldMessenger].
abstract final class DSToast {
  static void show(
    BuildContext context, {
    required String message,
    DSToastTone tone = DSToastTone.neutral,
    Duration duration = const Duration(seconds: 3),
  }) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;

    final (Color background, Color foreground) = switch (tone) {
      DSToastTone.neutral => (colors.textPrimary, colors.surface),
      DSToastTone.success => (colors.success, colors.onBrand),
      DSToastTone.warning => (colors.warning, colors.onBrand),
      DSToastTone.danger => (colors.danger, colors.onBrand),
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: theme.typography.bodyMedium.copyWith(color: foreground),
        ),
        backgroundColor: background,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DSRadius.md),
        ),
        margin: const EdgeInsets.all(DSSpacing.lg),
      ),
    );
  }
}
