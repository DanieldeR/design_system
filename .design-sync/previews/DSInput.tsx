import * as React from "react";
import { DSInput, DSStack } from "design-system";

export function Basic() {
  return (
    <div style={{ maxWidth: 320 }}>
      <DSInput label="Email" placeholder="you@example.com" />
    </div>
  );
}

export function WithHelperText() {
  return (
    <div style={{ maxWidth: 320 }}>
      <DSInput
        label="Username"
        placeholder="jane_doe"
        helperText="Letters, numbers, and underscores only."
      />
    </div>
  );
}

export function WithError() {
  return (
    <div style={{ maxWidth: 320 }}>
      <DSInput
        label="Email"
        placeholder="you@example.com"
        defaultValue="not-an-email"
        errorText="Enter a valid email address."
      />
    </div>
  );
}

export function Disabled() {
  return (
    <div style={{ maxWidth: 320 }}>
      <DSInput label="Account ID" defaultValue="acct_9f3d2a" disabled />
    </div>
  );
}

export function Stacked() {
  return (
    <DSStack gap="md" style={{ maxWidth: 320 }}>
      <DSInput label="First name" placeholder="Jane" />
      <DSInput label="Last name" placeholder="Doe" />
    </DSStack>
  );
}
