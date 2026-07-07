import 'package:flutter/widgets.dart';

import '../tokens/ds_spacing.dart';

/// A centered, max-width, padded content wrapper — the design system's
/// page/section container. Named `DSContainer` (not `Container`) to
/// avoid colliding with Flutter's basic layout [Container].
class DSContainer extends StatelessWidget {
  const DSContainer({
    super.key,
    required this.child,
    this.maxWidth = 1120,
    this.padding = const EdgeInsets.symmetric(horizontal: DSSpacing.xl),
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
