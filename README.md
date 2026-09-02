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

The sync is fully automated via a daily systemd timer:

* **Timer**: `config-backup.timer` (runs daily at midnight).
* **Service**: `config-backup.service` triggers the [sync.fish](file:///home/rsync-backup/gh-configs/sync.fish) script.
* **Logic**:
  1. Synchronizes configurations from host `/etc`, `/boot`, and `/home/panda/.config` into the repository.
  2. Updates `pkglist.txt` with current package listings.
  3. Automatically commits and pushes changes to GitHub.

### Git hooks

Run `bash scripts/install-git-hooks` once per clone. The pre-commit hook runs fast staged checks; pre-push runs the broader local CI gate.
