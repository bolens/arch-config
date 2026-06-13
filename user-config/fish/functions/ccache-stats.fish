function ccache-stats -d 'Show ccache hit rate and cache size'
    if not type -q ccache
        echo 'ccache is not installed' >&2
        return 1
    end
    ccache -s
end
