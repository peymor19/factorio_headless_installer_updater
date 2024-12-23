# Factorio Headless Server Installation/Update Script

This script automates the **installation** and **updating** of a Factorio **headless server** on a Linux system. It also sets up a **systemd** service, making it straightforward to manage Factorio as a service (start, stop, enable at boot, etc.).

## Prerequisites

- **Root / sudo privileges**: The script must be run as root or via `sudo`, otherwise it will exit.
- **Curl**: Used to download the Factorio headless server tarball.
- **tar**: Used to extract the downloaded tarball (with `-xJf` for `.tar.xz` archives).
     
## How to Install

1. **Clone the repository from GitHub**  
   ```bash
   git clone https://github.com/peymor19/factorio_headless_installer_updater.git
   ```

2. **Navigate into the cloned repository**  
   ```bash
   cd factorio_headless_installer_updater
   ```

3. **Make the script executable**  
   ```bash
   chmod +x factorio_headless_installer.sh
   ```
   
4. **Run the script with sudo**  
   ```bash
   sudo ./factorio_headless_installer.sh
   ```

   - The script will check if Factorio is already installed.
   - If Factorio is not installed, it will download and set it up.
   - If Factorio is installed, it will update to the latest version.
   - A systemd service (`factorio.service`) will be created in `/etc/systemd/system/` to manage the server.

## Optional: Move the Script for Easier Access

If you want to run the script from anywhere without navigating into the cloned folder each time:

1. **Move the script to `/usr/local/bin`**  
   ```bash
   sudo mv factorio_headless_installer.sh /usr/local/bin/factorio-update
   ```
2. **Run from anywhere**  
   ```bash
   sudo factorio-update
   ```
   
### Post-Installatio

- **Enable Factorio to run on startup**:
  ```bash
  sudo systemctl enable factorio
  ```
- **Start the Factorio server**:
  ```bash
  sudo systemctl start factorio
  ```
- **Check the Factorio service status**:
  ```bash
  systemctl status factorio
  ```
- **Stop the Factorio server**:
  ```bash
  sudo systemctl stop factorio
  ```

## Customizing the Script

- **INSTALL_DIR**: By default, `/opt` is used as the installation directory. You can modify this by editing:
  ```bash
  INSTALL_DIR="/opt"
  ```
- **SERVICE_PATH**: The systemd unit file is installed to:
  ```bash
  SERVICE_PATH="/etc/systemd/system/factorio.service"
  ```
- **MAP_FILE**: If you have a custom map name, you can modify:
  ```bash
  MAP_FILE="map_1.zip"
  ```
  Make sure to place your custom map zip in `/opt/factorio/saves`.

- **URL**: By default, it pulls the latest stable Factorio headless server from:
  ```bash
  URL="https://factorio.com/get-download/stable/headless/linux64"
  ```
  If you need a different version or distribution, adjust this URL.

## Contributing

Feel free to open an issue or submit a pull request if you find a bug or want to add enhancements to the script.
