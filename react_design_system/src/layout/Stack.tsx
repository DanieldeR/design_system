import React from "react";
import { DSSpacing, type DSSpacingToken } from "../tokens";

export interface DSStackProps extends React.HTMLAttributes<HTMLDivElement> {
  children: React.ReactNode;
  /** @default "vertical" */
  direction?: "vertical" | "horizontal";
  /** A spacing token, or a raw pixel number. @default "md" */
  gap?: DSSpacingToken | number;
  align?: React.CSSProperties["alignItems"];
  justify?: React.CSSProperties["justifyContent"];
  wrap?: boolean;
}

/**
 * A flex row/column that inserts consistent spacing between its
 * children. Visual twin of the Flutter `DSStack`.
 */
export function DSStack({
  children,
  direction = "vertical",
  gap = "md",
  align = "stretch",
  justify = "flex-start",
  wrap = false,
  style,
  ...rest
}: DSStackProps) {
  const gapPx = typeof gap === "number" ? gap : DSSpacing[gap];

  return (
    <div
      style={{
        display: "flex",
        flexDirection: direction === "vertical" ? "column" : "row",
        gap: gapPx,
        alignItems: align,
        justifyContent: justify,
        flexWrap: wrap ? "wrap" : "nowrap",
        ...style,
      }}
      {...rest}
    >
      {children}
    </div>
  );
}
