# arch-config Spec Kit project guide

Reviewed desired state for one specific Arch workstation, including boot, system, and
user configuration.

Read this guide with `AGENTS.md` and `.specify/memory/constitution.md` before
specifying, planning, or implementing a substantial change. It is project-owned
guidance, not an upstream-managed template.

## Source and ownership map

- `boot/`
- `etc/`
- `user-config/`
- `pkglist.txt`
- `sync.fish`
- `README.md`

## Specification and plan decisions

State the exact subsystem and hardware assumption affected. Separate tracked desired
state, synchronized files, package inventory, and live host state. A boot, mount, power,
or package change needs an access-preserving rollback before any operational task.

## Acceptance evidence

Check referenced files and unit names, syntax, synchronization exclusions, and
preservation of unrelated configuration. Describe the expected failure and recovery
path. Do not claim generic workstation compatibility from this host-specific repository.

## Validation and operational limits

```sh
fish --no-execute sync.fish
actionlint
```

Choose subsystem-specific offline validation for changed files. Syntax checks do not
prove bootability or runtime behavior. Never run sync.fish, install packages, reload
services, or apply settings as part of documentation or static verification.

## Working through Spec Kit

Use Spec Kit for new capabilities, architectural or security-sensitive changes,
migrations, and coordinated changes that need a written contract. Keep narrow fixes,
dependency updates, and prose maintenance in the normal PR workflow.

For a new feature, record observable acceptance criteria in `spec.md`, source ownership
and constitution checks in `plan.md`, and evidence-bearing work in `tasks.md` under the
feature directory created by Spec Kit. Resolve material unknowns before implementation.
Mark tasks complete only after their stated verification, and distinguish completed,
skipped, blocked, and manual checks. Retain completed feature documents as decision
history; do not backfill feature specifications for already finished code.

Keep `.specify/templates/`, `.specify/scripts/`, and generated Codex skills under their
integration manifests. Use this guide and the constitution for local customization.
Regenerate managed files through Spec Kit and verify that project-owned memory survives
updates. Follow `RELEASING.md` for push, merge, release or delivery, and recovery.
