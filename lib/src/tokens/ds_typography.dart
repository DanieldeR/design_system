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
}
