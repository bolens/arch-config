function fgrep --wraps='rg -F' --wraps='rg --color=auto -F' --description 'alias fgrep=rg --color=auto -F'
    rg --color=auto -F $argv
end
