source /usr/share/cachyos-fish-config/cachyos-config.fish

#ssh
if status is-interactive
    keychain --eval --quiet michael@bolens | source
    keychain --eval --quiet bolens@duck | source
end

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
mise activate fish | source
export SSH_AUTH_SOCK=$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock

# pnpm
set -gx PNPM_HOME "/home/panda/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# GPG Configuration for Fish
set -gx GPG_TTY (tty)
set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

# Launch GPG Agent if not running
gpgconf --launch gpg-agent
