import * as React from "react";
import { DSStack, DSBadge } from "design-system";

function Swatch({ label }: { label: string }) {
  return (
    <div
      style={{
        padding: "8px 12px",
        background: "var(--ds-color-surface-variant)",
        borderRadius: "var(--ds-radius-sm)",
        color: "var(--ds-color-text-primary)",
      }}
      className="ds-text-body-small"
    >
      {label}
    </div>
  );
}

export function Vertical() {
  return (
    <DSStack direction="vertical" gap="sm">
      <Swatch label="Item one" />
      <Swatch label="Item two" />
      <Swatch label="Item three" />
    </DSStack>
  );
}

export function Horizontal() {
  return (
    <DSStack direction="horizontal" gap="sm">
      <Swatch label="Item one" />
      <Swatch label="Item two" />
      <Swatch label="Item three" />
    </DSStack>
  );
}

export function WrappingTags() {
  return (
    <DSStack direction="horizontal" gap="xs" wrap style={{ maxWidth: 280 }}>
      <DSBadge label="Design" tone="brand" />
      <DSBadge label="Engineering" tone="info" />
      <DSBadge label="Product" tone="success" />
      <DSBadge label="Marketing" tone="warning" />
      <DSBadge label="Sales" tone="neutral" />
    </DSStack>
  );
}
