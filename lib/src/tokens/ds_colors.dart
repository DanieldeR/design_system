import 'package:flutter/material.dart';

/// Core color palette for the design system.
///
/// These are raw token values. Prefer consuming colors through
/// [DSColorScheme] (resolved against light/dark mode) rather than
/// referencing this palette directly in widget code.
///
/// Brand identity: sophisticated navy + matte white + brushed copper,
/// editorial meets engineering precision.
abstract final class DSPalette {
  // Navy (brand)
  static const Color navy50 = Color(0xFFEDF1F6);
  static const Color navy100 = Color(0xFFD2DCE8);
  static const Color navy200 = Color(0xFFA6B9D1);
  static const Color navy300 = Color(0xFF7896B9);
  static const Color navy400 = Color(0xFF4F739E);
  static const Color navy500 = Color(0xFF2A4A73);
  static const Color navy600 = Color(0xFF1F3A5C);
  static const Color navy700 = Color(0xFF182C47);
  static const Color navy800 = Color(0xFF111F33);
  static const Color navy900 = Color(0xFF0A1420);

  // Copper (accent)
  static const Color copper50 = Color(0xFFFAF1EA);
  static const Color copper100 = Color(0xFFF0DCC9);
  static const Color copper200 = Color(0xFFE2BC9C);
  static const Color copper300 = Color(0xFFD29A6D);
  static const Color copper400 = Color(0xFFC17F4C);
  static const Color copper500 = Color(0xFFA8703F);
  static const Color copper600 = Color(0xFF8C5B32);
  static const Color copper700 = Color(0xFF6E4727);
  static const Color copper800 = Color(0xFF4F331C);
  static const Color copper900 = Color(0xFF332012);

  // Neutral (cool slate-tinted, crisp and modern)
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF7F9FB);
  static const Color neutral100 = Color(0xFFEDF1F5);
  static const Color neutral200 = Color(0xFFDFE4EB);
  static const Color neutral300 = Color(0xFFC6CFDA);
  static const Color neutral400 = Color(0xFF97A2B0);
  static const Color neutral500 = Color(0xFF667180);
  static const Color neutral600 = Color(0xFF48515D);
  static const Color neutral700 = Color(0xFF333B45);
  static const Color neutral800 = Color(0xFF1D2229);
  static const Color neutral900 = Color(0xFF12161B);
  static const Color neutral1000 = Color(0xFF080A0D);

  // Semantic (muted, sophisticated)
  static const Color success500 = Color(0xFF3F6B4F);
  static const Color success100 = Color(0xFFDCE8E0);
  static const Color warning500 = Color(0xFFB8863F);
  static const Color warning100 = Color(0xFFF0E2CC);
  static const Color danger500 = Color(0xFF9C4A3F);
  static const Color danger100 = Color(0xFFECDAD7);
  static const Color info500 = Color(0xFF4A6FA5);
  static const Color info100 = Color(0xFFDDE5F0);

  // Ink (e-ink greyscale ramp)
  //
  // An E Ink Carta panel can address exactly 16 grey levels, evenly
  // spaced at multiples of 17 (0, 17, 34 … 255). Every value below
  // lands on one of them — which is why each is a repeated hex digit —
  // so the controller reproduces it directly instead of dithering it
  // out of two neighbouring levels. A colour that misses the ramp is
  // approximated with a pixel pattern, and that pattern is what
  // smears into the next frame as ghosting.
  //
  // Only alternating levels are exposed. Adjacent levels (e.g. #DDDDDD
  // vs #EEEEEE) are not reliably distinguishable at arm's length under
  // reflected light, so offering both would invite hierarchies the
  // reader cannot actually see.
  static const Color ink0 = Color(0xFF000000); // L0  full ink
  static const Color ink3 = Color(0xFF333333); // L3  secondary ink
  static const Color ink5 = Color(0xFF555555); // L5  heavy fill
  static const Color ink7 = Color(0xFF777777); // L7  disabled ink
  static const Color ink9 = Color(0xFF999999); // L9  strong rule
  static const Color ink11 = Color(0xFFBBBBBB); // L11 hairline rule
  static const Color ink13 = Color(0xFFDDDDDD); // L13 wash fill
  static const Color ink15 = Color(0xFFFFFFFF); // L15 paper
}

