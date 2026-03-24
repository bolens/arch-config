# GPG agent and SSH_AUTH_SOCK setup
set -gx GPG_TTY (tty)
set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
# set -gx SSH_AUTH_SOCK $HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock

gpgconf --launch gpg-agent
