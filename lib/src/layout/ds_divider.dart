import 'package:flutter/widgets.dart';

import '../theme/ds_theme.dart';

/// A thin separator line using the design system's border color. Named
/// `DSDivider` (not `Divider`) to avoid colliding with Flutter's
/// Material [Divider].
///
/// Leave [thickness] null to take the theme's hairline weight. That
/// matters on e-ink, where the border colour is full black: a rule and
/// a card outline would otherwise be the same ink at the same weight,
/// and the hierarchy between "separates two rows" and "encloses a
/// surface" would disappear. Weight is the only thing keeping them
/// apart, so let the theme set it.
class DSDivider extends StatelessWidget {
  const DSDivider({super.key, this.thickness, this.vertical = false});

  /// Overrides the theme's hairline weight. Prefer leaving this null.
  final double? thickness;

  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.maybeOf(context) ?? DSThemeData.light;
    final width = thickness ?? theme.strokes.hairline;
    return vertical
        ? Container(width: width, color: theme.colors.border)
        : Container(height: width, color: theme.colors.border);
  }
}
