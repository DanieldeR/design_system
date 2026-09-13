import 'package:flutter/widgets.dart';

import 'ds_spacing.dart';

/// Which class of display a theme is being rendered on.
///
/// Almost every visual decision in this design system assumes an
/// *emissive* panel: one that can hold millions of colours, redraw a
/// pixel for free, and animate at 60fps. Electrophoretic (e-ink) panels
/// break all three assumptions at once, so they get their own mode
/// rather than being treated as "light mode, but grey".
///
/// See `doc/eink.md` for the reasoning behind each e-ink token value.
enum DSSurfaceMode {
  /// A backlit LCD/OLED panel — full colour, free repaints, smooth motion.
  emissive,

  /// An electrophoretic panel — a fixed grey ramp, a repaint budget
  /// measured in hundreds of milliseconds, and visible ghosting.
  eInk,
}

/// Corner radii, as a themeable object rather than raw [DSRadius]
/// constants, so a theme can flatten them.
///
/// On e-ink every curved edge is drawn by antialiasing it into
/// intermediate greys. Those in-between tones are exactly the pixels
/// that ghost, and they are the first thing to smear on a partial
/// refresh — so the e-ink theme squares everything off. Pills keep
/// their radius: a fully-round end is read as a shape, not as an
/// antialiasing artifact.
@immutable
class DSShape {
  const DSShape({
    this.sm = DSRadius.sm,
    this.md = DSRadius.md,
    this.lg = DSRadius.lg,
    this.xl = DSRadius.xl,
    this.full = DSRadius.full,
  });

  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double full;

  static const DSShape standard = DSShape();

  static const DSShape eInk = DSShape(
    sm: DSRadius.none,
    md: DSRadius.none,
    lg: DSRadius.none,
    xl: DSRadius.none,
    full: DSRadius.full,
  );
}

/// Border weights.
///
/// On an emissive panel, hierarchy between surfaces is carried by
/// shadow: a card floats above the page. An e-ink panel has no way to
/// render a soft shadow that does not turn into a band of ghosting
/// grey, so **stroke weight becomes the elevation channel**. A card
/// that would have cast a shadow instead draws a heavier outline.
@immutable
class DSStrokes {
  const DSStrokes({
    this.hairline = 1.0,
    this.regular = 1.0,
    this.heavy = 1.5,
    this.emphasis = 2.0,
  });

  /// The lightest rule the design system draws — internal separators.
  final double hairline;

  /// The default outline on a resting surface or control.
  final double regular;

  /// A surface that is lifted, or a control that is focused.
  final double heavy;

  /// The loudest rule available — an error, or a selected tab.
  final double emphasis;

  static const DSStrokes standard = DSStrokes();

  /// Every step is widened, and the gaps between steps are widened
  /// more, because weight is now carrying meaning that colour used to
  /// carry and the reader has to be able to tell two rules apart at a
  /// glance.
  static const DSStrokes eInk = DSStrokes(
    hairline: 1.0,
    regular: 1.5,
    heavy: 2.0,
    emphasis: 3.0,
  );

  /// The outline weight that stands in for a given [DSElevation] level.
  double forElevation(double level) {
    if (level <= DSElevation.none) return regular;
    if (level <= DSElevation.level2) return heavy;
    return emphasis;
  }
}

/// Animation durations, as a themeable object so a theme can switch
/// motion off entirely.
///
/// An e-ink panel repaints by physically moving pigment. A 200ms fade
/// is not a fade — it is a burst of partial refreshes, each one leaving
/// residue, and the "animation" the user actually sees is a grey
/// flicker that settles some time after the gesture ended. So the e-ink
/// theme sets every duration to zero: state changes are instantaneous
/// and land in a single repaint.
@immutable
class DSMotion {
  const DSMotion({
    this.fast = const Duration(milliseconds: 120),
    this.normal = const Duration(milliseconds: 200),
    this.slow = const Duration(milliseconds: 320),
    this.enabled = true,
  });

  final Duration fast;
  final Duration normal;
  final Duration slow;

  /// False when the theme wants no motion at all. Check this before
  /// starting anything looping or indeterminate (spinners, shimmer,
  /// pulsing placeholders) — those never stop requesting repaints, and
  /// on e-ink they will keep the panel busy until the widget unmounts.
  final bool enabled;

  static const DSMotion standard = DSMotion();

  static const DSMotion none = DSMotion(
    fast: Duration.zero,
    normal: Duration.zero,
    slow: Duration.zero,
    enabled: false,
  );
}

/// Minimum hit-target sizes.
///
/// E-ink devices give no immediate feedback that a tap landed — there
/// is no ripple, and the repaint that confirms the tap can be 300ms
/// away. A missed tap therefore costs the user a full second before
/// they even know they missed. Targets are enlarged past the usual
/// 48dp so that fewer taps miss in the first place.
abstract final class DSTouchTarget {
  /// Material's baseline.
  static const double standard = 48;

  /// The e-ink baseline.
  static const double eInk = 56;
}
