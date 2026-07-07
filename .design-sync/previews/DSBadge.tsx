import * as React from "react";
import { DSBadge, DSStack } from "design-system";

export function Tones() {
  return (
    <DSStack direction="horizontal" gap="sm" wrap>
      <DSBadge label="Neutral" tone="neutral" />
      <DSBadge label="Brand" tone="brand" />
      <DSBadge label="Success" tone="success" />
      <DSBadge label="Warning" tone="warning" />
      <DSBadge label="Danger" tone="danger" />
      <DSBadge label="Info" tone="info" />
    </DSStack>
  );
}

export function StatusLabels() {
  return (
    <DSStack direction="horizontal" gap="sm" wrap>
      <DSBadge label="Active" tone="success" />
      <DSBadge label="Pending review" tone="warning" />
      <DSBadge label="Failed" tone="danger" />
      <DSBadge label="Draft" tone="neutral" />
    </DSStack>
  );
}
