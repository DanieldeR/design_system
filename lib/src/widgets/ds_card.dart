import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';

/// A surface container with the design system's elevation, radius, and
/// border treatment. Named `DSCard` (not `Card`) to avoid colliding
/// with Flutter's Material [Card].
///
/// Under the e-ink theme [elevated] does not cast a shadow — a soft
/// shadow on electrophoretic ink is a band of mid-grey that ghosts,
/// and it reads as smudge rather than depth. The card draws a heavier
/// outline instead: the same "this sits above the page" message, moved
/// from the blur channel to the stroke-weight channel.
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

    final radius = BorderRadius.circular(theme.shape.lg);

    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: radius,
        border: Border.all(
          color: colors.border,
          width: elevated ? theme.strokes.heavy : theme.strokes.regular,
        ),
        boxShadow: elevated && !theme.isEInk
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
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: content,
      ),
    );
  }
}
