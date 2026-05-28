function ls --wraps='eza --color=always --group-directories-first --icons' --description 'alias ls=eza'
    eza --color=always --group-directories-first --icons $argv
end