/// Semantic color roles resolved for the current theme brightness.
///
/// This is the token surface widgets should actually use, e.g.
/// `DSTheme.of(context).colors.surface`.
@immutable
class DSColorScheme {
  const DSColorScheme({
    required this.brand,
    required this.onBrand,
    required this.accent,
    required this.onAccent,
    required this.surface,
    required this.surfaceVariant,
    required this.background,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
    required this.overlay,
  });

  final Color brand;
  final Color onBrand;
  final Color accent;
  final Color onAccent;
  final Color surface;
  final Color surfaceVariant;
  final Color background;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color success;
  final Color warning;
  final Color danger;
  final Color info;
  final Color overlay;

  static const DSColorScheme light = DSColorScheme(
    brand: DSPalette.navy500,
    onBrand: DSPalette.neutral50,
    accent: DSPalette.copper500,
    onAccent: DSPalette.neutral0,
    surface: DSPalette.neutral0,
    surfaceVariant: DSPalette.neutral100,
    background: DSPalette.neutral50,
    border: DSPalette.neutral200,
    textPrimary: DSPalette.navy900,
    textSecondary: DSPalette.neutral500,
    textDisabled: DSPalette.neutral400,
    success: DSPalette.success500,
    warning: DSPalette.warning500,
    danger: DSPalette.danger500,
    info: DSPalette.info500,
    overlay: Color(0x730A1420),
  );

  static const DSColorScheme dark = DSColorScheme(
    brand: DSPalette.navy300,
    onBrand: DSPalette.navy900,
    accent: DSPalette.copper400,
    onAccent: DSPalette.navy900,
    surface: DSPalette.navy800,
    surfaceVariant: DSPalette.navy700,
    background: DSPalette.navy900,
    border: DSPalette.navy700,
    textPrimary: DSPalette.neutral50,
    textSecondary: DSPalette.neutral300,
    textDisabled: DSPalette.neutral500,
    success: Color(0xFF5A8F6D),
    warning: Color(0xFFD1A15C),
    danger: Color(0xFFC06E60),
    info: Color(0xFF6F93C9),
    overlay: Color(0x99000000),
  );

  /// The e-ink scheme: black ink on white paper, plus three greys.
  ///
  /// Three deliberate collapses happen here, and they are collapses —
  /// not translations. Each one loses a channel the emissive themes
  /// rely on, and the component layer has to make up the difference:
  ///
  /// 1. **[brand] and [accent] are the same ink.** A monochrome panel
  ///    cannot carry two peer emphasis colours. Navy-vs-copper becomes
  ///    filled-vs-ruled at the component level.
  /// 2. **[success], [warning], [danger] and [info] are the same ink.**
  ///    Status has to be spoken, not tinted — pair every semantic
  ///    surface with a glyph and a word. Salience is expressed by
  ///    inversion, not hue.
  /// 3. **[overlay] is opaque paper, not a scrim.** A translucent
  ///    black wash over a page is a large field of mid-grey: the worst
  ///    case for both contrast and ghosting. A modal replaces the page
  ///    rather than dimming it — the print analogy is turning to a new
  ///    page, not holding a filter over the old one.
  ///
  /// The page is white and the ink is black, never the reverse.
  /// Inverting it (dark mode) means the panel holds most of its
  /// pigment in the dark state, which both costs more of the refresh
  /// budget and makes residue from the previous frame far more
  /// visible. There is no e-ink dark theme for that reason.
  static const DSColorScheme eInk = DSColorScheme(
    brand: DSPalette.ink0,
    onBrand: DSPalette.ink15,
    accent: DSPalette.ink0,
    onAccent: DSPalette.ink15,
    surface: DSPalette.ink15,
    surfaceVariant: DSPalette.ink13,
    background: DSPalette.ink15,
    border: DSPalette.ink0,
    textPrimary: DSPalette.ink0, // 21:1 on paper
    textSecondary: DSPalette.ink3, // 12.6:1 — still comfortably AAA
    textDisabled: DSPalette.ink7, // 4.5:1 — reads as "off", stays legible
    success: DSPalette.ink0,
    warning: DSPalette.ink0,
    danger: DSPalette.ink0,
    info: DSPalette.ink0,
    overlay: DSPalette.ink15,
  );
}
