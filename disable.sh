#!/usr/bin/env bash

set -e

SERVICE_FILE="$HOME/.config/systemd/user/syncthing.service"

systemctl --user disable --now syncthing 2>/dev/null || true

rm -f "$SERVICE_FILE"

systemctl --user daemon-reload

echo "Syncthing service removed."
