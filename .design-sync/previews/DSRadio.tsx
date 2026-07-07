import * as React from "react";
import { useState } from "react";
import { DSRadio, DSStack } from "design-system";

export function Group() {
  const [plan, setPlan] = useState("pro");
  return (
    <DSStack gap="sm">
      <DSRadio value="free" groupValue={plan} label="Free" onChange={setPlan} />
      <DSRadio value="pro" groupValue={plan} label="Pro" onChange={setPlan} />
      <DSRadio value="team" groupValue={plan} label="Team" onChange={setPlan} />
    </DSStack>
  );
}

export function Disabled() {
  return (
    <DSStack gap="sm">
      <DSRadio value="a" groupValue="a" label="Selected, disabled" disabled onChange={() => {}} />
      <DSRadio value="b" groupValue="a" label="Unselected, disabled" disabled onChange={() => {}} />
    </DSStack>
  );
}
