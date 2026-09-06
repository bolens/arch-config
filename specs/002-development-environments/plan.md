# Plan

Own the development module, input lock, adapters, environment docs and CI.
Preserve boot/, etc/, user-config/, package inventory, and sync.fish behavior.
Keep fixture command lookup compatible with Nix and macOS while placing test
stubs first on PATH. Do not add the real Arch package manager to the environment.

Use existing Python capture tests, individual Fish syntax checks, source lint,
and workflow validation. Native Linux/macOS and Linux Docker checks remain
required for selected changes through an always-running result job. Follow the
protected delivery playbook; this repository has no product release tags.
