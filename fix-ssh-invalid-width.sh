#!/usr/bin/env bash

set -e

FILE="/etc/profile.d/user-motd.sh"

echo "Checking Bazzite SSH MOTD configuration..."

if [[ ! -f "$FILE" ]]; then
    echo "Error: $FILE does not exist."
    exit 1
fi

if grep -q '\[ -z "\$SSH_CONNECTION" \]' "$FILE"; then
    echo "SSH MOTD fix is already applied."
    exit 0
fi

sudo cp "$FILE" "$FILE.bak"

sudo sed -i \
    's/if test ! -e "\$HOME"\/.config\/no-show-user-motd; then/if test ! -e "\$HOME"\/.config\/no-show-user-motd \&\& [ -z "\$SSH_CONNECTION" ]; then/' \
    "$FILE"

echo "SSH MOTD fix applied."
echo
echo "SSH sessions will now skip the Bazzite MOTD."
echo "Local terminal sessions will still display it."
echo
echo "Backup:"
echo "  $FILE.bak"
