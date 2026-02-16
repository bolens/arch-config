#!/usr/bin/fish

# 1. Configuration
set DEST "/home/rsync-backup/gh-configs"
set TARGET_HOME "/home/panda"
set RSYNC_FLAGS -aL --quiet

# 2. Universal SSH Agent Start
# This starts an agent and adds your key silently
if not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c) > /dev/null
end
ssh-add /home/rsync-backup/.ssh/bolens@duck 2>/dev/null

echo "🚀 Starting high-performance configuration sync..."

# 3. System Level Files
echo "📦 Syncing system files from /etc..."
rsync $RSYNC_FLAGS /etc/makepkg.conf /etc/pacman.conf /etc/fstab /etc/environment $DEST/etc/

# 4. Limine Bootloader (Handles the FAT32 umask=0022 fix)
echo "🛡️  Syncing Limine bootloader config..."
if test -f /boot/limine.conf
    rsync $RSYNC_FLAGS /boot/limine.conf $DEST/boot/
else if test -f /boot/limine/limine.conf
    rsync $RSYNC_FLAGS /boot/limine/limine.conf $DEST/boot/
else
    echo "⚠️  Limine config not found in /boot. Skipping."
end

# 5. Performance & Hardware
echo "⚙️  Syncing systemd, hardware rules, and performance tweaks..."
rsync $RSYNC_FLAGS /etc/sysctl.d/ $DEST/etc/sysctl.d/
rsync $RSYNC_FLAGS /etc/systemd/ $DEST/etc/systemd/
rsync $RSYNC_FLAGS /etc/security/limits.conf $DEST/etc/security/
rsync $RSYNC_FLAGS /etc/udev/rules.d/ $DEST/etc/udev/rules.d/
rsync $RSYNC_FLAGS /etc/ananicy.d/ $DEST/etc/ananicy.d/

# 6. User Configs
echo "🐟 Syncing Panda's user configs (Fish & Environment)..."
rsync $RSYNC_FLAGS $TARGET_HOME/.config/fish/ $DEST/user-config/fish/
if test -d $TARGET_HOME/.config/environment.d/
    rsync $RSYNC_FLAGS $TARGET_HOME/.config/environment.d/ $DEST/user-config/environment.d/
end

# 7. Package List
echo "📜 Updating package list..."
/usr/bin/pacman -Qqe > $DEST/pkglist.txt

# 8. Git Automation
echo "📂 Checking for changes in $DEST..."
cd $DEST

if test -n "$(git status --porcelain)"
    echo "📝 Changes detected. Automating verified commit..."
    
    # Ensure keys are in agent (Keychain usually handles this, but let's be sure)
    if not ssh-add -l | grep -q "bolens@duck"
        echo "🔑 Key not in agent. Manually loading bolens@duck..."
        ssh-add /home/rsync-backup/.ssh/bolens@duck
    end

    git add .
    set timestamp (date "+%Y-%m-%d %H:%M:%S")
    git commit -m "Auto-sync: $timestamp [7900X3D Workstation]"
    
    echo "📤 Pushing to GitHub..."
    if git push origin main
        echo "✅ Successfully updated GitHub with verified commit!"
    else
        echo "❌ Push failed. Check network or SSH keys."
    end
else
    echo "✅ No changes detected. Repository is already up to date."
end
