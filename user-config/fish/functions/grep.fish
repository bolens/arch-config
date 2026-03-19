function grep --wraps='rg --color=auto --vimgrep' --wraps='rg --color=auto --hidden --no-ignore' --wraps='rg --color=auto --hidden --pcre2' --description 'alias grep=rg --color=auto --hidden --pcre2'
    rg --color=auto --hidden --pcre2 $argv
end
