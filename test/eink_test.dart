import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:design_system/design_system.dart';

Widget _wrapEInk(Widget child) {
  return MaterialApp(
    theme: DSThemeData.eInk.toMaterialTheme(),
    home: DSTheme(
      data: DSThemeData.eInk,
      child: Scaffold(body: Center(child: child)),
    ),
  );
}

/// Relative luminance per WCAG 2.x.
double _luminance(Color c) {
  double channel(double v) =>
      v <= 0.03928 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
  return 0.2126 * channel(c.r) +
      0.7152 * channel(c.g) +
      0.0722 * channel(c.b);
}

double _contrast(Color a, Color b) {
  final la = _luminance(a);
  final lb = _luminance(b);
  final hi = math.max(la, lb);
  final lo = math.min(la, lb);
  return (hi + 0.05) / (lo + 0.05);
}

/// Every colour an e-ink theme emits must be a true grey that lands on
/// one of the panel's 16 addressable levels (multiples of 17). Anything
/// else gets dithered into a pixel pattern, and that pattern is what
/// ghosts.
void _expectOnInkRamp(Color c, String name) {
  final r = (c.r * 255).round();
  final g = (c.g * 255).round();
  final b = (c.b * 255).round();
  expect(r, g, reason: '$name is not a true grey ($r,$g,$b)');
  expect(g, b, reason: '$name is not a true grey ($r,$g,$b)');
  expect(
    r % 17,
    0,
    reason: '$name (#${r.toRadixString(16)}) is not on the 16-level ramp',
  );
  expect(c.a, 1.0, reason: '$name is not fully opaque');
}

