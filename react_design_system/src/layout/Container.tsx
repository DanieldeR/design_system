import React from "react";

export interface DSContainerProps extends React.HTMLAttributes<HTMLDivElement> {
  children: React.ReactNode;
  /** @default 1120 */
  maxWidth?: number;
}

/**
 * A centered, max-width, padded content wrapper — the design system's
 * page/section container. Visual twin of the Flutter `DSContainer`.
 */
export function DSContainer({
  children,
  maxWidth = 1120,
  style,
  ...rest
}: DSContainerProps) {
  return (
    <div style={{ padding: "0 24px", ...style }} {...rest}>
      <div style={{ maxWidth, margin: "0 auto" }}>{children}</div>
    </div>
  );
}
