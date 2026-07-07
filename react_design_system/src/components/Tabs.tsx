import React from "react";

export interface DSTabItem {
  label: string;
  /** An icon element, e.g. an inline SVG or icon-font glyph. */
  icon?: React.ReactNode;
}

export interface DSTabsProps {
  tabs: DSTabItem[];
  selectedIndex: number;
  onChange: (index: number) => void;
  className?: string;
}

/**
 * A horizontal tab strip with an underline indicator. Visual twin of
 * the Flutter `DSTabs`. Fully controlled: pass `selectedIndex` and
 * react to `onChange`.
 */
export function DSTabs({
  tabs,
  selectedIndex,
  onChange,
  className,
}: DSTabsProps) {
  return (
    <div className={["ds-tabs", className].filter(Boolean).join(" ")} role="tablist">
      {tabs.map((tab, i) => (
        <button
          key={tab.label}
          type="button"
          role="tab"
          aria-selected={i === selectedIndex}
          className={[
            "ds-tab",
            i === selectedIndex ? "ds-tab--selected" : "",
            "ds-text-body-medium",
          ]
            .filter(Boolean)
            .join(" ")}
          onClick={() => onChange(i)}
        >
          {tab.icon}
          {tab.label}
        </button>
      ))}
    </div>
  );
}
