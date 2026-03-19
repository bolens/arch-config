function apt-get --wraps='man pacman' --wraps='tldr pacman' --description 'alias apt-get=tldr pacman'
    tldr pacman $argv
end
