

# fnm environment setup (modernized)
# Ensures fnm binaries and multishells are in PATH and avoids duplicates
set -gx FNM_MULTISHELL_PATH "/run/user/1000/fnm_multishells/4051552_1774280531709"
set -gx FNM_VERSION_FILE_STRATEGY "local"
set -gx FNM_DIR "/home/panda/.local/share/fnm"
set -gx FNM_LOGLEVEL "info"
set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist"
set -gx FNM_COREPACK_ENABLED "false"
set -gx FNM_RESOLVE_ENGINES "true"
set -gx FNM_ARCH "x64"
fish_add_path -p --path $FNM_MULTISHELL_PATH/bin
fish_add_path -p --path $FNM_DIR
if test -d $FNM_DIR
  fnm env --shell fish | source
end
