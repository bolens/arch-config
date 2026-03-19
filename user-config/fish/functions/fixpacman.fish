function fixpacman --wraps='sudo rm /var/lib/pacman/db.lck' --description 'alias fixpacman=sudo rm /var/lib/pacman/db.lck'
    sudo rm /var/lib/pacman/db.lck $argv
end
