# Woodpecker Linux validation

## Requirement

Run the existing locked devenv test for pull requests, main pushes and manual
validation in unprivileged, immutable Linux containers on the shared CI site.
Do not apply workstation configuration or alter reusable workflow interfaces.

## Acceptance

- Clone the tested source completely using an immutable plugin.
- Run the existing native development gate with its committed lock.
- Expose no publication secrets, host socket, host store, or privileged mode.
- Keep existing GitHub checks until genuine native PR and main success.
- Preserve macOS, actual Docker, administrative and distinct lint coverage.
- Record exact revisions and results in the PR; recover by corrective PR.
