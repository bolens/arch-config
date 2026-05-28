# Show fastfetch as the Fish greeting
function fish_greeting
	fastfetch
end

# Ensure Go-installed CLIs (for example actionlint) are on PATH.
fish_add_path -p $HOME/go/bin
if type -q go
    set -l _gopath (go env GOPATH 2>/dev/null)
    if test -n "$_gopath"
        fish_add_path -p "$_gopath/bin"
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
