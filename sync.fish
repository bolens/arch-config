#!/usr/bin/fish

# Define the backup directory as the location of this script
set DEST (dirname (status --current-filename))

echo "🚀 Starting configuration sync to $DEST..."

# 1. System Level Files
echo "📦 Copying /etc files..."
cp /etc/makepkg.conf $DEST/etc/
cp /etc/pacman.conf $DEST/etc/
cp /etc/fstab $DEST/etc/
cp /etc/environment $DEST/etc/
cp /etc/ccache.conf $DEST/etc/ 2>/dev/null
cp /etc/default/grub $DEST/etc/ 2>/dev/null

# 2. Systemd & Performance Tweaks
echo "⚙️  Copying systemd and performance tweaks..."
cp /etc/sysctl.d/99-performance.conf $DEST/etc/sysctl.d/ 2>/dev/null
cp /etc/systemd/zram-generator.conf $DEST/etc/systemd/ 2>/dev/null
cp /etc/systemd/system/tmp.mount.d/override.conf $DEST/etc/systemd/system/tmp.mount.d/ 2>/dev/null
cp /etc/security/limits.conf $DEST/etc/security/ 2>/dev/null
cp /etc/udev/rules.d/*.rules $DEST/etc/udev/rules.d/ 2>/dev/null

# 3. User Level Configs (Fish & Environment)
echo "🐟 Copying user configs (fish & environment.d)..."
cp -r ~/.config/fish/config.fish $DEST/user-config/fish/
cp -r ~/.config/fish/functions/ $DEST/user-config/fish/
cp -r ~/.config/fish/completions/ $DEST/user-config/fish/
cp ~/.config/fish/fish_variables $DEST/user-config/fish/
cp -r ~/.config/environment.d/* $DEST/user-config/environment.d/ 2>/dev/null

# 4. Update Package List
echo "📜 Updating package list..."
pacman -Qqe > $DEST/pkglist.txt

echo "✅ Sync complete!"
echo "Next steps: git add ., git commit, and git push."
