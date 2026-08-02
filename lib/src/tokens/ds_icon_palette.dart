import 'package:flutter/material.dart';

import 'ds_colors.dart';

/// The shared app-icon palette.
///
/// Every app in the family draws a different mark — a mentor/mentee link, a
/// branching canvas, an aura ring, a lightbulb — but they all sit on the same
/// ground and use the same accent, so the set reads as one family on a home
/// screen. This is the single source of truth for those colours; the icon
/// generators in each app (`tool/branding/generate_icons.py`,
/// `tool/app_icon/build_icons.mjs`, `design/icons/generate.py`,
/// `tools/generate_icons.py`) mirror these values.
///
/// Only the palette is shared. Each app owns its own mark geometry, and the
/// corner radius of a self-rounded tile stays a per-app decision.
abstract final class DSIconPalette {
  /// Ground gradient, drawn top-left to bottom-right across the full tile.
  ///
  /// Navy deep enough that both the matte-white figure and the copper accent
  /// keep contrast at launcher sizes, with enough travel across the diagonal
  /// to give the tile some form.
  static const Color groundStart = DSPalette.navy700; // #182C47
  static const Color groundEnd = DSPalette.navy900; // #0A1420

  /// The ground as a ready-made gradient.
  static const LinearGradient ground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [groundStart, groundEnd],
  );

  /// The primary figure sitting on the ground — matte white, never pure white.
  static const Color figure = DSPalette.neutral50; // #F7F9FB

  /// A shaded variant of [figure], for marks that model depth on white shapes.
  static const Color figureShade = DSPalette.neutral300; // #C6CFDA

  /// The single accent. Use this flat wherever one copper value is enough.
  static const Color accent = DSPalette.copper400; // #C17F4C

  /// Accent ramp, for marks that need the accent modelled rather than flat.
  static const Color accentLight = DSPalette.copper300; // #D29A6D
  static const Color accentDark = DSPalette.copper500; // #A8703F

  /// Structural strokes and connective lines — subordinate to figure/accent.
  static const Color structure = DSPalette.navy400; // #4F739E

  /// Shadows, vignettes and any ink darker than the ground.
  static const Color ink = DSPalette.navy900; // #0A1420

  /// Fraction of the canvas radius that a mark must stay inside to survive
  /// both Android's adaptive-icon crop and a `maskable` web icon.
  static const double maskSafeRadiusFraction = 0.283;

  /// Corner radius of a self-rounded icon tile, as a fraction of the tile's
  /// side.
  ///
  /// Applied only to the surfaces an app rounds itself: the web `any` icons,
  /// the favicon and the Android legacy mipmaps. The maskable web icons and
  /// the Android adaptive layers stay full-bleed and square, because the
  /// launcher supplies its own mask there and a self-rounded corner would
  /// either be cropped away or leave a gap. Deliberately tight, echoing the
  /// `DSRadius` scale rather than the platform's softer default.
  static const double tileCornerFraction = 0.148;
}
