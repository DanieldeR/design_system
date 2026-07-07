import React from "react";
import { DSSpacing, type DSSpacingToken } from "../tokens";

export interface DSGridProps extends React.HTMLAttributes<HTMLDivElement> {
  children: React.ReactNode;
  /** @default 2 */
  columns?: number;
  /** A spacing token, or a raw pixel number. @default "md" */
  gap?: DSSpacingToken | number;
}

/**
 * A simple fixed-column-count grid with consistent gaps. Visual twin
 * of the Flutter `DSGrid`. For scrolling grids with many items, prefer
 * CSS grid/virtualization directly — this is for small, non-scrolling
 * layouts.
 */
export function DSGrid({
  children,
  columns = 2,
  gap = "md",
  style,
  ...rest
}: DSGridProps) {
  const gapPx = typeof gap === "number" ? gap : DSSpacing[gap];

  return (
    <div
      style={{
        display: "grid",
        gridTemplateColumns: `repeat(${columns}, 1fr)`,
        gap: gapPx,
        ...style,
      }}
      {...rest}
    >
      {children}
    </div>
  );
}
