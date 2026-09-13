import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

/// A checkbox with an inline label, styled from design tokens.
class DSCheckbox extends StatelessWidget {
  const DSCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;
    final disabled = onChanged == null;

    return InkWell(
      onTap: disabled ? null : () => onChanged!(!value),
      borderRadius: BorderRadius.circular(theme.shape.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DSSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Duration is zero under the e-ink theme, which collapses
            // this to a plain Container's behaviour — the box flips
            // state in the one repaint the panel was going to do
            // anyway, instead of asking for a 120ms run of them.
            AnimatedContainer(
              duration: theme.motion.fast,
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: value
                    ? (disabled ? colors.textDisabled : colors.brand)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(theme.shape.sm),
                border: Border.all(
                  color: value
                      ? Colors.transparent
                      : (disabled ? colors.textDisabled : colors.border),
                  width: theme.strokes.heavy,
                ),
              ),
              child: value
                  ? Icon(Icons.check, size: 16, color: colors.onBrand)
                  : null,
            ),
            if (label != null) ...[
              const SizedBox(width: DSSpacing.sm),
              Text(
                label!,
                style: theme.typography.bodyMedium.copyWith(
                  color: disabled ? colors.textDisabled : colors.textPrimary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
