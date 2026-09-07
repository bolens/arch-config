# Agent guidance

[Documentation](docs/README.md) maps architecture, deployment, state, and document ownership.

Read [.specify/memory/constitution.md](.specify/memory/constitution.md). This repository describes one specific
Arch workstation; do not generalize its hardware tuning as portable defaults.

- Never apply boot, mount, pacman, kernel, systemd, udev, power, or sync changes
  to the live host without explicit authorization and rollback planning.
- Preserve unrelated synchronized state and never commit secrets or runtime
  databases. Validate syntax and referenced paths/units before handoff.

## Planning and evidence

Use the [project guide](.specify/memory/project-guide.md) and
[constitution](.specify/memory/constitution.md) for substantial changes. The guide
owns Spec Kit scope, retained history, retrospective requirements, and acceptance
evidence. Prose maintenance uses the normal repository workflow.

## Context and handoffs

- Search before reading. Use bounded source excerpts for exploratory reads over
  350 lines, and inspect required guidance and actual source before editing.
- When delegation is permitted, assign a bounded question or output, paths, and
  check. Return source locations, changes, and verification gaps for final review.
- Keep durable corrections in the [project guide](.specify/memory/project-guide.md)
  or owning contract. Replace superseded advice and read it before reuse.
  Temporary progress belongs in task notes. Preserve existing authority rules.
