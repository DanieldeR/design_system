import React from "react";

export interface DSRadioProps<T> {
  value: T;
  groupValue: T | undefined;
  onChange?: (value: T) => void;
  label?: string;
  disabled?: boolean;
  className?: string;
}

/**
 * A radio button with an inline label. Visual twin of the Flutter
 * `DSRadio<T>`. Group multiple `DSRadio`s by giving them the same
 * `groupValue` and distinct `value`s.
 */
export function DSRadio<T>({
  value,
  groupValue,
  onChange,
  label,
  disabled,
  className,
}: DSRadioProps<T>) {
  const selected = value === groupValue;

  return (
    <button
      type="button"
      role="radio"
      aria-checked={selected}
      disabled={disabled}
      onClick={() => onChange?.(value)}
      className={[
        "ds-radio",
        selected ? "ds-radio--selected" : "",
        "ds-text-body-medium",
        className,
      ]
        .filter(Boolean)
        .join(" ")}
    >
      <span className="ds-radio__circle">
        {selected && <span className="ds-radio__dot" />}
      </span>
      {label}
    </button>
  );
}
