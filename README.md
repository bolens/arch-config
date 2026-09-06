# Arch Linux Configuration Sync (7900X3D Workstation)

This repository contains system-level and user-level configurations for a high-performance Ryzen 9 7900X3D workstation with 128GB RAM running Arch Linux.

## 📂 Repository Structure

- **`boot/`**: Bootloader settings.
  - `limine.conf`: Config for the Limine Bootloader.
- **`etc/`**: System-wide configuration files.
  - `ananicy.d/`: Real-time auto-nice daemon rules to optimize CPU scheduling for games and applications.
  - `makepkg.conf`: Optimized build settings for Zen 4 (`znver4`), utilizing a 100GB RAM build disk, and the high-speed `mold` linker.
  - `pacman.conf`: Arch package manager settings.
  - `fstab`: High-performance mount options for Btrfs, SSD tweaks, and a 100GB `tmpfs`.
  - `environment`: System-wide environment variables.
  - `sysctl.d/`: Kernel parameters configured for 128GB RAM (low swappiness, dirty page tuning, network & scheduler tweaks).
  - `systemd/`: System services, overrides, and timers (including backup and power safety automation).
  - `udev/rules.d/`: Hardware-specific rules (USB, network, etc.).
- **`user-config/`**: User-specific desktop and shell settings.
  - `fish/`: Complete Fish shell configurations, keybindings, aliases, prompt config (Tide), and plugins.
  - `environment.d/`: User session environment variables (Wayland, gaming, theme).
- **`pkglist.txt`**: Explicitly installed package manifest for system recovery.

---

## ⚡ Tuning Highlights

* **Zen 4 Compilation**: `makepkg.conf` uses `-march=znver4 -O3` and links via `mold` for ultra-fast package building.
* **Btrfs Storage**: Storage mounts utilize optimized writeback caching and compression.
* **128GB RAM Optimization**: Virtual memory parameters (`sysctl`) are tuned to avoid aggressive paging/swapping while maximizing write caching.
* **UPS-Aware Power Management**:
  - Automatically checks UPS state dynamically when suspend is requested.
  - Suspends the system **only** when the UPS is actively discharging (on battery) to save battery power during an outage.
  - Blocks/skips suspends on AC power (such as after the midnight sync) to allow overnight tasks (like `chkrootkit` and `libredefender` scans) to run uninterrupted.

---

## 🔄 Automation & Synchronization

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
