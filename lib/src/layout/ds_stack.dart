import 'package:flutter/widgets.dart';

import '../tokens/ds_spacing.dart';

enum DSStackDirection { vertical, horizontal }

/// A [Row]/[Column] that inserts consistent [gap] spacing between its
/// children. Named `DSStack` (not `Stack`) to avoid colliding with
/// Flutter's positioning [Stack] widget — this is a "stack of items
/// with even spacing" in the design-system sense, not a z-order stack.
class DSStack extends StatelessWidget {
  const DSStack({
    super.key,
    required this.children,
    this.direction = DSStackDirection.vertical,
    this.gap = DSSpacing.md,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
  });

  final List<Widget> children;
  final DSStackDirection direction;
  final double gap;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    final spaced = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) {
        spaced.add(
          direction == DSStackDirection.vertical
              ? SizedBox(height: gap)
              : SizedBox(width: gap),
        );
      }
      spaced.add(children[i]);
    }

    return direction == DSStackDirection.vertical
        ? Column(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: spaced,
          )
        : Row(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: spaced,
          );
  }
}
