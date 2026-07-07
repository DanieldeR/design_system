import React from "react";

export interface DSCardProps extends React.HTMLAttributes<HTMLDivElement> {
  children: React.ReactNode;
  /** Adds a shadow. @default false */
  elevated?: boolean;
  /** Renders as a clickable button-like surface when provided. */
  onTap?: () => void;
}

/**
 * A surface container with the design system's elevation, radius, and
 * border treatment. Visual twin of the Flutter `DSCard`.
 */
export function DSCard({
  children,
  elevated = false,
  onTap,
  className,
  ...rest
}: DSCardProps) {
  const classes = [
    "ds-card",
    elevated ? "ds-card--elevated" : "",
    className,
  ]
    .filter(Boolean)
    .join(" ");

  if (onTap) {
    return (
      <button className={classes} onClick={onTap} type="button">
        {children}
      </button>
    );
  }

  return (
    <div className={classes} {...rest}>
      {children}
    </div>
  );
}
