# Fix inherited environment pollution from /etc/environment and profile.d scripts
# that don't expand variables correctly or run multiple times.

# Fix LD_LIBRARY_PATH: /etc/environment sets it as the literal string
# "LD_LIBRARY_PATH=/usr/lib/mold:$LD_LIBRARY_PATH" — $LD_LIBRARY_PATH is NOT
# expanded in /etc/environment, so fish inherits a broken path list containing
# the literal string "$LD_LIBRARY_PATH" as an element. Override with the correct value.
set -gx LD_LIBRARY_PATH /usr/lib/mold

# Unset QML2_IMPORT_PATH: previously set globally by /etc/profile.d/meshroom.sh
# (now disabled). That script prepended /usr/lib/qt/qml (Qt5) to QML2_IMPORT_PATH,
# causing Qt6 apps (like plasma-discover) to load wrong QML modules and crash.
# Meshroom sets this itself via its wrapper script (/usr/bin/meshroom) when needed.
set -e QML2_IMPORT_PATH

# Deduplicate MESHROOM_*_PATH vars (profile.d sourced multiple times causes tripling)
if set -q MESHROOM_NODES_PATH
    set -gx MESHROOM_NODES_PATH /usr/share/meshroom
end
if set -q MESHROOM_PIPELINE_TEMPLATES_PATH
    set -gx MESHROOM_PIPELINE_TEMPLATES_PATH /usr/share/meshroom
end
