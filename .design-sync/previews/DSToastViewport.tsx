import * as React from "react";
import { useEffect } from "react";
import { DSToastViewport, showDSToast } from "design-system";

export function Success() {
  useEffect(() => {
    showDSToast({ message: "Saved successfully", tone: "success", duration: 60000 });
  }, []);
  return <DSToastViewport />;
}

export function Danger() {
  useEffect(() => {
    showDSToast({ message: "Failed to save changes", tone: "danger", duration: 60000 });
  }, []);
  return <DSToastViewport />;
}

export function Neutral() {
  useEffect(() => {
    showDSToast({ message: "Copied to clipboard", tone: "neutral", duration: 60000 });
  }, []);
  return <DSToastViewport />;
}
