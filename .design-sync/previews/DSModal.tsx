import * as React from "react";
import { DSModal, DSModalAction } from "design-system";

export function ConfirmDialog() {
  return (
    <DSModal
      open
      onClose={() => {}}
      title="Confirm action"
      actions={
        <>
          <DSModalAction label="Cancel" variant="ghost" onClick={() => {}} />
          <DSModalAction label="Confirm" onClick={() => {}} />
        </>
      }
    >
      Are you sure you want to continue? This action can't be undone.
    </DSModal>
  );
}

export function DestructiveConfirm() {
  return (
    <DSModal
      open
      onClose={() => {}}
      title="Delete project"
      actions={
        <>
          <DSModalAction label="Cancel" variant="ghost" onClick={() => {}} />
          <DSModalAction label="Delete" variant="danger" onClick={() => {}} />
        </>
      }
    >
      Deleting "Q3 Roadmap" removes it for everyone on the team. This can't be undone.
    </DSModal>
  );
}
