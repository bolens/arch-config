function l. --description 'List dotfiles in directory'
    eza -a $argv | rg '^\.' 
end
