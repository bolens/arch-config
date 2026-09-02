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
