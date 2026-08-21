#!/bin/bash

RULE="/etc/udev/rules.d/99-gpd-win5-ax210-aspm.rules"

sudo tee "$RULE" > /dev/null <<'EOF'
# Disable ASPM for Intel AX210 on GPD Win5
SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0x2725", DRIVER=="iwlwifi", PROGRAM=="/usr/bin/sh -c 'test $(cat /sys/class/dmi/id/product_name) = G1618-05'", RUN+="/usr/bin/setpci -s $kernel CAP_EXP+10.w=0x0040"
EOF

sudo udevadm control --reload-rules

echo "AX210 ASPM workaround installed."
echo "Reboot to apply it."
