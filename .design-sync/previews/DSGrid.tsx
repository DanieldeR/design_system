import * as React from "react";
import { DSGrid, DSCard } from "design-system";

function Tile({ title }: { title: string }) {
  return (
    <DSCard>
      <p className="ds-text-body-medium" style={{ margin: 0, color: "var(--ds-color-text-primary)" }}>
        {title}
      </p>
    </DSCard>
  );
}

export function TwoColumns() {
  return (
    <DSGrid columns={2} gap="md" style={{ maxWidth: 480 }}>
      <Tile title="Revenue" />
      <Tile title="Active users" />
    </DSGrid>
  );
}

export function ThreeColumns() {
  return (
    <DSGrid columns={3} gap="sm" style={{ maxWidth: 560 }}>
      <Tile title="Q1" />
      <Tile title="Q2" />
      <Tile title="Q3" />
    </DSGrid>
  );
}
