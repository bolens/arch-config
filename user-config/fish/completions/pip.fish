
# pip fish completion start
function __fish_complete_pip
    set -lx COMP_WORDS \
        (commandline --current-process --tokenize --cut-at-cursor) \
        (commandline --current-token --cut-at-cursor)
    set -lx COMP_CWORD (math (count $COMP_WORDS) - 1)
    set -lx PIP_AUTO_COMPLETE 1
    set -l completions
    if string match -q '2.*' $version
        set completions (eval $COMP_WORDS[1])
    else
        set completions ($COMP_WORDS[1])
    end
    string split \  -- $completions
end
complete -fa "(__fish_complete_pip)" -c /usr/bin/python3 -m pip
# pip fish completion end

