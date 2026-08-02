# App icon palette

Every app in the family draws a different mark, but they all share one ground
and one accent so the set reads as a family on a home screen. This page is the
source of truth for those colours; the canonical values live in code as
[`DSIconPalette`](../lib/src/tokens/ds_icon_palette.dart).

## The palette

| Role | Token | Hex | Used for |
| --- | --- | --- | --- |
| Ground start | `navy700` | `#182C47` | Top-left of the ground gradient |
| Ground end | `navy900` | `#0A1420` | Bottom-right of the ground gradient |
| Figure | `neutral50` | `#F7F9FB` | The primary shape on the ground |
| Figure shade | `neutral300` | `#C6CFDA` | Modelling on white shapes |
| Accent | `copper400` | `#C17F4C` | The single accent, used flat |
| Accent light | `copper300` | `#D29A6D` | Top of the accent ramp |
| Accent dark | `copper500` | `#A8703F` | Bottom of the accent ramp |
| Structure | `navy400` | `#4F739E` | Connective strokes, subordinate detail |
| Ink | `navy900` | `#0A1420` | Shadows and vignettes |

## Rules

- **Ground** is a linear gradient from `navy700` to `navy900`, running
  top-left to bottom-right across the full tile. Not vertical, not flat, and
  not a lighter navy — a lighter ground costs contrast against the copper.
- **Accent** is copper. Use `copper400` flat when one value will do; use the
  `copper300 → copper500` ramp only when the mark needs the accent modelled.
  Semantic colours (success / warning / danger) are for UI state, never for a
  launcher icon — an icon has no state to report.
- **Off-token colours are not allowed.** If a mark needs an ink darker than
  `navy900`, it needs a different mark.
- **Mask safety:** keep the mark inside a centred circle of radius
  `0.283 × canvas` so it survives both Android's adaptive-icon crop and a
  `maskable` web icon.
- **Corner radius:** the surfaces an app rounds itself — the web `any` icons,
  the favicon and the Android legacy mipmaps — use `0.148 × side`. The
  maskable web icons and the Android adaptive layers stay full-bleed and
  square; the launcher masks those itself, so a self-rounded corner there
  would only be cropped away or leave a gap.

## What stays per-app

Only the mark geometry. The ground, the accent and the corner radius are all
shared — an app on a home screen next to its siblings should look like the
same hand made all of them.

## Regenerating

Each app generates its icons from a script rather than hand-edited PNGs. When
a token here changes, update the mirrored constants at the top of each
generator and re-run it:

| App | Generator |
| --- | --- |
| Mentee CRM | `python3 tool/branding/generate_icons.py` |
| Learning Canvas | `node tool/app_icon/build_icons.mjs` |
| Migraine Buddy | `python3 design/icons/generate.py && python3 design/icons/rasterize.py` |
| Speed Math | `python3 tools/generate_icons.py` |
