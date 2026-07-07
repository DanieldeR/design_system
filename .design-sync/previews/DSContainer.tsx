import * as React from "react";
import { DSContainer, DSCard } from "design-system";

export function Default() {
  return (
    <div style={{ background: "var(--ds-color-background)", padding: "16px 0" }}>
      <DSContainer maxWidth={480}>
        <DSCard>
          <p className="ds-text-body-medium" style={{ margin: 0, color: "var(--ds-color-text-primary)" }}>
            Content is centered and capped at a max width, with consistent
            side padding — this is the design system's page/section
            container.
          </p>
        </DSCard>
      </DSContainer>
    </div>
  );
}
