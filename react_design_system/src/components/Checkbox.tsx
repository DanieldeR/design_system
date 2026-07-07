import React from "react";

export interface DSCheckboxProps {
  checked: boolean;
  onChange?: (checked: boolean) => void;
  label?: string;
  disabled?: boolean;
  className?: string;
}

/**
 * A checkbox with an inline label. Visual twin of the Flutter
 * `DSCheckbox`.
 */
export function DSCheckbox({
  checked,
  onChange,
  label,
  disabled,
  className,
}: DSCheckboxProps) {
  return (
    <button
      type="button"
      role="checkbox"
      aria-checked={checked}
      disabled={disabled}
      onClick={() => onChange?.(!checked)}
      className={[
        "ds-checkbox",
        checked ? "ds-checkbox--checked" : "",
        "ds-text-body-medium",
        className,
      ]
        .filter(Boolean)
        .join(" ")}
    >
      <span className="ds-checkbox__box">
        {checked && (
          <svg viewBox="0 0 16 16" fill="none" aria-hidden="true">
            <path
              d="M3.5 8.5L6.5 11.5L12.5 4.5"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
            />
          </svg>
        )}
      </span>
      {label}
    </button>
  );
}
