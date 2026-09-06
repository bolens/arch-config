# Feature specification: Reviewed configuration capture

**Created**: 2026-09-05
**Status**: Implemented; local and hosted source validation passed
**Basis**: Retrospective audit of `f0ac95e9cf8b` with a corrective contract.

The existing repository retains host-specific boot, system, Fish, and package
configuration. Its capture helper currently stages all changes and pushes to
`main`. That behavior conflicts with the repository's reviewed PR delivery rule.
The following requirements describe the correction, not historical behavior.

## User scenarios and testing

### Preview captured state, then review a local update (P1)

An operator previews the configured source and destination before explicitly
updating a repository checkout. Publication happens through the delivery playbook.

1. Given disposable source trees and a clean checkout, running without `--apply`
   shows intended changes and leaves the destination and Git state unchanged.
2. Given explicit `--apply`, eligible configuration is copied, existing unrelated
   files remain, and no Git commit or push occurs.
3. Given private Fish configuration, history, variables, or symlinks to private
   content, capture does not copy their contents into the destination.
4. Given an invalid destination or a failing copy, capture exits nonzero and
   does not claim success or attempt publication.

## Requirements

- **FR-001**: Preview MUST be the default. Local writes require `--apply`.
- **FR-002**: Source roots and destination MUST be explicit in output and
  overridable for disposable verification. Destination MUST be a Git root.
- **FR-003**: Capture MUST preserve unrelated destination files, exclude private
  Fish configuration and runtime files, and preserve symlinks without dereferencing.
- **FR-004**: Capture MUST NOT start an SSH agent, add credentials, stage, commit,
  or push. Existing timers without `--apply` become previews until an operator
  deliberately changes their invocation.
- **FR-005**: Missing required input, invalid options, failed copy, or failed
  package inventory MUST return nonzero. Previously written capture files may
  remain after failure and MUST be reviewed before retrying.

## Success criteria

- **SC-001**: Disposable tests demonstrate each acceptance scenario without
  touching live configuration, services, SSH agents, or remote repositories.
- **SC-002**: All tracked Fish files pass individual syntax checks, and required
  PR checks pass before merge.

## Boundaries

This repository records one workstation's desired state. Capturing a file does
not establish bootability or approve applying it. Existing hardware tuning,
service definitions, and recovery history remain separate source baselines.
