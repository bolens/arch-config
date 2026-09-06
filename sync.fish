#!/usr/bin/fish

argparse -x apply,preview 'apply' 'preview' 'source-root=' 'user-config-root=' 'destination=' 'h/help' -- $argv
or exit 2
if set -q _flag_help
    echo 'Usage: fish sync.fish [--apply | --preview] [--source-root PATH] [--user-config-root PATH] [--destination PATH]'
    echo 'Default: preview only. --apply captures files locally; review and publish through a PR.'
    exit 0
end
if test (count $argv) -ne 0
    echo 'Unexpected positional arguments' >&2
    exit 2
end
set source_root /
set user_config_root "$HOME/.config"
set destination (path dirname (status filename))
set -q _flag_source_root; and set source_root $_flag_source_root
set -q _flag_user_config_root; and set user_config_root $_flag_user_config_root
set -q _flag_destination; and set destination $_flag_destination
for directory in "$source_root" "$user_config_root" "$destination"
    if not test -d "$directory"
        echo 'Source roots and destination must be existing directories' >&2
        exit 2
    end
end
set destination (path resolve "$destination")
set git_root (git -C "$destination" rev-parse --show-toplevel 2>/dev/null)
or exit 2
if test "$destination" != "$git_root"
    echo 'Destination must be the Git repository root' >&2
    exit 2
end
set source_root (path resolve "$source_root")
set user_config_root (path resolve "$user_config_root")
# Avoid copying a source tree into itself, including through a symlink.
for source in "$source_root/etc" "$source_root/boot" "$user_config_root"
    set resolved (path resolve "$source")
    if test "$destination" = "$resolved"; or string match -q -- "$resolved/*" "$destination"
        echo 'Destination must not be inside a captured source tree' >&2
        exit 2
    end
end
# Explicit rsync destination paths follow directory symlinks, unlike copied links.
# Reject capture roots before the first write, including dangling destinations.
for relative in etc boot user-config
    if test -L "$destination/$relative"
        echo "Capture destination must not be a symlink: $relative" >&2
        exit 2
    end
end
for dependency in rsync pacman
    if not command -q $dependency
        echo "Missing dependency: $dependency" >&2
        exit 2
    end
end
set flags -a --safe-links --itemize-changes
if not set -q _flag_apply
    set -a flags --dry-run
    echo 'Preview only. Use --apply to capture locally after reviewing the source selection.'
end
printf 'System source: %s\nUser config source: %s\nDestination: %s\n' "$source_root" "$user_config_root" "$destination"

# No deletion, link dereference, Git writes, network calls, or credential setup.
# Ignored source names are excluded before copying, not merely hidden from git add.
set excludes --exclude=private.fish --exclude=fish_variables\* --exclude=\*history\* --exclude=\*.log --exclude=\*.db\* --exclude=\*.sqlite\* --exclude=\*.sock --exclude=\*.pid --exclude=\*.key --exclude=\*.pem --exclude=\*.env --exclude=\*secret\* --exclude=\*credential\* --exclude=\*token\*
set sources etc/makepkg.conf etc/pacman.conf etc/fstab etc/environment etc/sysctl.d etc/systemd etc/security/limits.conf etc/udev/rules.d etc/ananicy.d
if test -f "$source_root/boot/limine.conf"
    set -a sources boot/limine.conf
else if test -f "$source_root/boot/limine/limine.conf"
    set -a sources boot/limine/limine.conf
else
    echo 'No Limine configuration found' >&2
    exit 1
end
# Check all required inputs before the first possible write.
for relative in $sources
    if not test -e "$source_root/$relative"
        echo "Missing required source: $relative" >&2
        exit 1
    end
end
if not test -d "$user_config_root/fish"
    echo 'Missing Fish source directory' >&2
    exit 1
end
set packages (pacman -Qqe)
or begin
    echo 'Package inventory failed; capture has not started' >&2
    exit 1
end
if test (count $packages) -eq 0
    echo 'Package inventory is empty; capture has not started' >&2
    exit 1
end
for relative in $sources
    rsync $flags $excludes --relative -- "$source_root/./$relative" "$destination/"
    or begin
        echo 'Capture failed; review any partial local changes before retrying' >&2
        exit 1
    end
end
# Keep the historical destination name when Limine uses a nested boot path.
# Nested paths are retained for explicit review instead of silently flattened.
for directory in fish environment.d
    if test -d "$user_config_root/$directory"
        if set -q _flag_apply
            mkdir -p -- "$destination/user-config"
            or exit 1
        end
        rsync $flags $excludes --relative -- "$user_config_root/./$directory" "$destination/user-config/"
        or begin
            echo 'Capture failed; review any partial local changes before retrying' >&2
            exit 1
        end
    end
end
if set -q _flag_apply
    set package_file (mktemp "$destination/.pkglist.XXXXXX")
    or exit 1
    printf '%s\n' $packages > "$package_file"
    and mv -- "$package_file" "$destination/pkglist.txt"
    or begin
        rm -f -- "$package_file"
        exit 1
    end
    echo 'Capture complete. Review the local diff, run checks, and publish through a feature PR.'
else
    echo 'Package inventory would update pkglist.txt. No local changes were made.'
end
