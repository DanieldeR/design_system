import * as React from "react";
import { useState } from "react";
import { DSTabs } from "design-system";

export function Basic() {
  const [index, setIndex] = useState(0);
  return (
    <DSTabs
      tabs={[{ label: "Overview" }, { label: "Activity" }, { label: "Settings" }]}
      selectedIndex={index}
      onChange={setIndex}
    />
  );
}

export function SecondTabSelected() {
  const [index, setIndex] = useState(1);
  return (
    <DSTabs
      tabs={[{ label: "Overview" }, { label: "Activity" }, { label: "Settings" }]}
      selectedIndex={index}
      onChange={setIndex}
    />
  );
}

export function ManyTabs() {
  const [index, setIndex] = useState(0);
  return (
    <DSTabs
      tabs={[
        { label: "All" },
        { label: "Open" },
        { label: "In review" },
        { label: "Merged" },
        { label: "Closed" },
      ]}
      selectedIndex={index}
      onChange={setIndex}
    />
  );
}
