function yy --wraps=yazi --description 'yazi file manager — cd to last dir on exit'
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file=$tmp
    if set -l cwd (cat -- $tmp 2>/dev/null); and test -n "$cwd"; and test "$cwd" != "$PWD"
        builtin cd -- $cwd
    end
    rm -f -- $tmp
end
