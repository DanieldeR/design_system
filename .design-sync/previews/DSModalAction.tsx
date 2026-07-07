import * as React from "react";
import { DSModalAction, DSStack } from "design-system";

export function Variants() {
  return (
    <DSStack direction="horizontal" gap="sm">
      <DSModalAction label="Cancel" variant="ghost" onClick={() => {}} />
      <DSModalAction label="Confirm" variant="primary" onClick={() => {}} />
      <DSModalAction label="Delete" variant="danger" onClick={() => {}} />
    </DSStack>
  );
}
