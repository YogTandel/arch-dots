#!/bin/bash

# Ensure script is run from the dotfiles directory
if [ ! -d ".config" ]; then
    echo "❌ Error: Please run this script from the root of the arch-dots directory!"
    exit 1
fi

echo "🚀 Starting Arch Linux Dotfiles Installation..."

backup_path() {
    local target="$1"
    local backup_root="$HOME/.dotfiles-backups/$(date +%Y%m%d-%H%M%S)"

    if [ -e "$target" ] || [ -L "$target" ]; then
        mkdir -p "$backup_root"
        cp -a "$target" "$backup_root/"
        echo "🗄️  Backed up $target → $backup_root/"
    fi
}

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
sudo pacman -S --needed --noconfirm hyprland hyprlock xorg-server xorg-xwayland python-pywal waybar \
  pavucontrol playerctl power-profiles-daemon network-manager-applet pipewire \
  pipewire-pulse pipewire-alsa wireplumber brightnessctl wl-clipboard thunar \
  thunar-archive-plugin thunar-volman tumbler ffmpegthumbnailer gvfs gvfs-mtp \
  file-roller papirus-icon-theme kitty \
  zsh starship fzf zsh-autosuggestions zsh-syntax-highlighting fastfetch \
  ttf-jetbrains-mono-nerd imagemagick gtk4 libadwaita python-gobject python-yaml jq sddm

# 3. Install AUR packages
echo "📦 Installing AUR Packages..."
yay -S --needed --noconfirm swww swaync cava cliphist rofi-wayland hyprshot \
  zsh-fast-syntax-highlighting iwdgui libva-nvidia-driver matugen-bin \
  quickshell-git ttf-material-symbols-variable-git wlogout

# 4. Backup existing user configurations
echo "🗄️  Backing up existing configurations..."
backup_path "$HOME/.config"
backup_path "$HOME/.zshrc"

# 5. Copy Configurations
echo "📂 Copying configuration files..."
mkdir -p ~/.config
cp -r .config/* ~/.config/
cp ~/.config/zsh/.zshrc ~/.zshrc

# 6. Make custom scripts executable
echo "🔑 Setting permissions..."
chmod +x ~/.config/waybar/Scripts/*
chmod +x ~/.config/rofi/launcher.sh
chmod +x ~/.config/rofi/scripts/*.sh
chmod +x ~/.config/rofi/scripts/lib/*.sh
chmod +x ~/.config/fastfetch/*.sh
chmod +x ~/.config/theme_controller.sh
chmod +x ~/.config/wlogout/launch.sh

# 7. Install and enable SDDM theme
echo "🖥️ Installing SDDM login theme..."
sudo mkdir -p /usr/share/sddm/themes/arch-dots
sudo cp -r sddm/arch-dots/* /usr/share/sddm/themes/arch-dots/
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/10-arch-dots.conf >/dev/null <<'EOF'
[Theme]
Current=arch-dots
EOF
sudo systemctl enable sddm.service

# 8. Install Quickshell Lockscreen
echo "🔒 Installing Darkkal44's Qylock..."
mkdir -p ~/.local/share
if [ ! -d "$HOME/.local/share/quickshell-lockscreen" ]; then
    git clone https://github.com/Darkkal44/qylock.git ~/.local/share/quickshell-lockscreen
fi
chmod +x ~/.local/share/quickshell-lockscreen/lock.sh

# 9. Setup Wallpaper Directories
echo "🖼️ Setting up Wallpaper directories..."
mkdir -p ~/Wallpapers/{Dark,Light}

# 10. Setup Fastfetch Image Directories
echo "🖼️ Setting up Fastfetch image directories..."
mkdir -p ~/.config/fastfetch/images/{anime,scenery,abstract,other}

# 11. Initialize fastfetch random image
echo "🎨 Initializing fastfetch image randomizer..."
~/.config/fastfetch/fastfetch-image-setup.sh &> /dev/null || true

echo "🎉 Installation Complete!"
echo ""
echo "➡️  Next steps:"
echo "1. Add wallpapers to ~/Wallpapers/Dark/ and ~/Wallpapers/Light/"
echo "2. Add images to ~/.config/fastfetch/images/{anime,scenery,abstract,other}/"
echo "3. Log out and select 'Hyprland' from your login screen!"
echo ""
echo "💡 Quick commands:"
echo "   Super+W              → Random wallpaper + auto-sync theme"
echo "   Super+Shift+W        → Toggle dark/light mode"
echo "   Super+Shift+B        → Next wallpaper"
echo "   Super+Alt+Space      → ROFI Dashboard menu"
echo "   Super+L              → Lock screen"
echo ""
echo "📖 Documentation:"
echo "   THEME_SYSTEM.md               → Theme system setup guide"
echo "   .config/fastfetch/FASTFETCH_IMAGES.md → Fastfetch image guide"
echo "   .config/rofi/scripts/         → ROFI script ecosystem"
