import 'package:flutter/widgets.dart';

// Fonts declared in this package's pubspec are registered under a
// "packages/design_system/" prefixed family name — reference that exact
// string rather than relying on implicit resolution.
const String _displayFontFamily = 'packages/design_system/Playfair Display';
const String _bodyFontFamily = 'packages/design_system/IBM Plex Sans';

/// Type scale for the design system.
///
/// Consume via `DSTheme.of(context).typography`. Display/heading styles
/// use [displayFontFamily] (Playfair Display — editorial, high-contrast
/// serif); body/label/caption use [bodyFontFamily] (IBM Plex Sans —
/// precise, geometric). The styles defined here intentionally omit
/// color — resolve that against the active [DSColorScheme].
@immutable
class DSTypography {
  const DSTypography({
    this.displayFontFamily = _displayFontFamily,
    this.bodyFontFamily = _bodyFontFamily,
    this.displayLarge = const TextStyle(
      fontFamily: _displayFontFamily,
      fontSize: 40,
      height: 48 / 40,
      fontWeight: FontWeight.w900,
      letterSpacing: -0.5,
    ),
    this.displayMedium = const TextStyle(
      fontFamily: _displayFontFamily,
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25,
    ),
    this.headingLarge = const TextStyle(
      fontFamily: _displayFontFamily,
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w700,
    ),
    this.headingMedium = const TextStyle(
      fontFamily: _displayFontFamily,
      fontSize: 20,
      height: 28 / 20,
      fontWeight: FontWeight.w600,
    ),
    this.headingSmall = const TextStyle(
      fontFamily: _displayFontFamily,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w600,
    ),
    this.bodyLarge = const TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
    ),
    this.bodyMedium = const TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w400,
    ),
    this.bodySmall = const TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w400,
    ),
    this.label = const TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 13,
      height: 16 / 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
    ),
    this.caption = const TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 11,
      height: 14 / 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
    ),
  });

  final String displayFontFamily;
  final String bodyFontFamily;
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle headingLarge;
  final TextStyle headingMedium;
  final TextStyle headingSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle label;
  final TextStyle caption;

  static const DSTypography standard = DSTypography();

  /// The e-ink type scale.
  ///
  /// Four systematic changes from [standard], each with a physical
  /// cause:
  ///
  /// * **Every body size goes up ~2px, and 12px disappears entirely.**
  ///   An emissive panel leans on subpixel rendering to hold small
  ///   glyphs together; a monochrome e-ink panel has no colour
  ///   subpixels to borrow, so small text is antialiased in grey
  ///   instead — and those grey edge pixels are both lower-contrast
  ///   under reflected light and the first thing to ghost.
  /// * **Every weight goes up one step.** Thin strokes are the
  ///   failure mode of electrophoretic ink: a stem that renders as a
  ///   partly-charged pixel reads as grey, not black.
  /// * **Line-height goes up ~10%.** Extra paper between rows means
  ///   fewer adjacent pixels flipping state, which visibly reduces
  ///   row-to-row smearing on a partial refresh.
  /// * **Negative tracking is removed and small sizes get positive
  ///   tracking.** Tight letterfit lets neighbouring glyph edges bleed
  ///   into each other once ink spreads a fraction of a pixel.
  ///
  /// The two-typeface brand split is *kept*, against the usual "no
  /// serifs on e-ink" advice, because that advice is aimed at 150-200
  /// PPI panels. At the 300 PPI this theme targets, Playfair's
  /// hairlines still land on 2-3 device pixels and render cleanly.
  /// [headingSmall] is the exception — at 16px the hairlines finally
  /// drop under a pixel, so it moves to the body face. On a panel
  /// below ~250 PPI, move the whole display family to the body face.
  static const DSTypography eInk = DSTypography(
    displayLarge: TextStyle(
      fontFamily: _displayFontFamily,
      fontSize: 40,
      height: 50 / 40,
      fontWeight: FontWeight.w900,
      letterSpacing: 0,
    ),
    displayMedium: TextStyle(
      fontFamily: _displayFontFamily,
      fontSize: 32,
      height: 42 / 32,
      fontWeight: FontWeight.w800,
      letterSpacing: 0,
    ),
    headingLarge: TextStyle(
      fontFamily: _displayFontFamily,
      fontSize: 24,
      height: 34 / 24,
      fontWeight: FontWeight.w800,
    ),
    headingMedium: TextStyle(
      fontFamily: _displayFontFamily,
      fontSize: 20,
      height: 30 / 20,
      fontWeight: FontWeight.w700,
    ),
    // Body face from here down — see the note above.
    headingSmall: TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 18,
      height: 26 / 18,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 18,
      height: 28 / 18,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    label: TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 14,
      height: 18 / 14,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
    ),
    caption: TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
    ),
  );
}
