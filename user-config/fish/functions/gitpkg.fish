function gitpkg --wraps='pacman -Q | grep -i "\\-git" | wc -l' --description 'alias gitpkg=pacman -Q | grep -i "\\-git" | wc -l'
    pacman -Q | grep -i "\-git" | wc -l $argv
end
