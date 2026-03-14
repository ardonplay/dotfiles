#!/opt/homebrew/bin/bash

# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>true</swiftbar.hideSwiftBar>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
SUDO=/usr/bin/sudo
HELPER=/usr/local/bin/wg-toggle
TUNNELS=(wg-bremor wg-riga wg-home wg-moskow)

is_up() { [[ -f "/var/run/wireguard/${1}.name" ]]; }

# --- Статус ---
ACTIVE=0
for t in "${TUNNELS[@]}"; do
  is_up "$t" && ((ACTIVE++))
done

# --- Menu bar ---
if [[ $ACTIVE -eq 0 ]]; then
  echo "VPN ✗ | color=red"
else
  echo "VPN ✓ | color=green"
fi
echo "---"

# --- Туннели ---
for t in "${TUNNELS[@]}"; do
  if is_up "$t"; then
    echo "● $t | color=green bash=$SUDO param1=$HELPER param2=toggle param3=$t terminal=false refresh=true"
  else
    echo "○ $t | color=gray bash=$SUDO param1=$HELPER param2=toggle param3=$t terminal=false refresh=true"
  fi
done

echo "---"
echo "down-all | bash=$SUDO param1=$HELPER param2=down-all terminal=false refresh=true"
