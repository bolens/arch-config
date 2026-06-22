#!/bin/bash
# Monitor UPS state via upower and dynamically enable/disable suspend

# Function to get current UPS state
get_ups_state() {
    local ups_path
    ups_path=$(upower -e | grep ups | head -n 1)
    if [ -z "$ups_path" ]; then
        echo "unknown"
        return
    fi
    upower -i "$ups_path" | grep 'state:' | awk '{print $2}'
}

# Function to check if suspend is currently masked
is_suspend_masked() {
    local status
    status=$(systemctl is-enabled systemd-suspend.service 2>/dev/null)
    if [ "$status" = "masked" ]; then
        return 0
    else
        return 1
    fi
}

echo "Starting UPS Suspend Controller daemon..."

while true; do
    state=$(get_ups_state)
    
    if [ "$state" = "discharging" ]; then
        # UPS is on battery (power loss). Enable suspend.
        if is_suspend_masked; then
            echo "UPS state: discharging. Unmasking suspend services."
            systemctl unmask systemd-suspend.service systemd-hibernate.service systemd-hybrid-sleep.service systemd-suspend-then-hibernate.service
        fi
    else
        # UPS is on AC power (fully-charged, charging, etc. or unknown/not found). Disable suspend.
        if ! is_suspend_masked; then
            echo "UPS state: $state. Masking suspend services."
            systemctl mask systemd-suspend.service systemd-hibernate.service systemd-hybrid-sleep.service systemd-suspend-then-hibernate.service
        fi
    fi
    
    sleep 10
done
