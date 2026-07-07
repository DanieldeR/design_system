import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';
import 'ds_button.dart';

/// A centered modal dialog surface styled from design tokens. Use
/// [DSModal.show] to present it; the widget itself is the dialog body.
class DSModal extends StatelessWidget {
  const DSModal({
    super.key,
    required this.title,
    required this.child,
    this.actions = const [],
  });

  final String title;
  final Widget child;
  final List<Widget> actions;

  /// Presents a [DSModal] as a Material dialog and returns the value
  /// passed to `Navigator.pop`, if any.
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget child,
    List<Widget> actions = const [],
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) =>
          DSModal(title: title, actions: actions, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;

    return Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DSRadius.lg),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(DSSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.headingMedium.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: DSSpacing.lg),
              child,
              if (actions.isNotEmpty) ...[
                const SizedBox(height: DSSpacing.xl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    for (var i = 0; i < actions.length; i++) ...[
                      if (i > 0) const SizedBox(width: DSSpacing.sm),
                      actions[i],
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Convenience: a [DSButton]-based dismiss action for [DSModal.actions].
class DSModalAction extends StatelessWidget {
  const DSModalAction({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = DSButtonVariant.primary,
  });

  final String label;
  final VoidCallback onPressed;
  final DSButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    return DSButton(
      label: label,
      onPressed: onPressed,
      variant: variant,
      size: DSButtonSize.small,
    );
  }
}
