# Documentation

Capture and recovery documentation for the tracked Arch workstation.

## Start here

| Need | Owning document |
| --- | --- |
| Use the project | [README.md](../README.md) |
| Change the repository | [AGENTS.md](../AGENTS.md) |
| Deliver or recover | [RELEASING.md](../RELEASING.md) |
| Plan substantial changes | [.specify/memory/project-guide.md](../.specify/memory/project-guide.md) |
| Non-negotiable constraints | [.specify/memory/constitution.md](../.specify/memory/constitution.md) |

## Architecture

[sync.fish](../sync.fish) captures selected host files into this repository. It is not a
repository-to-host installer. Preview is the default, capture requires `--apply`, and the helper
never stages, commits, or pushes. Its source selection and exclusions are authoritative. Machine
tuning depends on this workstation and must not become generic defaults.

## Deployment and recovery

[Capture instructions](../README.md#capture-and-review) explain review and partial-failure handling.
[RELEASING.md](../RELEASING.md) owns repository delivery and recovery. Applying boot, mount, power,
or service changes needs a separate target-specific operation and a known-good recovery path.

## Database and state

Tracked configuration and package inventory are recovery inputs. Runtime databases, private Fish
state, and credentials are excluded from capture. Filename exclusions cannot detect secrets inside
an otherwise eligible configuration file, so the resulting diff still needs review.

## Documentation maintenance

Keep decisions, invariants, failure modes, and recovery requirements in the owning document. Link to
commands, defaults, schemas, and generated catalogs instead of copying them. Change the owner and
affected references together. Update this index when adding or moving a guide, and verify relative
links and heading anchors. Historical specs and audits describe their recorded revision, not current
runtime proof. A topic without an implementation stays explicitly unimplemented.
