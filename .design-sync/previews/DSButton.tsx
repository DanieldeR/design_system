import * as React from "react";
import { DSButton, DSStack } from "design-system";

export function Variants() {
  return (
    <DSStack direction="horizontal" gap="sm" wrap>
      <DSButton label="Primary" variant="primary" onClick={() => {}} />
      <DSButton label="Secondary" variant="secondary" onClick={() => {}} />
      <DSButton label="Outline" variant="outline" onClick={() => {}} />
      <DSButton label="Ghost" variant="ghost" onClick={() => {}} />
      <DSButton label="Danger" variant="danger" onClick={() => {}} />
    </DSStack>
  );
}

export function Sizes() {
  return (
    <DSStack direction="horizontal" gap="sm" align="center" wrap>
      <DSButton label="Small" size="small" onClick={() => {}} />
      <DSButton label="Medium" size="medium" onClick={() => {}} />
      <DSButton label="Large" size="large" onClick={() => {}} />
    </DSStack>
  );
}

export function States() {
  return (
    <DSStack direction="horizontal" gap="sm" wrap>
      <DSButton label="Continue" onClick={() => {}} />
      <DSButton label="Loading" loading onClick={() => {}} />
      <DSButton label="Disabled" disabled />
    </DSStack>
  );
}

export function FullWidth() {
  return (
    <div style={{ maxWidth: 320 }}>
      <DSButton label="Create account" expand onClick={() => {}} />
    </div>
  );
}
