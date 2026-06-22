#!/bin/bash
# Check if the UPS is on battery (discharging)
# Exit 0 if discharging, exit 1 otherwise

# Find the UPS path
ups_path=$(/usr/bin/upower -e | /usr/bin/grep ups | /usr/bin/head -n 1)

# If no UPS is found, exit 1 (do not suspend)
if [ -z "$ups_path" ]; then
    exit 1
fi

# Get the state
state=$(/usr/bin/upower -i "$ups_path" | /usr/bin/grep 'state:' | /usr/bin/awk '{print $2}')

# If discharging, exit 0 (allow suspend)
if [ "$state" = "discharging" ]; then
    exit 0
fi

# Otherwise exit 1 (block suspend)
exit 1
