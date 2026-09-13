import React, { useState } from "react";
import { createRoot } from "react-dom/client";
import "../src/styles/index.css";
import {
  DSTheme,
  DSBrightness,
  DSStack,
  DSGrid,
  DSContainer,
  DSDivider,
  DSButton,
  DSBadge,
  DSInput,
  DSSelect,
  DSCheckbox,
  DSRadio,
  DSCard,
  DSTabs,
  DSTooltip,
  DSModal,
  DSModalAction,
  showDSToast,
  DSToastViewport,
} from "../src/index";

function Section({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <DSStack gap="md">
      <h2 className="ds-text-heading-small" style={{ color: "var(--ds-color-text-primary)" }}>
        {title}
      </h2>
      {children}
    </DSStack>
  );
}

function Gallery() {
  const [brightness, setBrightness] = useState<DSBrightness>("light");
  const [tabIndex, setTabIndex] = useState(0);
  const [checked, setChecked] = useState(true);
  const [radioValue, setRadioValue] = useState("a");
  const [selectValue, setSelectValue] = useState("blue");
  const [modalOpen, setModalOpen] = useState(false);

  return (
    <DSTheme brightness={brightness} style={{ minHeight: "100vh" }}>
      <DSToastViewport />
      <div
        style={{
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
          padding: "16px 24px",
          background: "var(--ds-color-surface)",
          borderBottom: "1px solid var(--ds-color-border)",
        }}
      >
        <h1 className="ds-text-heading-medium" style={{ color: "var(--ds-color-text-primary)" }}>
          Design System Gallery
        </h1>
        <button
          onClick={() =>
            setBrightness(
              brightness === "light"
                ? "dark"
                : brightness === "dark"
                  ? "eink"
                  : "light",
            )
          }
          style={{
            border: "none",
            background: "none",
            cursor: "pointer",
            fontSize: 20,
            color: "var(--ds-color-text-primary)",
          }}
          aria-label={`Theme: ${brightness}. Click to cycle.`}
        >
          {brightness === "light" ? "☽" : brightness === "dark" ? "▤" : "☀"}
        </button>
      </div>

      <DSContainer maxWidth={720} style={{ paddingTop: 32, paddingBottom: 32 }}>
        <DSStack gap="xxl">
          <Section title="Buttons">
            <DSStack direction="horizontal" gap="sm" wrap>
              <DSButton label="Primary" onClick={() => {}} />
              <DSButton label="Secondary" variant="secondary" onClick={() => {}} />
              <DSButton label="Outline" variant="outline" onClick={() => {}} />
              <DSButton label="Ghost" variant="ghost" onClick={() => {}} />
              <DSButton label="Danger" variant="danger" onClick={() => {}} />
              <DSButton label="Disabled" disabled />
            </DSStack>
          </Section>

          <Section title="Badges">
            <DSStack direction="horizontal" gap="sm" wrap>
              <DSBadge label="Neutral" />
              <DSBadge label="Brand" tone="brand" />
              <DSBadge label="Success" tone="success" />
              <DSBadge label="Warning" tone="warning" />
              <DSBadge label="Danger" tone="danger" />
              <DSBadge label="Info" tone="info" />
            </DSStack>
          </Section>

          <Section title="Inputs">
            <DSGrid columns={2}>
              <DSInput label="Email" placeholder="you@example.com" />
              <DSSelect
                label="Favorite color"
                value={selectValue}
                onChange={setSelectValue}
                options={[
                  { value: "blue", label: "Blue" },
                  { value: "green", label: "Green" },
                  { value: "red", label: "Red" },
                ]}
              />
            </DSGrid>
          </Section>

          <Section title="Selection controls">
            <DSStack gap="sm">
              <DSCheckbox checked={checked} label="Send me updates" onChange={setChecked} />
              <DSRadio value="a" groupValue={radioValue} label="Option A" onChange={setRadioValue} />
              <DSRadio value="b" groupValue={radioValue} label="Option B" onChange={setRadioValue} />
            </DSStack>
          </Section>

          <Section title="Cards">
            <DSGrid columns={2}>
              <DSCard elevated onTap={() => {}}>
                <DSStack gap="xs">
                  <h3 className="ds-text-heading-small" style={{ color: "var(--ds-color-text-primary)" }}>
                    Elevated card
                  </h3>
                  <p className="ds-text-body-medium" style={{ color: "var(--ds-color-text-secondary)" }}>
                    With a shadow and tappable surface.
                  </p>
                </DSStack>
              </DSCard>
              <DSCard>
                <DSStack gap="xs">
                  <h3 className="ds-text-heading-small" style={{ color: "var(--ds-color-text-primary)" }}>
                    Flat card
                  </h3>
                  <p className="ds-text-body-medium" style={{ color: "var(--ds-color-text-secondary)" }}>
                    Border only, no shadow.
                  </p>
                </DSStack>
              </DSCard>
            </DSGrid>
          </Section>

          <Section title="Tabs">
            <DSTabs
              tabs={[{ label: "Overview" }, { label: "Activity" }, { label: "Settings" }]}
              selectedIndex={tabIndex}
              onChange={setTabIndex}
            />
          </Section>

          <Section title="Divider">
            <DSDivider />
          </Section>

          <Section title="Tooltip, modal & toast">
            <DSStack direction="horizontal" gap="md" wrap>
              <DSTooltip message="This is a tooltip">
                <DSButton label="Hover me" variant="outline" onClick={() => {}} />
              </DSTooltip>
              <DSButton label="Open modal" variant="secondary" onClick={() => setModalOpen(true)} />
              <DSButton
                label="Show toast"
                variant="ghost"
                onClick={() => showDSToast({ message: "Saved successfully", tone: "success" })}
              />
            </DSStack>
          </Section>
        </DSStack>
      </DSContainer>

      <DSModal
        open={modalOpen}
        onClose={() => setModalOpen(false)}
        title="Confirm action"
        actions={
          <>
            <DSModalAction label="Cancel" variant="ghost" onClick={() => setModalOpen(false)} />
            <DSModalAction label="Confirm" onClick={() => setModalOpen(false)} />
          </>
        }
      >
        Are you sure you want to continue?
      </DSModal>
    </DSTheme>
  );
}

createRoot(document.getElementById("root")!).render(<Gallery />);
