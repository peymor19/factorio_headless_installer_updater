#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo."
    exit 1
fi

URL="https://factorio.com/get-download/stable/headless/linux64"
INSTALL_DIR="/opt"
SOFTWARE_NAME="factorio"
SOFTWARE_PATH="$INSTALL_DIR/$SOFTWARE_NAME"
SERVICE_PATH="/etc/systemd/system/$SOFTWARE_NAME.service"
MAP_FILE="map_1.zip"

if [ -d "$SOFTWARE_PATH" ]; then
    echo "Updating $SOFTWARE_NAME..."
    curl --progress-bar -L $URL | tar -xJf - -C $INSTALL_DIR
else
    echo "Installing $SOFTWARE_NAME..."

    mkdir -p "$INSTALL_DIR"

    curl --progress-bar -L $URL | tar -xJf - -C $INSTALL_DIR

    echo "Creating systemd service..."

    install -T -m 0644 /dev/stdin $SERVICE_PATH <<EOF
[Unit]
Description=$SOFTWARE_NAME Service
After=network.target

[Service]
Type=simple
ExecStart=$SOFTWARE_PATH/bin/x64/factorio --start-server $SOFTWARE_PATH/saves/$MAP_FILE --server-settings $SOFTWARE_PATH/data/server-settings.json --mod-directory $SOFTWARE_PATH/mods/
Restart=on-failure
User=root
WorkingDirectory=$SOFTWARE_PATH

[Install]
WantedBy=multi-user.target
Alias=factorio.service
EOF

systemctl daemon-reload

cat <<EOF
----------------------------------------------------------
Service unit created at: ${SERVICE_PATH}

To enable the service on startup:
  sudo systemctl enable ${SOFTWARE_NAME}

To start the service now:
  sudo systemctl start ${SOFTWARE_NAME}

To check the service status:
  systemctl status ${SOFTWARE_NAME}

To stop the service:
  sudo systemctl stop ${SOFTWARE_NAME}
----------------------------------------------------------
EOF
fi
