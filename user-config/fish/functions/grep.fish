function grep --wraps='rg --color=auto --hidden --pcre2' --description 'alias grep=rg'
    rg --color=auto --hidden --pcre2 $argv
end
