# Plan: Reviewed configuration capture

Use the existing Fish entry point and rsync with preview mode. Expose source
roots for fixture tests. Preserve links rather than copying their targets.
Remove credential setup and all Git writes. Keep package inventory publication
conditional on a successful command. Explain partial capture recovery in README.

## Ownership and constitution check

- `sync.fish` owns capture and argument validation.
- `tests/test_sync.py` owns isolated behavior checks.
- `README.md` owns operator invocation and timer migration instructions.
- `.gitignore` excludes private Fish files in addition to existing runtime rules.

This corrects the constitution's reviewability and private-state requirements.
No live host configuration or timer is applied. The full captured diff still
requires human review for host-specific sensitive values.

## Validation

Run `python3 -m unittest discover -s tests -v`, `fish --no-execute sync.fish`,
and the existing `.githooks/pre-push` gate. Tests use disposable source and
destination trees and a fixture package command. Check the final PR independently
and follow `RELEASING.md` through its squash merge and main checks.
