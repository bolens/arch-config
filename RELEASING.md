# Delivery playbook

Arch Config is continuously delivered from protected `main`; it has no tags or
published artifacts. A squash merge records reviewed desired state. Applying
that state to a workstation is a separate, explicitly authorized operation.

## Prepare and validate

Branch from current `origin/main`. Document hardware-specific assumptions,
operator impact, and rollback for boot, mount, package, kernel, systemd, udev,
power, or synchronization changes. Never stage secrets or runtime databases.
Run the repository's pre-commit and pre-push hooks and the same syntax/path
checks named by CI. Review rendered configuration before any application.

## Review, deliver, and verify

Require a pull request, all checks, resolved conversations, and a squash merge;
never push directly to `main`. Verify the merged tree contains only intended
declarative state and CI passes on its SHA. Do not apply it to the live host as
part of repository delivery.

## Recover

Before application, correct or revert through another PR. For an authorized
live rollout, preserve the previous files and boot/access path first, apply the
smallest target, and verify its service or syntax. Restore the saved state on
failure; never make an untested broad rollback from this playbook.

Fleet policy: <https://github.com/bolens/.github/blob/main/RELEASING.md>.

## Fish syntax coverage

CI checks each tracked Fish file separately with `fish --no-execute`. When
reproducing locally, invoke Fish once per file: additional positional arguments
to a single invocation are script arguments and do not validate other files.
This syntax check does not load the live shell configuration.

Do not save `npm completion` (Bash/Zsh code) or Docker Compose help output as
`.fish` files. Use Fish's packaged completions or a generator that explicitly
supports Fish. Invalid local files can shadow the packaged completions.
