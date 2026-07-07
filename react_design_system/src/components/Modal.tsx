import React from "react";
import { createPortal } from "react-dom";
import { DSButton, type DSButtonVariant } from "./Button";

export interface DSModalProps {
  open: boolean;
  onClose: () => void;
  title: string;
  children: React.ReactNode;
  actions?: React.ReactNode;
}

/**
 * A centered modal dialog surface. Visual twin of the Flutter
 * `DSModal.show`. Controlled via `open`/`onClose`; renders into a
 * portal on `document.body`.
 */
export function DSModal({ open, onClose, title, children, actions }: DSModalProps) {
  if (!open) return null;

  return createPortal(
    <div
      className="ds-modal-overlay"
      onClick={onClose}
      role="presentation"
    >
      <div
        className="ds-modal"
        role="dialog"
        aria-modal="true"
        aria-label={title}
        onClick={(e) => e.stopPropagation()}
      >
        <h2 className="ds-text-heading-medium ds-modal__title">{title}</h2>
        <div className="ds-text-body-medium ds-modal__body">{children}</div>
        {actions && <div className="ds-modal__actions">{actions}</div>}
      </div>
    </div>,
    document.body,
  );
}

export interface DSModalActionProps {
  label: string;
  onClick: () => void;
  /** @default "primary" */
  variant?: DSButtonVariant;
}

/** Convenience: a `DSButton`-based dismiss action for `DSModal`'s `actions`. */
export function DSModalAction({
  label,
  onClick,
  variant = "primary",
}: DSModalActionProps) {
  return (
    <DSButton label={label} onClick={onClick} variant={variant} size="small" />
  );
}
