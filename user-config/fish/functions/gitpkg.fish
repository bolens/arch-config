function gitpkg --description 'Count installed -git AUR packages'
    pacman -Q | rg -i -- '-git' | wc -l
end
