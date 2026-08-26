#!/usr/bin/env bash

set -e

SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_FILE="$SERVICE_DIR/syncthing.service"

mkdir -p "$SERVICE_DIR"

cat > "$SERVICE_FILE" <<'EOF'
[Unit]
Description=Syncthing
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/bin/flatpak run --command=syncthing com.github.zocker_160.SyncThingy serve --no-browser --home=/var/home/justin/.var/app/com.github.zocker_160.SyncThingy/.local/state/syncthing
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable --now syncthing

echo "Syncthing service installed and started."
systemctl --user --no-pager status syncthing
