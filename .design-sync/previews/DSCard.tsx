import * as React from "react";
import { DSCard, DSStack, DSBadge } from "design-system";

export function Flat() {
  return (
    <div style={{ maxWidth: 320 }}>
      <DSCard>
        <DSStack gap="xs">
          <h3 className="ds-text-heading-small" style={{ color: "var(--ds-color-text-primary)", margin: 0 }}>
            Flat card
          </h3>
          <p className="ds-text-body-medium" style={{ color: "var(--ds-color-text-secondary)", margin: 0 }}>
            Border only, no shadow.
          </p>
        </DSStack>
      </DSCard>
    </div>
  );
}

export function Elevated() {
  return (
    <div style={{ maxWidth: 320 }}>
      <DSCard elevated>
        <DSStack gap="xs">
          <h3 className="ds-text-heading-small" style={{ color: "var(--ds-color-text-primary)", margin: 0 }}>
            Elevated card
          </h3>
          <p className="ds-text-body-medium" style={{ color: "var(--ds-color-text-secondary)", margin: 0 }}>
            With a shadow, for surfaces that should visually float.
          </p>
        </DSStack>
      </DSCard>
    </div>
  );
}

export function Tappable() {
  return (
    <div style={{ maxWidth: 320 }}>
      <DSCard elevated onTap={() => {}}>
        <DSStack gap="sm">
          <DSStack direction="horizontal" justify="space-between" align="center">
            <h3 className="ds-text-heading-small" style={{ color: "var(--ds-color-text-primary)", margin: 0 }}>
              Q3 Roadmap
            </h3>
            <DSBadge label="Active" tone="success" />
          </DSStack>
          <p className="ds-text-body-medium" style={{ color: "var(--ds-color-text-secondary)", margin: 0 }}>
            Tap to open the full planning document.
          </p>
        </DSStack>
      </DSCard>
    </div>
  );
}
