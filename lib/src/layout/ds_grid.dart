import 'package:flutter/widgets.dart';

import '../tokens/ds_spacing.dart';

/// A simple fixed-column-count grid with consistent row/column gaps.
///
/// For scrolling grids with many items, prefer [GridView] directly;
/// [DSGrid] is meant for small, non-scrolling layouts (e.g. a form's
/// field grid, a dashboard's card grid).
class DSGrid extends StatelessWidget {
  const DSGrid({
    super.key,
    required this.children,
    this.columns = 2,
    this.gap = DSSpacing.md,
    this.runGap,
  });

  final List<Widget> children;
  final int columns;
  final double gap;
  final double? runGap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalGap = gap * (columns - 1);
        final columnWidth = (constraints.maxWidth - totalGap) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: runGap ?? gap,
          children: [
            for (final child in children)
              SizedBox(width: columnWidth, child: child),
          ],
        );
      },
    );
  }
}
