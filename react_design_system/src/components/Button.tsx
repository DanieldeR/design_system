import React from "react";

export type DSButtonVariant =
  | "primary"
  | "secondary"
  | "outline"
  | "ghost"
  | "danger";

export type DSButtonSize = "small" | "medium" | "large";

export interface DSButtonProps
  extends Omit<React.ButtonHTMLAttributes<HTMLButtonElement>, "size"> {
  label: string;
  /** @default "primary" */
  variant?: DSButtonVariant;
  /** @default "medium" */
  size?: DSButtonSize;
  /** Optional leading icon, rendered before the label. */
  icon?: React.ReactNode;
  /** Shows a spinner in place of the icon and disables interaction. */
  loading?: boolean;
  /** Stretches the button to fill its container's width. */
  expand?: boolean;
}

/**
 * A pressable button following the design system's visual language.
 * Visual twin of the Flutter `DSButton` — same variants, sizes, and
 * disabled/loading treatment.
 */
export function DSButton({
  label,
  variant = "primary",
  size = "medium",
  icon,
  loading = false,
  expand = false,
  disabled,
  className,
  ...rest
}: DSButtonProps) {
  const isDisabled = disabled || loading;

  return (
    <button
      className={[
        "ds-button",
        `ds-button--${variant}`,
        `ds-button--${size}`,
        expand ? "ds-button--expand" : "",
        className,
      ]
        .filter(Boolean)
        .join(" ")}
      disabled={isDisabled}
      {...rest}
    >
      {loading ? (
        <span className="ds-button__spinner" aria-hidden="true" />
      ) : (
        icon
      )}
      {label}
    </button>
  );
}
