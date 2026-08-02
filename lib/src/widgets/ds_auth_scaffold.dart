import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import '../tokens/ds_spacing.dart';
import 'ds_card.dart';

/// The canonical sign-in layout: a centered, elevated card on the app
/// background holding a brand mark, a title, an optional subtitle, an
/// optional error banner, and the auth controls themselves.
///
/// Every app renders its login screen through this widget so the palette,
/// spacing, and — importantly — the placement and color of the error
/// banner are identical everywhere. Authentication logic stays in the app;
/// this widget owns presentation only.
class DSAuthScaffold extends StatelessWidget {
  const DSAuthScaffold({
    super.key,
    required this.title,
    required this.children,
    this.icon,
    this.mark,
    this.subtitle,
    this.errorMessage,
    this.maxWidth = 400,
  }) : assert(
         icon == null || mark == null,
         'Pass either icon or mark, not both.',
       );

  /// Headline of the card, e.g. `'Welcome back'`.
  final String title;

  /// Supporting line under [title]. Omit for a bare headline.
  final String? subtitle;

  /// Icon rendered inside the brand mark badge above [title].
  final IconData? icon;

  /// A custom brand mark (an app logo, say) shown in place of [icon],
  /// laid out in the same [markSize] square.
  final Widget? mark;

  /// When non-null, an error banner is rendered between the header and
  /// [children]. Its placement and colors are fixed by the design system
  /// so warnings never move around between apps.
  final String? errorMessage;

  /// The auth controls — sign-in buttons, form fields, links.
  final List<Widget> children;

  /// Width the card is capped at on wide viewports.
  final double maxWidth;

  /// Edge length of the square brand mark above the title.
  static const double markSize = 64;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;
    final typography = theme.typography;

    final Widget? brandMark = mark != null
        ? SizedBox.square(
            dimension: markSize,
            child: Center(child: mark),
          )
        : icon != null
        ? Container(
            width: markSize,
            height: markSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.brand.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(DSRadius.lg),
            ),
            child: Icon(icon, size: 32, color: colors.brand),
          )
        : null;

    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: DSSpacing.xxl,
            horizontal: DSSpacing.lg,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: DSCard(
              elevated: true,
              padding: const EdgeInsets.all(DSSpacing.xxl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (brandMark != null) ...[
                    Center(child: brandMark),
                    const SizedBox(height: DSSpacing.lg),
                  ],
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: typography.headingLarge.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: DSSpacing.sm),
                    Text(
                      subtitle!,
                      textAlign: TextAlign.center,
                      style: typography.bodyMedium.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: DSSpacing.xxl),
                  if (errorMessage != null) ...[
                    DSAuthErrorBanner(message: errorMessage!),
                    const SizedBox(height: DSSpacing.lg),
                  ],
                  ...children,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The inline error banner used by [DSAuthScaffold]. Exposed so screens
/// that need a warning outside the auth card can match it exactly.
class DSAuthErrorBanner extends StatelessWidget {
  const DSAuthErrorBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final colors = theme.colors;

    return Semantics(
      liveRegion: true,
      container: true,
      child: Container(
        padding: const EdgeInsets.all(DSSpacing.md),
        decoration: BoxDecoration(
          color: colors.danger.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(DSRadius.md),
          border: Border.all(color: colors.danger.withValues(alpha: 0.4)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.error_outline, size: 18, color: colors.danger),
            const SizedBox(width: DSSpacing.sm),
            Expanded(
              child: Text(
                message,
                style: theme.typography.bodySmall.copyWith(
                  color: colors.danger,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
