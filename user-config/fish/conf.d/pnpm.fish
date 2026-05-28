# pnpm environment setup
# Ensures pnpm binaries are in PATH and avoids duplicates
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if test -d $PNPM_HOME
    fish_add_path -p --path $PNPM_HOME
end
