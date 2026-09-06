# Arch Linux Configuration Sync (7900X3D Workstation)

This repository contains system-level and user-level configurations for a high-performance Ryzen 9 7900X3D workstation with 128GB RAM running Arch Linux.

## Scope

This is a recovery source for one workstation. Hardware, storage, memory, and
power assumptions are machine-specific. [Documentation](docs/README.md) explains
capture direction, state ownership, and recovery. Inspect the affected source
before reusing a setting on another host.

## Capture and review

[sync.fish](sync.fish) previews configuration capture by default. It requires
Fish, rsync, Git, and pacman. Source roots must exist and the destination must
be a Git repository root outside the captured source directories. Existing
`etc`, `boot`, and `user-config` capture roots must be real directories, not
symlinks. A symlink is rejected before any capture writes; review and deliberately
choose a suitable checkout instead of relying on links to live configuration.

```sh
fish sync.fish --user-config-root /path/to/user/.config --destination /path/to/checkout
fish sync.fish --apply --user-config-root /path/to/user/.config --destination /path/to/checkout
```

The default system source is `/`, the user source is the invoking user's
`$HOME/.config`, and the destination is the script directory. `--source-root`
selects a different system tree for offline fixtures. Review the printed roots
before applying, especially when a service account invokes the helper.

Capture preserves unrelated destination files. Private Fish files, history,
variables, and common credential/runtime filenames are excluded. Safe relative
symlinks are retained without copying their targets; external links are omitted.
Filename exclusions cannot identify every sensitive value inside a configuration
file. Review the complete resulting diff before staging it.

The helper never stages, commits, pushes, starts an SSH agent, or loads keys.
Use a feature branch and the [delivery playbook](RELEASING.md) after capture.
If a copy fails, review any partial local changes before retrying. Package
inventory failures are detected before copying, and `pkglist.txt` is replaced
only after successful capture. The fallback `/boot/limine/limine.conf` source
retains its nested path in the capture.

The tracked `config-backup.timer` and service still invoke the helper without
`--apply`, so they now preview. An operator must review and explicitly update
the installed invocation to enable local capture with the intended user root
and destination. Repository delivery does not change or restart that timer.

Verify capture with disposable fixtures:

```sh
python3 -m unittest discover -s tests -v
```

See the [capture specification](specs/001-reviewed-capture/spec.md) for acceptance
criteria and the retrospective audit that identified the direct-push conflict.

### Git hooks

Run `bash scripts/install-git-hooks` once per clone. The pre-commit hook runs fast staged checks; pre-push runs the broader local CI gate.

For isolated syntax and capture-fixture tooling, see
[development environments](docs/development-environments.md).
