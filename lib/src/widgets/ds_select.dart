import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

/// One selectable option for [DSSelect].
class DSSelectOption<T> {
  const DSSelectOption({required this.value, required this.label});

  final T value;
  final String label;
}

/// A dropdown select field styled from design tokens.
class DSSelect<T> extends StatelessWidget {
  const DSSelect({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.label,
    this.placeholder,
  });

  final List<DSSelectOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;
    final disabled = onChanged == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: theme.typography.label.copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: DSSpacing.xs),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: DSSpacing.md),
          decoration: BoxDecoration(
            color: disabled ? colors.surfaceVariant : colors.surface,
            borderRadius: BorderRadius.circular(DSRadius.md),
            border: Border.all(color: colors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              hint: placeholder == null
                  ? null
                  : Text(
                      placeholder!,
                      style: theme.typography.bodyMedium.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: disabled ? colors.textDisabled : colors.textSecondary,
              ),
              style: theme.typography.bodyMedium.copyWith(
                color: disabled ? colors.textDisabled : colors.textPrimary,
              ),
              dropdownColor: colors.surface,
              onChanged: disabled ? null : onChanged,
              items: [
                for (final option in options)
                  DropdownMenuItem<T>(
                    value: option.value,
                    child: Text(option.label),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
