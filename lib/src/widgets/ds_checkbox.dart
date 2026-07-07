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
      borderRadius: BorderRadius.circular(DSRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DSSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: value
                    ? (disabled ? colors.textDisabled : colors.brand)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(DSRadius.sm),
                border: Border.all(
                  color: value
                      ? Colors.transparent
                      : (disabled ? colors.textDisabled : colors.border),
                  width: 1.5,
                ),
              ),
              child: value
                  ? Icon(Icons.check, size: 14, color: colors.onBrand)
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
