function ls --wraps='eza --color=always --group-directories-first --icons=always' --description 'alias ls=eza'
    eza --color=always --group-directories-first --icons=always $argv
end
