import * as React from "react";
import { useState } from "react";
import { DSCheckbox, DSStack } from "design-system";

export function Checked() {
  const [checked, setChecked] = useState(true);
  return <DSCheckbox checked={checked} label="Send me updates" onChange={setChecked} />;
}

export function Unchecked() {
  const [checked, setChecked] = useState(false);
  return <DSCheckbox checked={checked} label="Subscribe to newsletter" onChange={setChecked} />;
}

export function Disabled() {
  return <DSCheckbox checked disabled label="Required by your organization" />;
}

export function List() {
  const [prefs, setPrefs] = useState({ email: true, sms: false, push: true });
  return (
    <DSStack gap="sm">
      <DSCheckbox
        checked={prefs.email}
        label="Email notifications"
        onChange={(v) => setPrefs((p) => ({ ...p, email: v }))}
      />
      <DSCheckbox
        checked={prefs.sms}
        label="SMS notifications"
        onChange={(v) => setPrefs((p) => ({ ...p, sms: v }))}
      />
      <DSCheckbox
        checked={prefs.push}
        label="Push notifications"
        onChange={(v) => setPrefs((p) => ({ ...p, push: v }))}
      />
    </DSStack>
  );
}