void main() {
  group('e-ink colour scheme', () {
    const scheme = DSColorScheme.eInk;

    test('every role lands on the panel\'s native 16-level grey ramp', () {
      _expectOnInkRamp(scheme.brand, 'brand');
      _expectOnInkRamp(scheme.onBrand, 'onBrand');
      _expectOnInkRamp(scheme.accent, 'accent');
      _expectOnInkRamp(scheme.onAccent, 'onAccent');
      _expectOnInkRamp(scheme.surface, 'surface');
      _expectOnInkRamp(scheme.surfaceVariant, 'surfaceVariant');
      _expectOnInkRamp(scheme.background, 'background');
      _expectOnInkRamp(scheme.border, 'border');
      _expectOnInkRamp(scheme.textPrimary, 'textPrimary');
      _expectOnInkRamp(scheme.textSecondary, 'textSecondary');
      _expectOnInkRamp(scheme.textDisabled, 'textDisabled');
      _expectOnInkRamp(scheme.success, 'success');
      _expectOnInkRamp(scheme.warning, 'warning');
      _expectOnInkRamp(scheme.danger, 'danger');
      _expectOnInkRamp(scheme.info, 'info');
      _expectOnInkRamp(scheme.overlay, 'overlay');
    });

    test('text roles clear their contrast floors against paper', () {
      // Reflected-light reading has no backlight to fall back on, so
      // body text is held to AAA rather than AA.
      expect(_contrast(scheme.textPrimary, scheme.surface), greaterThan(7.0));
      expect(_contrast(scheme.textSecondary, scheme.surface), greaterThan(7.0));
      // Disabled text is exempt from WCAG, but must stay readable —
      // "unavailable" should not mean "illegible".
      expect(_contrast(scheme.textDisabled, scheme.surface), greaterThan(4.0));
    });

    test('the page is paper and the ink is black, never inverted', () {
      expect(scheme.background, DSPalette.ink15);
      expect(scheme.textPrimary, DSPalette.ink0);
    });

    test('the modal barrier is opaque, not a mid-grey scrim', () {
      expect(scheme.overlay.a, 1.0);
      expect(scheme.overlay, scheme.surface);
    });
  });

  group('e-ink theme', () {
    test('reports e-ink mode and light brightness', () {
      expect(DSThemeData.eInk.isEInk, isTrue);
      expect(DSThemeData.eInk.brightness, Brightness.light);
      expect(DSThemeData.light.isEInk, isFalse);
      expect(DSThemeData.dark.isEInk, isFalse);
    });

    test('all motion is off', () {
      const motion = DSMotion.none;
      expect(DSThemeData.eInk.motion.enabled, isFalse);
      expect(motion.fast, Duration.zero);
      expect(motion.normal, Duration.zero);
      expect(motion.slow, Duration.zero);
    });

    test('corners are square except for pills', () {
      const shape = DSShape.eInk;
      expect(shape.sm, 0);
      expect(shape.md, 0);
      expect(shape.lg, 0);
      expect(shape.xl, 0);
      expect(shape.full, DSRadius.full);
    });

    test('stroke steps are far enough apart to tell apart on paper', () {
      const s = DSStrokes.eInk;
      expect(s.regular, greaterThan(s.hairline));
      expect(s.heavy, greaterThan(s.regular));
      expect(s.emphasis, greaterThan(s.heavy));
      // Elevation is expressed as weight, not blur.
      expect(s.forElevation(DSElevation.none), s.regular);
      expect(s.forElevation(DSElevation.level4), s.emphasis);
    });

    testWidgets('the Material theme suppresses ripples and transitions', (
      tester,
    ) async {
      final material = DSThemeData.eInk.toMaterialTheme();
      expect(material.splashFactory, NoSplash.splashFactory);
      expect(material.splashColor.a, 0);
      expect(material.highlightColor.a, 0);
      expect(material.hoverColor.a, 0);

      final builder =
          material.pageTransitionsTheme.builders[TargetPlatform.android];
      expect(builder, isNotNull);

      // Confirm it is genuinely a pass-through, not merely present.
      await tester.pumpWidget(const MaterialApp(home: SizedBox.shrink()));
      const marker = SizedBox.shrink();
      expect(
        builder!.buildTransitions<void>(
          MaterialPageRoute<void>(builder: (_) => marker),
          tester.element(find.byType(SizedBox).first),
          const AlwaysStoppedAnimation(1),
          const AlwaysStoppedAnimation(1),
          marker,
        ),
        same(marker),
      );
    });

    test('touch targets are larger than the Material baseline', () {
      expect(
        DSThemeData.eInk.minTouchTarget,
        greaterThan(DSThemeData.light.minTouchTarget),
      );
    });
  });

  group('e-ink typography', () {
    const type = DSTypography.eInk;
    const standard = DSTypography.standard;

    test('nothing renders below 12px, and body text starts at 14px', () {
      expect(type.caption.fontSize, greaterThanOrEqualTo(12));
      expect(type.bodySmall.fontSize, greaterThanOrEqualTo(14));
      expect(type.bodyMedium.fontSize, greaterThanOrEqualTo(16));
    });

    test('every body size is larger than its emissive counterpart', () {
      expect(type.bodySmall.fontSize!, greaterThan(standard.bodySmall.fontSize!));
      expect(
        type.bodyMedium.fontSize!,
        greaterThan(standard.bodyMedium.fontSize!),
      );
      expect(type.bodyLarge.fontSize!, greaterThan(standard.bodyLarge.fontSize!));
    });

    test('no style uses negative tracking', () {
      for (final style in [
        type.displayLarge,
        type.displayMedium,
        type.headingLarge,
        type.headingMedium,
        type.headingSmall,
        type.bodyLarge,
        type.bodyMedium,
        type.bodySmall,
        type.label,
        type.caption,
      ]) {
        expect(style.letterSpacing ?? 0, greaterThanOrEqualTo(0));
      }
    });

    test('body weights are at least medium', () {
      expect(type.bodySmall.fontWeight!.value, greaterThanOrEqualTo(500));
      expect(type.bodyMedium.fontWeight!.value, greaterThanOrEqualTo(500));
      expect(type.bodyLarge.fontWeight!.value, greaterThanOrEqualTo(500));
    });

    test('small headings drop the hairline serif for the body face', () {
      expect(type.headingSmall.fontFamily, type.bodyFontFamily);
      // …but the editorial serif survives where it is big enough to
      // reproduce, which is the brand's whole character.
      expect(type.headingLarge.fontFamily, type.displayFontFamily);
      expect(type.displayLarge.fontFamily, type.displayFontFamily);
    });
  });

  group('e-ink components', () {
    testWidgets('an elevated DSCard draws weight instead of a shadow', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrapEInk(const DSCard(elevated: true, child: Text('Topic'))),
      );

      final decoration = tester
          .widgetList<Container>(find.byType(Container))
          .map((c) => c.decoration)
          .whereType<BoxDecoration>()
          .firstWhere((d) => d.border != null);

      expect(decoration.boxShadow, anyOf(isNull, isEmpty));
      expect(
        (decoration.border as Border).top.width,
        DSStrokes.eInk.heavy,
      );
    });

    testWidgets('a resting DSCard is lighter than an elevated one', (
      tester,
    ) async {
      BoxDecoration decorationOf(WidgetTester t) => t
          .widgetList<Container>(find.byType(Container))
          .map((c) => c.decoration)
          .whereType<BoxDecoration>()
          .firstWhere((d) => d.border != null);

      await tester.pumpWidget(_wrapEInk(const DSCard(child: Text('Topic'))));
      final resting = (decorationOf(tester).border as Border).top.width;

      await tester.pumpWidget(
        _wrapEInk(const DSCard(elevated: true, child: Text('Topic'))),
      );
      final elevated = (decorationOf(tester).border as Border).top.width;

      expect(elevated, greaterThan(resting));
    });

    testWidgets('DSBadge collapses six tones to three salience levels', (
      tester,
    ) async {
      Future<BoxDecoration> render(DSBadgeTone tone) async {
        await tester.pumpWidget(_wrapEInk(DSBadge(label: 'x', tone: tone)));
        return tester
            .widgetList<Container>(find.byType(Container))
            .map((c) => c.decoration)
            .whereType<BoxDecoration>()
            .first;
      }

      final danger = await render(DSBadgeTone.danger);
      final warning = await render(DSBadgeTone.warning);
      final success = await render(DSBadgeTone.success);
      final info = await render(DSBadgeTone.info);
      final neutral = await render(DSBadgeTone.neutral);

      // Loud: inverted, no rule.
      expect(danger.color, DSColorScheme.eInk.brand);
      expect(warning.color, danger.color);
      // Ordinary: paper with a rule.
      expect(success.color, DSColorScheme.eInk.surface);
      expect(success.border, isNotNull);
      expect(info.color, success.color);
      // Quiet: wash, no rule.
      expect(neutral.color, DSColorScheme.eInk.surfaceVariant);
      expect(neutral.border, isNull);
      // And the three levels really are distinct from one another.
      expect(danger.color, isNot(success.color));
      expect(success.color, isNot(neutral.color));
    });

    testWidgets('a loading DSButton shows a static glyph, not a spinner', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrapEInk(DSButton(label: 'Saving', loading: true, onPressed: () {})),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byIcon(Icons.hourglass_empty), findsOneWidget);
    });

    testWidgets('a disabled DSButton is the quietest thing on the page', (
      tester,
    ) async {
      for (final variant in [
        DSButtonVariant.primary,
        DSButtonVariant.danger,
      ]) {
        await tester.pumpWidget(
          _wrapEInk(
            DSButton(label: 'Save', variant: variant, onPressed: null),
          ),
        );

        final material = tester.widget<Material>(
          find
              .descendant(
                of: find.byType(DSButton),
                matching: find.byType(Material),
              )
              .first,
        );

        // The bug this guards: `border` is full black on e-ink, so a
        // disabled filled button used to paint solid ink.
        expect(
          material.color,
          isNot(DSColorScheme.eInk.border),
          reason: '$variant disabled must not paint solid ink',
        );
        expect(material.color, DSColorScheme.eInk.surfaceVariant);
        expect(
          _contrast(material.color!, DSColorScheme.eInk.surface),
          lessThan(_contrast(
            DSColorScheme.eInk.brand,
            DSColorScheme.eInk.surface,
          )),
          reason: '$variant disabled must read quieter than enabled',
        );
      }
    });

    testWidgets('a ghost DSButton is outlined so it reads as pressable', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrapEInk(
          DSButton(
            label: 'Later',
            variant: DSButtonVariant.ghost,
            onPressed: () {},
          ),
        ),
      );

      final decorations = tester
          .widgetList<Container>(find.byType(Container))
          .map((c) => c.decoration)
          .whereType<BoxDecoration>()
          .where((d) => d.border != null);

      expect(decorations, isNotEmpty);
    });

    testWidgets('DSTabs marks selection with rule weight, not colour', (
      tester,
    ) async {
      const tabs = [DSTabItem(label: 'Map'), DSTabItem(label: 'List')];
      await tester.pumpWidget(
        _wrapEInk(DSTabs(tabs: tabs, selectedIndex: 0, onChanged: (_) {})),
      );

      final bottoms = tester
          .widgetList<Container>(find.byType(Container))
          .map((c) => c.decoration)
          .whereType<BoxDecoration>()
          .map((d) => d.border)
          .whereType<Border>()
          .map((b) => b.bottom)
          .toList();

      final selected = bottoms.firstWhere((s) => s.color.a > 0);
      expect(selected.width, DSStrokes.eInk.emphasis);
      // Inverting the tab would repaint a large region on every switch;
      // the underline keeps the dirty rectangle small.
      expect(selected.color, DSColorScheme.eInk.accent);
    });

    testWidgets('DSInput separates resting, focused and errored by weight', (
      tester,
    ) async {
      Future<InputDecoration> render({String? error}) async {
        await tester.pumpWidget(
          _wrapEInk(DSInput(label: 'Topic', errorText: error)),
        );
        return tester.widget<TextField>(find.byType(TextField)).decoration!;
      }

      final resting = await render();
      final errored = await render(error: 'Required');

      final restingWidth = resting.enabledBorder!.borderSide.width;
      final focusedWidth = resting.focusedBorder!.borderSide.width;
      final erroredWidth = errored.enabledBorder!.borderSide.width;

      expect(focusedWidth, greaterThan(restingWidth));
      expect(erroredWidth, greaterThan(focusedWidth));
      // The error also has to say what it is — the ink is identical.
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('DSDivider takes the theme hairline, below a card outline', (
      tester,
    ) async {
      await tester.pumpWidget(_wrapEInk(const DSDivider()));
      final box = tester.widget<Container>(find.byType(Container));
      expect(box.constraints?.maxHeight, DSStrokes.eInk.hairline);
      expect(DSStrokes.eInk.hairline, lessThan(DSStrokes.eInk.regular));
    });
  });
}
