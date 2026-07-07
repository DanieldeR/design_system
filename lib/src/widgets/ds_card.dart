import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

/// A surface container with the design system's elevation, radius, and
/// border treatment. Named `DSCard` (not `Card`) to avoid colliding
/// with Flutter's Material [Card].
class DSCard extends StatelessWidget {
  const DSCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(DSSpacing.lg),
    this.onTap,
    this.elevated = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;

    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(DSRadius.lg),
        border: Border.all(color: colors.border),
        boxShadow: elevated
            ? [
                BoxShadow(
                  color: colors.overlay.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: child,
    );

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(DSRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DSRadius.lg),
        child: content,
      ),
    );
  }
}
