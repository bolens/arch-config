#!/usr/bin/fish

# Define the backup directory as the location of this script
set DEST (dirname (status --current-filename))
set TARGET_HOME "/home/panda"

# Flags: 
# -a: archive mode (preserves permissions/times)
# -L: transform symlinks into referent files/dirs (crucial for Nix/Home-Manager files)
# -v: verbose
# --delete: remove files in destination if they were deleted from source (optional)
set RSYNC_FLAGS -aLv

echo "🚀 Starting high-performance configuration sync using rsync..."

# 1. System Level Files
echo "📦 Syncing /etc files..."
rsync $RSYNC_FLAGS /etc/makepkg.conf /etc/pacman.conf /etc/fstab /etc/environment /etc/ccache.conf /etc/default/grub $DEST/etc/ 2>/dev/null

# 2. Systemd & Performance Tweaks
echo "⚙️  Syncing systemd and performance tweaks..."
rsync $RSYNC_FLAGS /etc/sysctl.d/99-performance.conf $DEST/etc/sysctl.d/
rsync $RSYNC_FLAGS /etc/systemd/zram-generator.conf $DEST/etc/systemd/
rsync $RSYNC_FLAGS /etc/systemd/system/tmp.mount.d/override.conf $DEST/etc/systemd/system/tmp.mount.d/ 2>/dev/null
rsync $RSYNC_FLAGS /etc/security/limits.conf $DEST/etc/security/
rsync $RSYNC_FLAGS /etc/udev/rules.d/*.rules $DEST/etc/udev/rules.d/ 2>/dev/null

# 3. User Level Configs (Rsync handles trailing slashes to keep directory structure clean)
echo "🐟 Syncing user configs..."
rsync $RSYNC_FLAGS $TARGET_HOME/.config/fish/config.fish $TARGET_HOME/.config/fish/fish_variables $DEST/user-config/fish/
rsync $RSYNC_FLAGS $TARGET_HOME/.config/fish/functions/ $DEST/user-config/fish/functions/
rsync $RSYNC_FLAGS $TARGET_HOME/.config/fish/completions/ $DEST/user-config/fish/completions/

if test -d $TARGET_HOME/.config/environment.d/
    rsync $RSYNC_FLAGS $TARGET_HOME/.config/environment.d/ $DEST/user-config/environment.d/
end

# 4. Update Package List
echo "📜 Updating package list..."
pacman -Qqe > $DEST/pkglist.txt

echo "✅ Sync complete!"
