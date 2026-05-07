# Show fastfetch as the Fish greeting
function fish_greeting
	fastfetch
end

# OpenClaw Completion
source "/home/panda/.openclaw/completions/openclaw.fish"

# Ensure Go-installed CLIs (for example actionlint) are on PATH.
set -l _go_paths
set -a _go_paths "$HOME/go/bin"
if type -q go
    set -l _gopath (go env GOPATH 2>/dev/null)
    if test -n "$_gopath"
        set -a _go_paths "$_gopath/bin"
    end
end
for _go_bin in $_go_paths
    if test -d "$_go_bin"
        if not contains "$_go_bin" $fish_user_paths
            set -g fish_user_paths "$_go_bin" $fish_user_paths
        end
    end
end

# Keep vcpkg and Nix tools consistent in fish sessions.
set -gx VCPKG_ROOT "$HOME/.local/share/vcpkg"
set -gx VCPKG_DISABLE_METRICS "1"
set -gx NIX_CONFIG "experimental-features = nix-command flakes"

# Normalize locale in Fish sessions to a generated UTF-8 locale.
set -e -g LANGUAGE
set -e -g LC_ALL
for _locale_var in LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT LC_IDENTIFICATION
    set -e -g $_locale_var
end
set -gx LANG "en_US.UTF-8"

# Use micro for tools that honor EDITOR/VISUAL (e.g. sudoedit).
set -gx EDITOR "micro"
set -gx VISUAL "code-insiders --wait"
