function ccache-clear -d 'Clear the ccache directory'
    if not type -q ccache
        echo 'ccache is not installed' >&2
        return 1
    end
    read -l -P 'Clear ccache at '$CCACHE_DIR'? [y/N] ' confirm
    if test "$confirm" = y -o "$confirm" = Y
        ccache -C
        echo 'ccache cleared'
    else
        echo 'cancelled'
    end
end
