import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

/// A single-line text input following the design system's visual
/// language. Wraps [TextField] but replaces its decoration with
/// design-system tokens.
///
/// Resting, focused and errored are three different colours on an
/// emissive panel and one colour on e-ink, so under the e-ink theme
/// they become three different **weights** — 1.5px resting, 2px
/// focused, 3px errored. Three steps is the most a reader can reliably
/// tell apart on paper, which is also why there is no fourth state.
///
/// A note for callers on e-ink: [placeholder] is grey by definition,
/// and grey is the one thing this theme is trying to avoid inside a
/// field. Put the format in the [label] ("Date — YYYY-MM-DD") rather
/// than ghosting it into the input, and use [helperText] for anything
/// that has to survive the user starting to type.
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
    final radius = BorderRadius.circular(theme.shape.md);

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
              borderRadius: radius,
              borderSide: BorderSide(
                color: colors.border,
                width: theme.strokes.regular,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(
                color: hasError ? colors.danger : colors.border,
                width: hasError
                    ? theme.strokes.emphasis
                    : theme.strokes.regular,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(
                color: hasError ? colors.danger : colors.accent,
                width: hasError
                    ? theme.strokes.emphasis
                    : theme.strokes.heavy,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(
                color: colors.textDisabled,
                width: theme.strokes.regular,
              ),
            ),
          ),
        ),
        if (hasError || helperText != null) ...[
          const SizedBox(height: DSSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // On e-ink the error colour is the same ink as the
              // helper colour, so the message needs a glyph to say
              // which one it is. Elsewhere the red already says it.
              if (hasError && theme.isEInk) ...[
                Icon(Icons.error_outline, size: 16, color: colors.danger),
                const SizedBox(width: DSSpacing.xs),
              ],
              Expanded(
                child: Text(
                  hasError ? errorText! : helperText!,
                  style: theme.typography.bodySmall.copyWith(
                    color: hasError ? colors.danger : colors.textSecondary,
                    fontWeight: hasError && theme.isEInk
                        ? FontWeight.w700
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
