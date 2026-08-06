function ll --wraps='eza -l --color=always --group-directories-first --icons=always --git' --description 'alias ll=eza -l --color=always --group-directories-first --icons=always --git'
    eza -l --color=always --group-directories-first --icons=always --git $argv
end
