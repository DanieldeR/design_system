import React from "react";

export interface DSDividerProps {
  /** @default 1 */
  thickness?: number;
  /** @default false */
  vertical?: boolean;
  className?: string;
}

/**
 * A thin separator line using the design system's border color.
 * Visual twin of the Flutter `DSDivider`.
 */
export function DSDivider({
  thickness = 1,
  vertical = false,
  className,
}: DSDividerProps) {
  const style = vertical ? { width: thickness } : { height: thickness };
  return (
    <div
      className={[
        "ds-divider",
        vertical ? "ds-divider--vertical" : "ds-divider--horizontal",
        className,
      ]
        .filter(Boolean)
        .join(" ")}
      style={style}
      role="separator"
      aria-orientation={vertical ? "vertical" : "horizontal"}
    />
  );
}
