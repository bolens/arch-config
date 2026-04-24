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
