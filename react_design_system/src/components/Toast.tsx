import React, { useEffect, useState } from "react";
import { createPortal } from "react-dom";

export type DSToastTone = "neutral" | "success" | "warning" | "danger";

export interface DSToastOptions {
  message: string;
  /** @default "neutral" */
  tone?: DSToastTone;
  /** @default 3000 */
  duration?: number;
}

interface DSToastEntry extends Required<DSToastOptions> {
  id: number;
}

type Listener = (entry: DSToastEntry) => void;
const listeners = new Set<Listener>();
let nextId = 0;

/**
 * Shows a transient status message. Visual twin of the Flutter
 * `DSToast.show`. Requires a `<DSToastViewport />` mounted once near
 * your app's root.
 */
export function showDSToast(options: DSToastOptions) {
  const entry: DSToastEntry = {
    message: options.message,
    tone: options.tone ?? "neutral",
    duration: options.duration ?? 3000,
    id: nextId++,
  };
  listeners.forEach((listen) => listen(entry));
}

/** Mounts the toast stack. Place once near your app's root. */
export function DSToastViewport() {
  const [toasts, setToasts] = useState<DSToastEntry[]>([]);

  useEffect(() => {
    const listen: Listener = (entry) => {
      setToasts((current) => [...current, entry]);
      window.setTimeout(() => {
        setToasts((current) => current.filter((t) => t.id !== entry.id));
      }, entry.duration);
    };
    listeners.add(listen);
    return () => {
      listeners.delete(listen);
    };
  }, []);

  return createPortal(
    <div className="ds-toast-viewport">
      {toasts.map((toast) => (
        <div
          key={toast.id}
          className={["ds-toast", `ds-toast--${toast.tone}`, "ds-text-body-medium"]
            .filter(Boolean)
            .join(" ")}
          role="status"
        >
          {toast.message}
        </div>
      ))}
    </div>,
    document.body,
  );
}
