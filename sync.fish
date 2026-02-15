#!/usr/bin/fish

# 1. Configuration
set DEST (dirname (status --current-filename))
set TARGET_HOME "/home/panda"
set RSYNC_FLAGS -aL --quiet

echo "🚀 Syncing high-performance configurations..."

# 2. Sync Logic (Using sudo ONLY for system files)
echo "📦 Syncing system files (may prompt for password)..."
sudo rsync $RSYNC_FLAGS /etc/makepkg.conf /etc/pacman.conf /etc/fstab /etc/environment /etc/ccache.conf /etc/default/grub $DEST/etc/ 2>/dev/null

echo "⚙️  Syncing systemd and hardware tweaks..."
sudo rsync $RSYNC_FLAGS /etc/sysctl.d/99-performance.conf $DEST/etc/sysctl.d/
sudo rsync $RSYNC_FLAGS /etc/systemd/zram-generator.conf $DEST/etc/systemd/
sudo rsync $RSYNC_FLAGS /etc/systemd/system/tmp.mount.d/override.conf $DEST/etc/systemd/system/tmp.mount.d/ 2>/dev/null
sudo rsync $RSYNC_FLAGS /etc/security/limits.conf $DEST/etc/security/
sudo rsync $RSYNC_FLAGS /etc/udev/rules.d/*.rules $DEST/etc/udev/rules.d/ 2>/dev/null

echo "🐟 Syncing user configs..."
rsync $RSYNC_FLAGS $TARGET_HOME/.config/fish/config.fish $TARGET_HOME/.config/fish/fish_variables $DEST/user-config/fish/
rsync $RSYNC_FLAGS $TARGET_HOME/.config/fish/functions/ $DEST/user-config/fish/functions/
rsync $RSYNC_FLAGS $TARGET_HOME/.config/fish/completions/ $DEST/user-config/fish/completions/

if test -d $TARGET_HOME/.config/environment.d/
    rsync $RSYNC_FLAGS $TARGET_HOME/.config/environment.d/ $DEST/user-config/environment.d/
end

pacman -Qqe > $DEST/pkglist.txt

# 3. Automation (Git - Running as YOUR user)
echo "📂 Checking for changes in $DEST..."
cd $DEST

if test -n "$(git status --porcelain)"
    echo "📝 Changes detected. Automating commit and push..."
    
    # Check if SSH key is in the agent (uses YOUR user agent)
    if not ssh-add -l > /dev/null 2>&1
        ssh-add $TARGET_HOME/.ssh/bolens@duck
        ssh-add $TARGET_HOME/.ssh/michael@bolens
    end

    git add .
    set timestamp (date "+%Y-%m-%d %H:%M:%S")
    git commit -m "Auto-sync: $timestamp"
    
    echo "📤 Pushing to GitHub..."
    git push origin main
    
    echo "✅ Successfully updated GitHub!"
else
    echo "✅ No changes detected."
end
