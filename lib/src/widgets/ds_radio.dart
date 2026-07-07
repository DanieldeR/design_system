import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

/// A radio button with an inline label, styled from design tokens.
/// Group multiple [DSRadio]s by giving them the same [groupValue] and
/// distinct [value]s.
class DSRadio<T> extends StatelessWidget {
  const DSRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T>? onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;
    final disabled = onChanged == null;
    final selected = value == groupValue;

    return InkWell(
      onTap: disabled ? null : () => onChanged!(value),
      borderRadius: BorderRadius.circular(DSRadius.full),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DSSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? (disabled ? colors.textDisabled : colors.brand)
                      : (disabled ? colors.textDisabled : colors.border),
                  width: 1.5,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: disabled ? colors.textDisabled : colors.brand,
                        ),
                      ),
                    )
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
