import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

enum DSBadgeTone { neutral, brand, success, warning, danger, info }

/// A small status/label pill.
///
/// **On e-ink the six tones collapse to three salience levels.** Six
/// tinted fills all quantise to the same grey on a monochrome panel,
/// so rather than render six pills that look identical, the e-ink
/// theme drops the pretence and maps tone to *how loudly the badge
/// should read*, not to *what it means*:
///
/// | tone | e-ink treatment | reads as |
/// |---|---|---|
/// | `danger`, `warning` | inverted — ink fill, paper text | "act on this" |
/// | `brand`, `success`, `info` | paper fill, ruled outline | "this is a status" |
/// | `neutral` | wash fill, no rule | "this is metadata" |
///
/// The consequence for callers is direct: **the meaning has to be in
/// the [label]**. `DSBadge(label: 'Active', tone: success)` still works
/// because the word carries it; `DSBadge(label: '3', tone: danger)`
/// does not, because on paper it is just an inverted 3.
class DSBadge extends StatelessWidget {
  const DSBadge({super.key, required this.label, this.tone = DSBadgeTone.neutral});

  final String label;
  final DSBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;

    final (Color background, Color foreground, Color? rule) = theme.isEInk
        ? switch (tone) {
            // Loud: inverted. A small inverted pill is a cheap repaint
            // and the strongest signal a monochrome panel has.
            DSBadgeTone.danger ||
            DSBadgeTone.warning => (colors.brand, colors.onBrand, null),
            // Ordinary: ruled outline on paper.
            DSBadgeTone.brand ||
            DSBadgeTone.success ||
            DSBadgeTone.info => (colors.surface, colors.textPrimary, colors.border),
            // Quiet: wash, no rule.
            DSBadgeTone.neutral => (
              colors.surfaceVariant,
              colors.textPrimary,
              null,
            ),
          }
        : switch (tone) {
            DSBadgeTone.neutral => (
              colors.surfaceVariant,
              colors.textSecondary,
              null,
            ),
            DSBadgeTone.brand => (
              colors.brand.withValues(alpha: 0.12),
              colors.brand,
              null,
            ),
            DSBadgeTone.success => (
              colors.success.withValues(alpha: 0.14),
              colors.success,
              null,
            ),
            DSBadgeTone.warning => (
              colors.warning.withValues(alpha: 0.16),
              colors.warning,
              null,
            ),
            DSBadgeTone.danger => (
              colors.danger.withValues(alpha: 0.12),
              colors.danger,
              null,
            ),
            DSBadgeTone.info => (
              colors.info.withValues(alpha: 0.12),
              colors.info,
              null,
            ),
          };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DSSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(theme.shape.full),
        border: rule == null
            ? null
            : Border.all(color: rule, width: theme.strokes.regular),
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
