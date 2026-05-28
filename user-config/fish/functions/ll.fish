function ll --wraps='eza -l --color=always --group-directories-first --icons --git' --description 'alias ll=eza -l --color=always --group-directories-first --icons --git'
    eza -l --color=always --group-directories-first --icons --git $argv
end
