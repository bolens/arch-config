# Development environments

Install [devenv](https://devenv.sh/getting-started/), then use `devenv shell`
and
`repo-check`, or run `devenv test` directly. Locked tools include Fish, Python,
Git, rsync, GNU utilities, and source/workflow validators. Capture tests use
disposable source trees and repositories with a stub package inventory command.
Fish syntax checks do not load configuration. The environment does not supply
pacman, capture live state, apply settings, or start services.

```sh
python3 scripts/development-container.py build podman
python3 scripts/development-container.py run podman -- bash scripts/check-development.sh
# Substitute docker for podman with a local Docker engine.
```

Images contain tools, with the checkout mounted only at runtime. The adapter
preserves caller UID/GID, Podman user mapping, argument boundaries, and command
exit status. Archives stay under ignored `.devenv/containers/`; nothing is
published. Checkout paths containing commas are rejected. Remote Docker daemons
require their own source transfer because local bind paths are not shared.

On a supported Apple Silicon Mac, substitute `apple` to invoke Apple's
`container` CLI. Building the Linux image on macOS requires a configured Linux
Nix builder. Native macOS tooling checks and actual Apple container execution
are distinct; neither proves this machine-specific Arch configuration boots or
works on another workstation. Apple execution is unverified from Linux.

CI runs selected Linux/macOS native and Docker checks with path filters, an
always-running result, and cancellation of superseded runs. Native Linux and
actual rootless Podman passed seven capture tests and five
adapter tests, individual Fish syntax checks, and source/workflow validation.
Hosted macOS and Docker checks remain pending. Follow [the delivery
playbook](../RELEASING.md) for protected merges.
Applying workstation state remains a separate operational action.
