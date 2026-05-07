#!/bin/bash

# Ensure script is run from the dotfiles directory
if [ ! -d ".config" ]; then
    echo "❌ Error: Please run this script from the root of the arch-dots directory!"
    exit 1
fi

echo "🚀 Starting Arch Linux Dotfiles Installation..."

# 1. Update system and install yay if not present
echo "📦 Installing yay (if missing)..."
if ! command -v yay &> /dev/null; then
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd -
fi

# 2. Install official packages
echo "📦 Installing Official Pacman Packages..."
sudo pacman -S --needed --noconfirm hyprland hyprlock xorg-xwayland python-pywal waybar \
  pavucontrol playerctl power-profiles-daemon network-manager-applet pipewire \
  pipewire-pulse pipewire-alsa wireplumber brightnessctl wl-clipboard dolphin kitty \
  zsh starship fzf zsh-autosuggestions zsh-syntax-highlighting fastfetch \
  ttf-jetbrains-mono-nerd

# 3. Install AUR packages
echo "📦 Installing AUR Packages..."
yay -S --needed --noconfirm swww swaync cava cliphist rofi-wayland hyprshot \
  zsh-fast-syntax-highlighting iwdgui libva-nvidia-driver matugen-bin

# 4. Copy Configurations
echo "📂 Copying configuration files..."
mkdir -p ~/.config
cp -r .config/* ~/.config/
cp ~/.config/zsh/.zshrc ~/.zshrc

# 5. Make custom scripts executable
echo "🔑 Setting permissions..."
chmod +x ~/.config/waybar/Scripts/*.sh
chmod +x ~/.config/rofi/launcher.sh

# 6. Install Quickshell Lockscreen
echo "🔒 Installing Darkkal44's Qylock..."
mkdir -p ~/.local/share
if [ ! -d "$HOME/.local/share/quickshell-lockscreen" ]; then
    git clone https://github.com/Darkkal44/qylock.git ~/.local/share/quickshell-lockscreen
fi
chmod +x ~/.local/share/quickshell-lockscreen/lock.sh

# 7. Setup Wallpaper Directories
echo "🖼️ Setting up Wallpaper directories..."
mkdir -p ~/Pictures/Wallpapers/{Anime,Gatcha,Scenery}

echo "🎉 Installation Complete!"
echo "➡️  Next steps:"
echo "1. Put some wallpapers into ~/Pictures/Wallpapers/"
echo "2. Log out and select 'Hyprland' from your login screen!"
