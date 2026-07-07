/// Spacing scale used for padding, gaps, and margins across the design
/// system. Values are logical pixels on a 4px base unit.
abstract final class DSSpacing {
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
  static const double xxxxl = 64;
}

/// Corner radius scale used across surfaces and controls. Deliberately
/// tight — an architectural, precision-engineered feel rather than soft
/// or bouncy.
abstract final class DSRadius {
  static const double none = 0;
  static const double sm = 2;
  static const double md = 4;
  static const double lg = 6;
  static const double xl = 8;
  static const double full = 999;
}

/// Elevation scale (shadow blur/offset presets), expressed as a simple
/// 0-4 scale rather than raw shadow lists so callers can reason about
/// "how elevated" a surface is.
abstract final class DSElevation {
  static const double none = 0;
  static const double level1 = 1;
  static const double level2 = 2;
  static const double level3 = 3;
  static const double level4 = 4;
}
