# pnpm environment setup (modernized)
# Ensures pnpm binaries are in PATH and avoids duplicates
set -gx PNPM_HOME "/home/panda/.local/share/pnpm"
fish_add_path -p --path $PNPM_HOME
