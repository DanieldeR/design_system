import 'package:flutter/widgets.dart';

import '../theme/ds_theme.dart';

/// A thin separator line using the design system's border color. Named
/// `DSDivider` (not `Divider`) to avoid colliding with Flutter's
/// Material [Divider].
class DSDivider extends StatelessWidget {
  const DSDivider({super.key, this.thickness = 1, this.vertical = false});

  final double thickness;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final colors = (DSTheme.maybeOf(context) ?? DSThemeData.light).colors;
    return vertical
        ? Container(width: thickness, color: colors.border)
        : Container(height: thickness, color: colors.border);
  }
}
