function egrep --wraps=rg --wraps='rg --color=auto' --description 'alias egrep=rg --color=auto'
    rg --color=auto $argv
end
