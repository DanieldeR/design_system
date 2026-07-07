import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

enum DSButtonVariant { primary, secondary, outline, ghost, danger }

enum DSButtonSize { small, medium, large }

/// A pressable button following the design system's visual language.
///
/// Use [variant] to pick the emphasis level and [size] to pick the
/// density. Pass [icon] to render a leading icon, and set [onPressed]
/// to `null` to render a disabled button.
class DSButton extends StatelessWidget {
  const DSButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = DSButtonVariant.primary,
    this.size = DSButtonSize.medium,
    this.icon,
    this.loading = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final DSButtonVariant variant;
  final DSButtonSize size;
  final IconData? icon;
  final bool loading;
  final bool expand;

  double get _verticalPadding => switch (size) {
    DSButtonSize.small => DSSpacing.sm,
    DSButtonSize.medium => DSSpacing.md,
    DSButtonSize.large => DSSpacing.lg,
  };

  double get _horizontalPadding => switch (size) {
    DSButtonSize.small => DSSpacing.md,
    DSButtonSize.medium => DSSpacing.lg,
    DSButtonSize.large => DSSpacing.xl,
  };

  TextStyle _textStyle(DSThemeData theme) => switch (size) {
    DSButtonSize.small => theme.typography.bodySmall,
    DSButtonSize.medium => theme.typography.bodyMedium,
    DSButtonSize.large => theme.typography.bodyLarge,
  };

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;
    final disabled = onPressed == null || loading;

    final (Color background, Color foreground, Color? borderColor) =
        switch (variant) {
          DSButtonVariant.primary => (
            disabled ? colors.border : colors.brand,
            disabled ? colors.textDisabled : colors.onBrand,
            null,
          ),
          DSButtonVariant.secondary => (
            disabled ? colors.surfaceVariant : colors.surfaceVariant,
            disabled ? colors.textDisabled : colors.textPrimary,
            colors.border,
          ),
          DSButtonVariant.outline => (
            Colors.transparent,
            disabled ? colors.textDisabled : colors.brand,
            disabled ? colors.border : colors.brand,
          ),
          DSButtonVariant.ghost => (
            Colors.transparent,
            disabled ? colors.textDisabled : colors.textPrimary,
            null,
          ),
          DSButtonVariant.danger => (
            disabled ? colors.border : colors.danger,
            disabled ? colors.textDisabled : colors.onBrand,
            null,
          ),
        };

    final button = Material(
      color: background,
      borderRadius: BorderRadius.circular(DSRadius.md),
      child: InkWell(
        onTap: disabled ? null : onPressed,
        borderRadius: BorderRadius.circular(DSRadius.md),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _horizontalPadding,
            vertical: _verticalPadding,
          ),
          decoration: borderColor == null
              ? null
              : BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(DSRadius.md),
                ),
          child: Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (loading) ...[
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(foreground),
                  ),
                ),
                const SizedBox(width: DSSpacing.sm),
              ] else if (icon != null) ...[
                Icon(icon, size: 16, color: foreground),
                const SizedBox(width: DSSpacing.sm),
              ],
              Text(
                label,
                style: _textStyle(
                  theme,
                ).copyWith(color: foreground, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
