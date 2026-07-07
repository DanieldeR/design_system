import React from "react";

export interface DSTooltipProps {
  message: string;
  children: React.ReactNode;
  className?: string;
}

/**
 * A hover/focus tooltip. Visual twin of the Flutter `DSTooltip`.
 */
export function DSTooltip({ message, children, className }: DSTooltipProps) {
  return (
    <span className={["ds-tooltip", className].filter(Boolean).join(" ")}>
      {children}
      <span className="ds-tooltip__bubble ds-text-body-small" role="tooltip">
        {message}
      </span>
    </span>
  );
}
