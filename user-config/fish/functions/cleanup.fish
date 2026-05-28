function cleanup -d 'Remove orphaned packages (pacman)'
    set -l pkgs (pacman -Qtdq 2>/dev/null)
    if test -z "$pkgs"
        echo "No orphaned packages to remove."
        return 0
    end
    sudo pacman -Rns $pkgs
end
