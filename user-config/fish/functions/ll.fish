function ll --wraps='eza -l --color=always --group-directories-first --icons' --description 'alias ll=eza -l --color=always --group-directories-first --icons'
    eza -l --color=always --group-directories-first --icons $argv
end
