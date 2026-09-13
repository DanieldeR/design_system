# E-ink mode

`DSThemeData.eInk` (Flutter) / `<DSTheme brightness="eink">` (React) targets
electrophoretic displays — specifically a Boox Palma-class device: 6.13″,
300 PPI, 16 grey levels, Android, no colour.

It is **not a third colour scheme.** Light and dark differ in which end of the
ramp the page sits at; e-ink differs in what the hardware can do at all. Three
assumptions every other theme makes are false here:

| Assumption | Reality on e-ink |
|---|---|
| A pixel can be any of ~16M colours | 16 grey levels, and only ~8 are distinguishable at arm's length |
| Repainting a pixel is free | A repaint is pigment physically moving: 150–800ms, and it leaves residue |
| Motion communicates | A "fade" is a burst of partial refreshes resolving after the gesture ended |

Everything below follows from those three rows.

---

## The grey ramp

An E Ink Carta panel addresses exactly 16 levels, evenly spaced at multiples of
17. `DSPalette.ink0…ink15` land on eight of them — which is why every value is a
repeated hex digit (`#333333`, `#777777`, `#DDDDDD`).

```
ink0  #000000  full ink        ink9   #999999  strong rule
ink3  #333333  secondary ink   ink11  #BBBBBB  hairline rule
ink5  #555555  heavy fill      ink13  #DDDDDD  wash fill
ink7  #777777  disabled ink    ink15  #FFFFFF  paper
```

Two rules, both enforced by `test/eink_test.dart`:

**Stay on the ramp.** A colour that misses it is approximated with a dither
pattern, and that pattern is what smears into the next frame as ghosting.
`#EEEEEE` is not "almost `#DDDDDD`" — it is `#DDDDDD` and `#FFFFFF` interleaved.

**Skip every other level.** Adjacent levels are not reliably distinguishable
under reflected light. Exposing all 16 would invite hierarchies the reader
cannot see.

### What the palette gives up

Three collapses, each losing a channel the emissive themes lean on:

1. **`brand` and `accent` are the same ink.** A monochrome panel cannot carry
   two peer emphasis colours. Navy-vs-copper becomes **filled-vs-ruled** at the
   component layer.
2. **`success`, `warning`, `danger`, `info` are the same ink.** Status has to be
   *spoken*, not tinted. Salience comes from inversion. **The meaning must be in
   the label** — `DSBadge(label: 'Overdue', tone: danger)` works; a bare `3`
   does not, because on paper it is just an inverted 3.
3. **`overlay` is opaque paper, not a scrim.** A translucent black wash is a
   large field of mid-grey: simultaneously the lowest-contrast tone, the slowest
   to settle, and the most visible source of residue when it clears. A modal
   *replaces* the page rather than dimming it — the print analogy is turning to
   a new page, not holding a filter over the old one.

### Why there is no e-ink dark theme

Inverting means the panel holds most of its pigment in the dark state. That
costs more of the refresh budget and makes residue from the previous frame far
more visible. Black on white, always.

---

## Elevation becomes stroke weight

There are no shadows. `--ds-elevation-1…4` resolve to `none`, and `DSCard`
skips its `boxShadow` entirely. A soft shadow on electrophoretic ink is a band
of mid-grey that reads as smudge, not depth.

Hierarchy moves to `DSStrokes`, whose steps widen on e-ink because weight is now
carrying meaning colour used to carry:

| | emissive | e-ink | used for |
|---|---|---|---|
| `hairline` | 1.0 | 1.0 | internal separators (`DSDivider`) |
| `regular` | 1.0 | 1.5 | resting surface or control |
| `heavy` | 1.5 | 2.0 | elevated surface, focused control |
| `emphasis` | 2.0 | 3.0 | error, selected tab |

Three steps is the most a reader can reliably tell apart on paper. That is why
`DSInput` has exactly three states (resting / focused / errored) and not four.

Corners square off for the same reason shadows go: a curve is drawn by
antialiasing it into intermediate greys, and those in-between tones are the
first pixels to smear. Pills keep `radius-full` — a fully-round end reads as a
shape, not an artifact.

---

## Motion is off, not reduced

