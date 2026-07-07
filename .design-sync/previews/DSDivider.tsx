import * as React from "react";
import { DSDivider, DSStack } from "design-system";

export function Horizontal() {
  return (
    <DSStack gap="sm" style={{ maxWidth: 320 }}>
      <span className="ds-text-body-medium" style={{ color: "var(--ds-color-text-primary)" }}>
        Section one
      </span>
      <DSDivider />
      <span className="ds-text-body-medium" style={{ color: "var(--ds-color-text-primary)" }}>
        Section two
      </span>
    </DSStack>
  );
}

export function Vertical() {
  return (
    <DSStack direction="horizontal" gap="md" style={{ height: 32 }}>
      <span className="ds-text-body-medium" style={{ color: "var(--ds-color-text-primary)" }}>
        Left
      </span>
      <DSDivider vertical />
      <span className="ds-text-body-medium" style={{ color: "var(--ds-color-text-primary)" }}>
        Right
      </span>
    </DSStack>
  );
}
