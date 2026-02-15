# Arch Linux Performance Configs (7900X3D + 128GB RAM)

- **makepkg.conf**: Tuned for Zen 4 (znver4), 100GB RAM build disk, and "mold" linker.
- **fstab**: Optimized BTRFS mount options and 100GB tmpfs.
- **sysctl**: Low swappiness and high-performance network/scheduler tweaks for 128GB RAM.
- **zram**: 32GB zstd compressed swap-in-RAM.
