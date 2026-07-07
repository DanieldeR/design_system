import * as React from "react";
import { DSTooltip, DSButton, DSStack } from "design-system";

// The bubble only shows on hover/focus; force it visible here purely for
// the static preview capture (no change to the shipped component).
const forceVisible = (
  <style>{`.ds-preview-force-tooltip .ds-tooltip__bubble { opacity: 1 !important; }`}</style>
);

export function Default() {
  return (
    <div className="ds-preview-force-tooltip" style={{ paddingTop: 24, paddingLeft: 48 }}>
      {forceVisible}
      <DSTooltip message="Saves your current draft">
        <DSButton label="Save draft" variant="outline" onClick={() => {}} />
      </DSTooltip>
    </div>
  );
}

export function OnIcon() {
  return (
    <div className="ds-preview-force-tooltip" style={{ paddingTop: 24, paddingLeft: 48 }}>
      {forceVisible}
      <DSStack direction="horizontal" gap="lg">
        <DSTooltip message="This field is required">
          <span
            className="ds-text-body-medium"
            style={{ color: "var(--ds-color-text-secondary)", cursor: "default" }}
          >
            Full name *
          </span>
        </DSTooltip>
      </DSStack>
    </div>
  );
}
