# Agent guidance

Read `.specify/memory/constitution.md`. This repository describes one specific
Arch workstation; do not generalize its hardware tuning as portable defaults.

- Never apply boot, mount, pacman, kernel, systemd, udev, power, or sync changes
  to the live host without explicit authorization and rollback planning.
- Preserve unrelated synchronized state and never commit secrets or runtime
  databases. Validate syntax and referenced paths/units before handoff.
