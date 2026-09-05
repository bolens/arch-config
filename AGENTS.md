# Agent guidance

Before Spec Kit planning or implementation, read
`.specify/memory/project-guide.md` with the project constitution. It maps
requirements to this repository's source, acceptance evidence, and validation.

Read `.specify/memory/constitution.md`. This repository describes one specific
Arch workstation; do not generalize its hardware tuning as portable defaults.

- Never apply boot, mount, pacman, kernel, systemd, udev, power, or sync changes
  to the live host without explicit authorization and rollback planning.
- Preserve unrelated synchronized state and never commit secrets or runtime
  databases. Validate syntax and referenced paths/units before handoff.

## Spec-driven changes

Use Spec Kit for new capabilities, architecture, security-sensitive behavior,
migrations, and coordinated multi-file changes. Keep narrow fixes, dependency
updates, prose edits, and release housekeeping in the normal repository
workflow unless their risk warrants a written specification. Keep completed
feature directories under `specs/` as decision history; do not backfill them for
finished work.
