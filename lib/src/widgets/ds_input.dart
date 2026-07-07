import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

/// A single-line text input following the design system's visual
/// language. Wraps [TextField] but replaces its decoration with
/// design-system tokens.
class DSInput extends StatelessWidget {
  const DSInput({
    super.key,
    this.controller,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.onChanged,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
    this.keyboardType,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final String? label;
  final String? placeholder;
  final String? helperText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool obscureText;
  final bool enabled;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;
    final hasError = errorText != null && errorText!.isNotEmpty;

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
        TextField(
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          obscureText: obscureText,
          enabled: enabled,
          keyboardType: keyboardType,
          style: theme.typography.bodyMedium.copyWith(
            color: enabled ? colors.textPrimary : colors.textDisabled,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: theme.typography.bodyMedium.copyWith(
              color: colors.textSecondary,
            ),
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon, size: 18, color: colors.textSecondary),
            filled: true,
            fillColor: enabled ? colors.surface : colors.surfaceVariant,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: DSSpacing.md,
              vertical: DSSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DSRadius.md),
              borderSide: BorderSide(color: colors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DSRadius.md),
              borderSide: BorderSide(
                color: hasError ? colors.danger : colors.border,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DSRadius.md),
              borderSide: BorderSide(
                color: hasError ? colors.danger : colors.accent,
                width: 1.5,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DSRadius.md),
              borderSide: BorderSide(color: colors.border),
            ),
          ),
        ),
        if (hasError || helperText != null) ...[
          const SizedBox(height: DSSpacing.xs),
          Text(
            hasError ? errorText! : helperText!,
            style: theme.typography.bodySmall.copyWith(
              color: hasError ? colors.danger : colors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
