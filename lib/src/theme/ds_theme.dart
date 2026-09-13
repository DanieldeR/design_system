import 'package:flutter/material.dart';

import '../tokens/ds_colors.dart';
import '../tokens/ds_surface.dart';
import '../tokens/ds_typography.dart';

/// The full set of design tokens for one theme (light or dark).
@immutable
class DSThemeData {
  const DSThemeData({
    required this.colors,
    this.typography = DSTypography.standard,
    this.brightness = Brightness.light,
    this.surfaceMode = DSSurfaceMode.emissive,
    this.shape = DSShape.standard,
    this.strokes = DSStrokes.standard,
    this.motion = DSMotion.standard,
    this.minTouchTarget = DSTouchTarget.standard,
  });

  final DSColorScheme colors;
  final DSTypography typography;
  final Brightness brightness;

  /// The class of display this theme is drawn on. Components branch on
  /// this for the handful of decisions that cannot be expressed as a
  /// token value — see [isEInk].
  final DSSurfaceMode surfaceMode;

  final DSShape shape;
  final DSStrokes strokes;
  final DSMotion motion;
  final double minTouchTarget;

  /// True when this theme targets an electrophoretic panel.
  ///
  /// Prefer reading [shape], [strokes], [motion] and [colors] — they
  /// already carry the e-ink values. Branch on this flag only for
  /// structural differences a token cannot express: swapping a
  /// spinner for a static glyph, collapsing badge tones to salience
  /// levels, replacing a scrim with an opaque page.
  bool get isEInk => surfaceMode == DSSurfaceMode.eInk;

  static const DSThemeData light = DSThemeData(
    colors: DSColorScheme.light,
    brightness: Brightness.light,
  );

  static const DSThemeData dark = DSThemeData(
    colors: DSColorScheme.dark,
    brightness: Brightness.dark,
  );

  /// The e-ink theme.
  ///
  /// Note it reports [Brightness.light]: the panel is paper, and every
  /// platform affordance that keys off brightness (text selection
  /// handles, status-bar icons, autofill overlays) should assume dark
  /// content on a light ground. There is deliberately no dark e-ink
  /// theme — see [DSColorScheme.eInk].
  static const DSThemeData eInk = DSThemeData(
    colors: DSColorScheme.eInk,
    typography: DSTypography.eInk,
    brightness: Brightness.light,
    surfaceMode: DSSurfaceMode.eInk,
    shape: DSShape.eInk,
    strokes: DSStrokes.eInk,
    motion: DSMotion.none,
    minTouchTarget: DSTouchTarget.eInk,
  );

  DSThemeData copyWith({
    DSColorScheme? colors,
    DSTypography? typography,
    Brightness? brightness,
    DSSurfaceMode? surfaceMode,
    DSShape? shape,
    DSStrokes? strokes,
    DSMotion? motion,
    double? minTouchTarget,
  }) {
    return DSThemeData(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      brightness: brightness ?? this.brightness,
      surfaceMode: surfaceMode ?? this.surfaceMode,
      shape: shape ?? this.shape,
      strokes: strokes ?? this.strokes,
      motion: motion ?? this.motion,
      minTouchTarget: minTouchTarget ?? this.minTouchTarget,
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
      // On e-ink these three are not decoration — they are repaint
      // requests. A ripple is ~300ms of partial refreshes chasing a
      // finger that has already lifted; the panel is still catching up
      // with the splash when the next screen arrives. Hover has no
      // meaning on a touch-only reader and only fires spuriously.
      splashFactory: isEInk ? NoSplash.splashFactory : null,
      splashColor: isEInk ? const Color(0x00000000) : null,
      highlightColor: isEInk ? const Color(0x00000000) : null,
      hoverColor: isEInk ? const Color(0x00000000) : null,
      // Route transitions are the single largest source of wasted
      // refresh on an e-ink device: a slide or fade repaints the whole
      // screen many times to arrive somewhere it could have arrived in
      // one. Cut straight to the destination.
      pageTransitionsTheme: isEInk
          ? const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: _NoPageTransitionsBuilder(),
                TargetPlatform.iOS: _NoPageTransitionsBuilder(),
                TargetPlatform.linux: _NoPageTransitionsBuilder(),
                TargetPlatform.macOS: _NoPageTransitionsBuilder(),
                TargetPlatform.windows: _NoPageTransitionsBuilder(),
              },
            )
          : null,
    );
  }
}

/// Hands back the destination page with no interpolation at all.
class _NoPageTransitionsBuilder extends PageTransitionsBuilder {
  const _NoPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => child;
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
