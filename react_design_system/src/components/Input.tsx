import React from "react";

export interface DSInputProps
  extends Omit<React.InputHTMLAttributes<HTMLInputElement>, "prefix"> {
  label?: string;
  placeholder?: string;
  helperText?: string;
  errorText?: string;
  /** Rendered before the text, e.g. an icon. */
  prefix?: React.ReactNode;
}

/**
 * A single-line text input following the design system's visual
 * language. Visual twin of the Flutter `DSInput`.
 */
export function DSInput({
  label,
  helperText,
  errorText,
  prefix,
  disabled,
  className,
  id,
  ...rest
}: DSInputProps) {
  const hasError = Boolean(errorText);
  const inputId = id ?? React.useId();

  return (
    <div
      className={[
        "ds-input-field",
        hasError ? "ds-input-field--error" : "",
        disabled ? "ds-input-field--disabled" : "",
        className,
      ]
        .filter(Boolean)
        .join(" ")}
    >
      {label && (
        <label className="ds-text-label ds-input-field__label" htmlFor={inputId}>
          {label}
        </label>
      )}
      <div className="ds-input-field__control">
        {prefix && <span className="ds-input-field__prefix">{prefix}</span>}
        <input
          id={inputId}
          className="ds-input-field__input"
          disabled={disabled}
          {...rest}
        />
      </div>
      {(hasError || helperText) && (
        <span className="ds-text-body-small ds-input-field__helper">
          {hasError ? errorText : helperText}
        </span>
      )}
    </div>
  );
}
