/**
 * Numeric token values, mirroring lib/src/tokens/ds_spacing.dart.
 * Prefer the CSS custom properties (--ds-space-*, --ds-radius-*) in
 * stylesheets; these exist for JS-side defaults (e.g. component prop
 * defaults) where a CSS var can't be used directly.
 */
export const DSSpacing = {
  none: 0,
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
  xxxl: 48,
  xxxxl: 64,
} as const;

export const DSRadius = {
  none: 0,
  sm: 4,
  md: 8,
  lg: 12,
  xl: 16,
  full: 999,
} as const;

export type DSSpacingToken = keyof typeof DSSpacing;
export type DSRadiusToken = keyof typeof DSRadius;
