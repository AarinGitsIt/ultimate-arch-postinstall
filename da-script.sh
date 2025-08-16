#!/bin/bash
set -e  # Exit if any command fails

echo ">>> Updating system..."
pacman -Syu --noconfirm

echo ">>> Installing essential packages..."
pacman -S --noconfirm \
    git base-devel sudo wget curl unzip zip tar htop \
    networkmanager bluez bluez-utils \
    pipewire pipewire-pulse pipewire-alsa wireplumber \
    xdg-user-dirs

echo ">>> Enabling essential services..."
systemctl enable NetworkManager
systemctl enable bluetooth

echo ">>> Installing Hyprland utilities (no base Hyprland/NVIDIA re-install)..."
pacman -S --noconfirm \
    waybar foot rofi wofi swaybg swaylock grim slurp wl-clipboard \
    brightnessctl playerctl pamixer

echo ">>> Installing all developer tools..."
pacman -S --noconfirm python python-pip python-virtualenv r rust go jdk-openjdk gradle maven nodejs npm cmake make gcc clang gdb arduino-cli qt6-base qt6-declarative qt6-svg octave

echo ">>> Installing yay (AUR helper)..."
cd /tmp
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm

echo ">>> Installing AUR packages..."
yay -S --noconfirm \
    zen-browser-bin discord visual-studio-code-bin \
    neovim

echo ">>> Setting up Neovim config..."
rm -rf ~/.config/nvim
git clone https://github.com/aarinjames/ultimate-nvim-config ~/.config/nvim

echo ">>> Updating xdg-user-dirs..."
xdg-user-dirs-update

echo ">>> Post-install complete! You can now reboot."
