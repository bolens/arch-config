function pbuild --description 'Build AUR packages using system paths only, bypassing mise'
    set -lx PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
    paru $argv
end
