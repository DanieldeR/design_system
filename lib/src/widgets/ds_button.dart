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
///
/// Two things change under the e-ink theme. **Ghost gains an outline**:
/// on an emissive panel a bare label reads as a button because it
/// picks up a hover and a ripple, and neither exists on paper — an
/// unruled label there is indistinguishable from body text. And
/// **[loading] renders a static glyph rather than a spinner**: an
/// indeterminate spinner never stops asking the panel to repaint, so
/// it holds the refresh pipeline busy for as long as it is mounted,
/// which is exactly when the app is least able to afford it.
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

    // The filled variants grey out by swapping their fill for
    // `border`. That works while `border` is a light grey, but the
    // e-ink scheme's border role is full black — so a disabled button
    // would render as the single loudest element on the page, which is
    // the exact opposite of what "disabled" means. On paper it greys
    // out to the wash fill instead.
    final Color disabledFill = theme.isEInk
        ? colors.surfaceVariant
        : colors.border;

    final (Color background, Color foreground, Color? borderColor) =
        switch (variant) {
          DSButtonVariant.primary => (
            disabled ? disabledFill : colors.brand,
            disabled ? colors.textDisabled : colors.onBrand,
            disabled && theme.isEInk ? colors.textDisabled : null,
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
            theme.isEInk
                ? (disabled ? colors.textDisabled : colors.border)
                : null,
          ),
          DSButtonVariant.danger => (
            disabled ? disabledFill : colors.danger,
            disabled ? colors.textDisabled : colors.onBrand,
            disabled && theme.isEInk ? colors.textDisabled : null,
          ),
        };

    final radius = BorderRadius.circular(theme.shape.md);

    final button = Material(
      color: background,
      borderRadius: radius,
      child: InkWell(
        onTap: disabled ? null : onPressed,
        borderRadius: radius,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _horizontalPadding,
            vertical: _verticalPadding,
          ),
          decoration: borderColor == null
              ? null
              : BoxDecoration(
                  border: Border.all(
                    color: borderColor,
                    width: theme.strokes.regular,
                  ),
                  borderRadius: radius,
                ),
          child: Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (loading) ...[
                if (theme.motion.enabled)
                  SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(foreground),
                    ),
                  )
                else
                  Icon(Icons.hourglass_empty, size: 16, color: foreground),
                const SizedBox(width: DSSpacing.sm),
              ] else if (icon != null) ...[
                Icon(icon, size: 16, color: foreground),
                const SizedBox(width: DSSpacing.sm),
              ],
              // An expanded button is given its width by its parent and
              // must live inside it; a label that cannot fit truncates
              // rather than overflowing the row. A min-sized button keeps
              // its natural width, so the Flexible is a no-op there.
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: _textStyle(
                    theme,
                  ).copyWith(color: foreground, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
