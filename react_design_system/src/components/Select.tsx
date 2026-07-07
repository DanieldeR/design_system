import React from "react";

export interface DSSelectOption<T extends string> {
  value: T;
  label: string;
}

export interface DSSelectProps<T extends string> {
  options: DSSelectOption<T>[];
  value?: T;
  onChange?: (value: T) => void;
  label?: string;
  placeholder?: string;
  disabled?: boolean;
  className?: string;
}

/**
 * A dropdown select field. Visual twin of the Flutter `DSSelect<T>`.
 * Constrained to `string`-valued options to map cleanly onto a native
 * `<select>` element.
 */
export function DSSelect<T extends string>({
  options,
  value,
  onChange,
  label,
  placeholder,
  disabled,
  className,
}: DSSelectProps<T>) {
  const selectId = React.useId();

  return (
    <div className={["ds-select-field", className].filter(Boolean).join(" ")}>
      {label && (
        <label className="ds-text-label ds-select-field__label" htmlFor={selectId}>
          {label}
        </label>
      )}
      <select
        id={selectId}
        className="ds-select-field__control"
        value={value ?? ""}
        disabled={disabled}
        onChange={(e) => onChange?.(e.target.value as T)}
      >
        {placeholder && (
          <option value="" disabled>
            {placeholder}
          </option>
        )}
        {options.map((option) => (
          <option key={option.value} value={option.value}>
            {option.label}
          </option>
        ))}
      </select>
    </div>
  );
}