`DSMotion.none` zeroes every duration, and `toMaterialTheme()` additionally
kills ripples, hover, and route transitions. The React side adds a blanket
`transition-duration: 0s !important` under `[data-ds-theme="eink"]` to catch
consumer CSS.

Check `theme.motion.enabled` before starting anything **looping or
indeterminate**. A spinner never stops requesting repaints, so it holds the
refresh pipeline busy for exactly as long as the app can least afford it —
`DSButton(loading: true)` renders a static glyph instead.

The general rule: **prefer state changes that repaint few pixels.** This is why
`DSTabs` marks selection with a heavier underline rather than inverting the
selected tab. Inverting is louder, and it is the wrong answer: it fills a large
region with ink and has to clear it again on the next switch — the slowest kind
of repaint and the one that leaves the most residue.

---

## Type

`DSTypography.eInk` makes four systematic changes:

- **Body sizes go up ~2px; 12px disappears.** An emissive panel leans on
  subpixel rendering to hold small glyphs together. A monochrome e-ink panel has
  no colour subpixels to borrow, so small text is antialiased in *grey* — and
  those grey edge pixels are both lower-contrast under reflected light and the
  first thing to ghost.
- **Weights go up one step.** Thin strokes are the failure mode of
  electrophoretic ink: a stem that renders as a partly-charged pixel reads grey.
- **Line-height goes up ~10%.** More paper between rows means fewer adjacent
  pixels flipping state, which visibly reduces smearing.
- **Negative tracking removed; small sizes gain positive tracking.** Tight
  letterfit lets neighbouring glyph edges bleed together once ink spreads.

### The serif survives — with one exception

The usual advice is "no serifs on e-ink." That advice targets 150–200 PPI
panels. At the 300 PPI this theme assumes, Playfair Display's hairlines still
land on 2–3 device pixels and reproduce cleanly, so the two-typeface brand split
is kept. `headingSmall` is the exception: at 16px the hairlines finally drop
under a pixel, so it moves to IBM Plex Sans at 18px/700.

**On a panel below ~250 PPI, move the whole display family to the body face.**

---

## Touch targets

`DSTouchTarget.eInk` is 56px against Material's 48px. E-ink gives no immediate
feedback that a tap landed — no ripple, and the confirming repaint can be 300ms
away. A missed tap therefore costs the user a full second before they even know
they missed, so the fix is to miss less often.

---

## Checklist for new components

- [ ] Every colour comes from `DSColorScheme` — no literals, no alpha tints. A
      12%-alpha fill quantises to an indistinct grey and reads as a dirty patch.
- [ ] Radii from `theme.shape`, border widths from `theme.strokes`, durations
      from `theme.motion` — never hardcoded.
- [ ] Nothing depends on hue alone to distinguish two states.
- [ ] Nothing loops or animates without checking `theme.motion.enabled`.
- [ ] Interactive targets clear `theme.minTouchTarget`.
- [ ] Placeholder/hint text is not the only place a format is explained — put it
      in the label, since grey-in-a-field is what this theme is avoiding.
- [ ] Run `flutter test test/eink_test.dart`; it enforces the ramp, the contrast
      floors, and the collapses above.

## Known limits

- **Ghosting is not addressed here, because a design system cannot.** Full-panel
  refresh scheduling is a platform concern; on Onyx devices it belongs to the
  system or the vendor SDK. This theme's contribution is to *reduce the need* —
  fewer mid-greys, fewer repaints, smaller dirty rectangles.
- **`DSToast` remains a poor fit.** It costs two unprompted repaints at moments
  the user did not ask for. The e-ink theme docks it and lengthens it to 8s, but
  for anything that must not be missed, prefer `DSModal` or inline text.
- **`DSTooltip` is effectively desktop-only.** On a touch-only reader the only
  way to reach one is a long press — the same gesture most of this system uses
  for a primary action.
- **The React twin's fractional strokes depend on device pixel ratio.** At
  DPR 1 a browser may round `1.5px` down to `1px`, collapsing `regular` into
  `hairline`. On a ~2.75 DPR reader this does not arise; on a desktop preview at
  DPR 1 it can.
