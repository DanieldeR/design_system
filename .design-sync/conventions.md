# Design System conventions

## Wrapping and setup

Wrap your app's root (or any subtree that renders these components) in `DSTheme`:

```tsx
import { DSTheme } from 'design-system';
import 'design-system/styles.css';

<DSTheme brightness="light">
  <App />
</DSTheme>
```

`DSTheme` sets `data-ds-theme="light"|"dark"` on a wrapping `<div className="ds-root">`. That `ds-root` class is what applies the base font-family and text color to the subtree — **without it, plain text elements (bare `<span>`/`<p>`/`<div>` with no `ds-text-*` class) fall back to the browser's default serif font**, even though components' own text (button labels, badges, etc.) still render correctly since those set their font explicitly. Always author your own layout text with one of the `ds-text-*` classes below, or nest it inside `DSTheme`.

Toggle dark mode by changing the `brightness` prop — there is no separate dark-mode component variant, every component reads the same CSS custom properties which `[data-ds-theme="dark"]` overrides.

`brightness="eink"` is a third value, and it is **not a third colour scheme** — it targets electrophoretic (e-ink) displays, where the palette collapses to eight true greys, every shadow becomes a border weight, every corner squares off, every transition is zeroed, and the type scale grows. See `doc/eink.md` for the full rationale; the section below covers what changes for you as a caller.

## Brand identity: editorial serif + engineering-precision sans

This is a **two-typeface system**, not one font everywhere — that split IS the brand character, so don't collapse it:

- **Playfair Display** (a high-contrast editorial serif) on every `ds-text-display-*` and `ds-text-heading-*` class — headings and display text should look distinctly "editorial masthead," not generic.
- **IBM Plex Sans** (precise, geometric) on `ds-text-body-*`, `ds-text-label`, and `ds-text-caption` — all UI/control text.

Never override `font-family` manually on either — always use the `ds-text-*` classes so the correct typeface is picked up.

Color-wise, the palette is **navy + cool neutrals + brushed copper**: `--ds-color-brand` is a deep sophisticated navy (primary actions — buttons, checkboxes, radios), `--ds-color-accent` is brushed copper (used sparingly for emphasis: the active tab indicator, focused input/select borders — reach for it when you want something to read as a deliberate highlight, not another primary action). Surfaces are crisp and modern: pure-white cards (`--ds-color-surface`) lifting off a soft cool-gray page (`--ds-color-background`), with cool slate-tinted borders. In dark mode the same roles map onto a near-black navy with layered surfaces.

Corners are deliberately tight (`--ds-radius-md` is 4px, not a soft 8+px) — architectural and precise, not soft or bouncy. Don't round corners beyond what the radius tokens give you.

## Writing components that survive e-ink

Under `brightness="eink"` the tokens do most of the work for you — but three
things break silently if you author around them:

- **Never encode meaning in hue alone.** `--ds-color-brand` and
  `--ds-color-accent` are the same ink there, and so are all four semantic
  colours. If two states differ only by colour, they are the same state on
  paper. Differentiate with fill-vs-rule, weight, or a glyph.
- **Never use alpha tints.** `color-mix(… 12%, transparent)` quantises to an
  indistinct grey and reads as a dirty patch. Use `--ds-color-surface-variant`
  for a quiet fill and `--ds-color-border` for a rule.
- **Never hardcode `1px`, `0.12s`, or a radius.** Route them through
  `--ds-stroke-*`, `--ds-motion-*`, and `--ds-radius-*` so the e-ink theme can
  widen, zero, and flatten them. A hardcoded value is the one thing that
  survives into e-ink unchanged, which is exactly what you don't want.

Two more, for anything interactive: give it `min-height: var(--ds-touch-target)`,
and don't start anything looping — a spinner never stops requesting repaints,
which is the worst thing you can do to a panel that repaints in ~300ms.

## Styling idiom: CSS custom properties

No utility-class system and no style props — style with `var(--ds-*)` custom properties. Real names, all defined in `styles.css`:

| Purpose | Tokens |
|---|---|
| Color (semantic, theme-aware) | `--ds-color-brand`, `--ds-color-on-brand`, `--ds-color-accent`, `--ds-color-on-accent`, `--ds-color-surface`, `--ds-color-surface-variant`, `--ds-color-background`, `--ds-color-border`, `--ds-color-text-primary`, `--ds-color-text-secondary`, `--ds-color-text-disabled`, `--ds-color-success`, `--ds-color-warning`, `--ds-color-danger`, `--ds-color-info`, `--ds-color-overlay` |
| Spacing | `--ds-space-xs` (4px) `sm` (8) `md` (12) `lg` (16) `xl` (24) `xxl` (32) `xxxl` (48) `xxxxl` (64) |
| Radius | `--ds-radius-sm` (2px) `md` (4) `lg` (6) `xl` (8) `full` (999) — tight, on purpose |
| Elevation | `--ds-elevation-1` … `--ds-elevation-4` (box-shadow values, navy-tinted; `none` under e-ink) |
| Stroke weight | `--ds-stroke-hairline` `regular` `heavy` `emphasis` — the elevation channel when shadows are unavailable |
| Motion | `--ds-motion-fast` (0.12s) `normal` (0.2s) `slow` (0.32s) — all `0s` under e-ink |
| Hit target | `--ds-touch-target` (48px; 56px under e-ink) |

For type, use the `ds-text-*` utility classes rather than raw `font-size`/`font-weight` — they carry the full scale (font family, size, line-height, weight, letter-spacing) as one unit: `ds-text-display-large`, `display-medium`, `heading-large`, `heading-medium`, `heading-small`, `body-large`, `body-medium`, `body-small`, `label`, `caption`. None of them set color — pair with a `--ds-color-text-*` custom property.

Raw palette steps (`--ds-palette-navy-500`, `--ds-palette-copper-500`, `--ds-palette-neutral-100`, etc.) exist but are building blocks for the semantic tokens — build UI against the semantic `--ds-color-*` tokens, not the palette. The `--ds-palette-ink-*` ramp is the e-ink equivalent: eight greys that land exactly on the 16 levels an E Ink Carta panel can address natively, which is why each is a repeated hex digit.

## Where the truth lives

- `styles.css` (imports everything — tokens, typography, base reset, every component's CSS) — read this before styling anything custom.
- Each component's `<Name>.d.ts` for its prop contract and `<Name>.prompt.md` for usage examples.

## Build snippet

```tsx
import { DSTheme, DSCard, DSStack, DSBadge, DSButton } from 'design-system';

<DSTheme brightness="light">
  <DSCard elevated>
    <DSStack gap="sm">
      <DSStack direction="horizontal" justify="space-between" align="center">
        <h3 className="ds-text-heading-small" style={{ color: 'var(--ds-color-text-primary)', margin: 0 }}>
          Q3 Roadmap
        </h3>
        <DSBadge label="Active" tone="success" />
      </DSStack>
      <p className="ds-text-body-medium" style={{ color: 'var(--ds-color-text-secondary)', margin: 0 }}>
        Tap to open the full planning document.
      </p>
      <DSButton label="Open" onClick={() => {}} />
    </DSStack>
  </DSCard>
</DSTheme>
```
