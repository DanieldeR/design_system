import * as React from "react";
import { useState } from "react";
import { DSSelect } from "design-system";

export function Basic() {
  const [value, setValue] = useState("blue");
  return (
    <div style={{ maxWidth: 280 }}>
      <DSSelect
        label="Favorite color"
        value={value}
        onChange={setValue}
        options={[
          { value: "blue", label: "Blue" },
          { value: "green", label: "Green" },
          { value: "red", label: "Red" },
        ]}
      />
    </div>
  );
}

export function WithPlaceholder() {
  const [value, setValue] = useState<string | undefined>(undefined);
  return (
    <div style={{ maxWidth: 280 }}>
      <DSSelect
        label="Country"
        value={value}
        placeholder="Select a country"
        onChange={setValue}
        options={[
          { value: "us", label: "United States" },
          { value: "ca", label: "Canada" },
          { value: "mx", label: "Mexico" },
        ]}
      />
    </div>
  );
}

export function Disabled() {
  return (
    <div style={{ maxWidth: 280 }}>
      <DSSelect
        label="Plan"
        value="pro"
        disabled
        onChange={() => {}}
        options={[{ value: "pro", label: "Pro" }]}
      />
    </div>
  );
}
