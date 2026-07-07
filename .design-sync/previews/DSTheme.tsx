import * as React from "react";
import { DSTheme, DSCard, DSButton, DSStack } from "design-system";

function Panel() {
  return (
    <DSCard>
      <DSStack gap="sm">
        <p className="ds-text-heading-small" style={{ margin: 0, color: "var(--ds-color-text-primary)" }}>
          Themed panel
        </p>
        <p className="ds-text-body-medium" style={{ margin: 0, color: "var(--ds-color-text-secondary)" }}>
          Colors resolve from the nearest DSTheme ancestor.
        </p>
        <DSButton label="Action" onClick={() => {}} />
      </DSStack>
    </DSCard>
  );
}

export function Light() {
  return (
    <DSTheme brightness="light" style={{ padding: 16, background: "var(--ds-color-background)" }}>
      <Panel />
    </DSTheme>
  );
}

export function Dark() {
  return (
    <DSTheme brightness="dark" style={{ padding: 16, background: "var(--ds-color-background)" }}>
      <Panel />
    </DSTheme>
  );
}
