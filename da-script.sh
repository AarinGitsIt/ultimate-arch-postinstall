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

echo ">>> Installing programming languages & development tools..."
pacman -S --noconfirm \
    python python-pip python-virtualenv \   # Python (with venv support)
    r \                                     # R (standalone)
    rust \                                  # Rust (cargo included)
    go \                                    # Go (with go mod)
    jdk-openjdk gradle maven \              # Java
    nodejs npm \                            # JS/TS
    cmake make gcc clang gdb \              # C/C++
    arduino-cli \                           # Arduino
    qt6-base qt6-declarative qt6-svg \      # QML/Qt
    texlive-most                            # LaTeX

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
