# Arch configuration development environments

Provide locked Fish, Python, Git, rsync, and repository validation tools through
native devenv shells and local Docker, Podman, and Apple container adapters.
Validate every maintained Fish file separately without loading configuration.
Run capture tests only against disposable source trees and Git repositories,
including symlink-root rejection and private-state exclusions.

Never capture live workstation state, install configuration, invoke real pacman,
reload services, or change boot files. Native macOS tooling compatibility does
not make this workstation configuration portable or prove bootability. Source
must be mounted only at runtime; preserve caller ownership and command arguments.
Apple execution requires supported Mac hardware and a Linux Nix builder and must
remain unverified until executed there.
