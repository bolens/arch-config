# Arch Workstation Configuration Constitution

[Documentation](../../docs/README.md)

## Core Principles

### I. Declarative Recovery Source

Tracked files MUST represent intentional, reproducible workstation state. Machine-generated synchronization MUST preserve reviewable diffs and MUST NOT turn transient runtime state into configuration.

### II. Hardware and Host Specificity Is Explicit

Optimizations tied to the Ryzen workstation, storage layout, memory size, GPU, UPS, or local mounts MUST be documented and MUST NOT be presented as portable defaults.

### III. System Safety Before Performance

Boot, mount, package-manager, kernel, power, systemd, and udev changes MUST preserve recoverability. Risky changes require validation, rollback instructions, and explicit operator action before application.

### IV. Secrets and Private State Stay Untracked

Credentials, keys, host-private values, runtime databases, and personal data MUST NOT enter version control or diagnostic output. Public examples use placeholders.

### V. Source Validation

Configuration syntax and referenced units/paths MUST be validated before handoff. Applying configuration to the live host is an operational action requiring explicit authorization.

## Governance

This constitution governs repository changes; the live host remains operator-controlled. Amendments require documented safety impact and a version update.

**Version**: 1.0.0 | **Ratified**: 2026-08-15 | **Last Amended**: 2026-08-15
