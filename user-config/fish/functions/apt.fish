function apt --wraps='man pacman' --wraps='tldr pacman' --description 'alias apt=tldr pacman'
    tldr pacman $argv
end
