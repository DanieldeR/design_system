import 'package:flutter/material.dart';

import '../tokens/ds_colors.dart';
import '../tokens/ds_typography.dart';

/// The full set of design tokens for one theme (light or dark).
@immutable
class DSThemeData {
  const DSThemeData({
    required this.colors,
    this.typography = DSTypography.standard,
    this.brightness = Brightness.light,
  });

  final DSColorScheme colors;
  final DSTypography typography;
  final Brightness brightness;

  static const DSThemeData light = DSThemeData(
    colors: DSColorScheme.light,
    brightness: Brightness.light,
  );

  static const DSThemeData dark = DSThemeData(
    colors: DSColorScheme.dark,
    brightness: Brightness.dark,
  );

  DSThemeData copyWith({
    DSColorScheme? colors,
    DSTypography? typography,
    Brightness? brightness,
  }) {
    return DSThemeData(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      brightness: brightness ?? this.brightness,
    );
  }

  /// Builds a Material [ThemeData] whose defaults are driven by these
  /// tokens, so widgets that fall back to ambient Material theming
  /// (e.g. text selection, scrollbars) stay visually consistent.
  ThemeData toMaterialTheme() {
    final scheme = brightness == Brightness.dark
        ? ColorScheme.dark(
            primary: colors.brand,
            onPrimary: colors.onBrand,
            surface: colors.surface,
            error: colors.danger,
          )
        : ColorScheme.light(
            primary: colors.brand,
            onPrimary: colors.onBrand,
            surface: colors.surface,
            error: colors.danger,
          );
    return ThemeData(
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.background,
      fontFamily: typography.bodyFontFamily,
      useMaterial3: true,
    );
  }
}

/// Provides [DSThemeData] to the widget subtree. Wrap your app's root
/// (or a subtree) in [DSTheme] to make design tokens available via
/// `DSTheme.of(context)`.
class DSTheme extends StatelessWidget {
  const DSTheme({
    super.key,
    this.data = DSThemeData.light,
    required this.child,
  });

  final DSThemeData data;
  final Widget child;

  static DSThemeData of(BuildContext context) {
    final scope = DSThemeScope.maybeOf(context);
    if (scope == null) {
      throw FlutterError(
        'DSTheme.of() was called with a context that does not contain a '
        'DSTheme ancestor. Wrap your app in `DSTheme(data: ..., child: ...)`.',
      );
    }
    return scope.data;
  }

  /// Like [of], but returns null instead of throwing when no ancestor
  /// [DSTheme] is found.
  static DSThemeData? maybeOf(BuildContext context) {
    return DSThemeScope.maybeOf(context)?.data;
  }

  @override
  Widget build(BuildContext context) {
    return DSThemeScope(
      data: data,
      child: Theme(data: data.toMaterialTheme(), child: child),
    );
  }
}

class DSThemeScope extends InheritedWidget {
  const DSThemeScope({super.key, required this.data, required super.child});

  final DSThemeData data;

  DSColorScheme get colors => data.colors;

  static DSThemeScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DSThemeScope>();
  }

  @override
  bool updateShouldNotify(DSThemeScope oldWidget) => oldWidget.data != data;
}
