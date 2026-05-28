function update -d 'Full system update (pacman + AUR via paru)'
    if command -q paru
        paru -Syu $argv
    else
        sudo pacman -Syu $argv
    end
end
