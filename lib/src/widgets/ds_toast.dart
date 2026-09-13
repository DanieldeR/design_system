import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

enum DSToastTone { neutral, success, warning, danger }

/// A transient status message, shown via [DSToast.show] using the
/// ambient [ScaffoldMessenger].
///
/// A toast is a poor fit for e-ink and the e-ink theme makes it a less
/// bad one rather than pretending otherwise. It costs two unprompted
/// repaints — one to appear, one to vanish — at moments the user did
/// not ask for, and the second one can easily land while they are
/// reading something else. Under the e-ink theme it therefore docks to
/// the bottom edge instead of floating (no shadow, no inset, a smaller
/// dirty rectangle) and stays up for eight seconds instead of three,
/// since a message that takes ~400ms to become readable and then
/// leaves after three is barely a message at all.
///
/// All four tones render identically on e-ink — inverted ink. Put the
/// severity in the [message].
///
/// For anything the user must not miss, prefer a [DSModal] or inline
/// text on the surface that caused it. Nothing that matters should
/// depend on the reader happening to look during the window.
abstract final class DSToast {
  /// Sentinel for "caller did not pick a duration", so the e-ink theme
  /// can lengthen the default without overriding an explicit choice.
  static const Duration _defaultDuration = Duration(seconds: 3);

  static void show(
    BuildContext context, {
    required String message,
    DSToastTone tone = DSToastTone.neutral,
    Duration duration = _defaultDuration,
  }) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;

    final (Color background, Color foreground) = switch (tone) {
      DSToastTone.neutral => (colors.textPrimary, colors.surface),
      DSToastTone.success => (colors.success, colors.onBrand),
      DSToastTone.warning => (colors.warning, colors.onBrand),
      DSToastTone.danger => (colors.danger, colors.onBrand),
    };

    final eInk = theme.isEInk;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: theme.typography.bodyMedium.copyWith(color: foreground),
        ),
        backgroundColor: background,
        duration: eInk && duration == _defaultDuration
            ? const Duration(seconds: 8)
            : duration,
        elevation: eInk ? 0 : null,
        behavior: eInk ? SnackBarBehavior.fixed : SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.shape.md),
        ),
        margin: eInk ? null : const EdgeInsets.all(DSSpacing.lg),
      ),
    );
  }
}
