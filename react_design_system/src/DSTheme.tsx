import React, { createContext, useContext } from "react";

export type DSBrightness = "light" | "dark";

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
 * wrapping element — the stylesheet's `[data-ds-theme="dark"]` rules
 * pick this up. Wrap your app's root (or a subtree) in `DSTheme`.
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
