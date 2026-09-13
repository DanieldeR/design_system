import React, { createContext, useContext } from "react";

/**
 * `"eink"` is not a third colour scheme — it is a different display
 * class. It squares off every corner, removes every shadow, zeroes
 * every transition, widens the stroke scale, enlarges the type, and
 * collapses the palette to eight true greys on the panel's native
 * 16-level ramp. See `doc/eink.md` for why each of those follows from
 * the hardware.
 */
export type DSBrightness = "light" | "dark" | "eink";

const DSBrightnessContext = createContext<DSBrightness>("light");

export interface DSThemeProps {
  /** @default "light" */
  brightness?: DSBrightness;
  children: React.ReactNode;
  className?: string;
  style?: React.CSSProperties;
}

/**
 * Provides design tokens to the subtree by setting `data-ds-theme` on a
 * wrapping element — the stylesheet's `[data-ds-theme="dark"]` and
 * `[data-ds-theme="eink"]` rules pick this up. Wrap your app's root (or
 * a subtree) in `DSTheme`.
 */
export function DSTheme({
  brightness = "light",
  children,
  className,
  style,
}: DSThemeProps) {
  return (
    <DSBrightnessContext.Provider value={brightness}>
      <div
        className={["ds-root", className].filter(Boolean).join(" ")}
        data-ds-theme={brightness}
        style={style}
      >
        {children}
      </div>
    </DSBrightnessContext.Provider>
  );
}

/** Reads the current theme brightness set by the nearest `DSTheme`. */
export function useDSBrightness(): DSBrightness {
  return useContext(DSBrightnessContext);
}
