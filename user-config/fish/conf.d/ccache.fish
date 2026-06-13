# ccache — speeds up repeated C/C++ compiles (makepkg, cmake, meson, Rust C deps).
if not type -q ccache
    exit
end

set -gx CCACHE_DIR "$HOME/.cache/ccache"
set -gx CCACHE_MAXSIZE 20G
set -gx CCACHE_COMPRESS true
set -gx CCACHE_COMPRESSLEVEL 6
set -gx CCACHE_BASEDIR "$HOME"
# Safe sloppiness for local dev rebuilds (not for release/package builds).
set -gx CCACHE_SLOPPINESS file_macro,time_macros,include_file_mtime,include_file_ctime
set -gx CCACHE_HARDLINK true

# Prefer ccache-wrapped compilers unless a tool already set CC/CXX (cross-compile, etc.).
if not set -q CC
    set -gx CC "ccache gcc"
end
if not set -q CXX
    set -gx CXX "ccache g++"
end

# Optional clang path when using CC=clang in a project.
function ccache-clang -d 'Run a command with ccache-wrapped clang/clang++'
    set -lx CC ccache clang
    set -lx CXX ccache clang++
    command $argv
end
