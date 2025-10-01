#!/bin/bash

# WehttamSnaps Gaming Optimizations

echo "Applying gaming optimizations..."

# Enable FSYNC
sudo bash -c 'echo "fsync=1" >> /etc/systemd/system.conf'

# Configure gamemode
sudo systemctl enable --now gamemoded

# Set up ZRAM
sudo bash -c 'cat > /etc/systemd/zram-generator.conf' << 'EOF'
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
