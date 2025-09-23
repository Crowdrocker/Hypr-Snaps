#!/bin/bash
# WehttamSnaps Modular Hyprland Installer

set -e

echo "Installing dependencies..."
sudo pacman -Syu --noconfirm hyprland waybar rofi fuzzel autotiling dunst swww thunar xfce4-terminal starship pipewire pipewire-pulse pavucontrol qpwgraph neofetch htop btop gamemode corectrl gruvbox-gtk-theme papirus-icon-theme nwg-drawer sddm sugar-candy-gtk-theme zram-generator

echo "Copying config files..."
mkdir -p ~/.config/hypr/
cp -r configs/hyprland.conf ~/.config/hypr/
mkdir -p ~/.config/waybar/
cp -r configs/waybar/* ~/.config/waybar/
mkdir -p ~/.config/rofi/
cp -r configs/rofi/* ~/.config/rofi/
mkdir -p ~/.config/settings-app/
cp -r configs/settings-app/* ~/.config/settings-app/
mkdir -p ~/.config/game-launcher/
cp -r configs/game-launcher/* ~/.config/game-launcher/

echo "Setting up wallpapers..."
mkdir -p ~/Pictures/wallpapers
git clone https://github.com/Crowdrocker/Wallpaper-Bank.git ~/Pictures/wallpapers

echo "Setting up GTK themes and icons..."
git clone https://github.com/Crowdrocker/GTK-themes-icons.git ~/gtk-themes-icons

echo "Setting up audio routing scripts..."
cp -r scripts/audio-routing/* ~/bin/

echo "Setting up J.A.R.V.I.S. sound pack..."
cp -r assets/jarvis-sounds/* ~/jarvis-sounds/

echo "Setting up SDDM theme and GRUB styling..."
sudo cp -r assets/sddm-sugar-candy /usr/share/sddm/themes/
sudo cp assets/grub-theme.txt /etc/default/grub

echo "All done! Please reboot to activate all features."