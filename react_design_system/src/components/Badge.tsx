import React from "react";

export type DSBadgeTone =
  | "neutral"
  | "brand"
  | "success"
  | "warning"
  | "danger"
  | "info";

export interface DSBadgeProps {
  label: string;
  /** @default "neutral" */
  tone?: DSBadgeTone;
  className?: string;
}

/**
 * A small status/label pill. Visual twin of the Flutter `DSBadge`.
 */
export function DSBadge({ label, tone = "neutral", className }: DSBadgeProps) {
  return (
    <span
      className={[
        "ds-badge",
        `ds-badge--${tone}`,
        "ds-text-caption",
        className,
      ]
        .filter(Boolean)
        .join(" ")}
    >
      {label}
    </span>
  );
}
