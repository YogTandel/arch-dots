# dot-files
My personal dotfiles for Arch Linux. This repository is not actively maintained. 
At this point this just shows the evolution of my rice :D

## 🎨 NEW: Integrated Theme System + ROFI Scripts Ecosystem

This repo now includes a **wallpaper-driven theming system** that automatically syncs colors across ALL your apps when you switch wallpapers or toggle between dark/light modes. Plus a **complete ROFI scripts ecosystem** for enhanced productivity!

**Quick Start Theme System:**
```bash
mkdir -p ~/Wallpapers/{Dark,Light}
# Add wallpaper images to these directories
# Then use: Super+W (random), Super+Shift+W (toggle dark/light), Super+Shift+B (next)
```

**Quick Start ROFI Dashboard:**
```bash
# Super+Alt+Space opens the dashboard with:
# - Appearance (wallpaper picker with thumbnails)
# - Applications manager
# - System info & shortcuts
# - Packages quick-install menu
# - Power menu
# - And more!
```

See [THEME_SYSTEM.md](./THEME_SYSTEM.md) for theme system details and [.config/rofi/scripts/](./config/rofi/scripts/) for ROFI script info.

## Overview

- **Wayland compositor:** [Hyprland](https://wiki.hypr.land/) 
- **Terminal emulator:** [Kitty](https://sw.kovidgoyal.net/kitty/)

*Disclaimer: Not all these dot files are by me. Many of them are from online and altered accordingly.

## Theme
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0d6ee772-35b9-436f-876a-a252db1814d0" />
<img width="1931" height="1201" alt="image" src="https://github.com/user-attachments/assets/7970fb32-7117-4032-849f-26eb0f33bc37" />
<img width="1348" height="842" alt="image" src="https://github.com/user-attachments/assets/56e8f8e5-3aec-4727-b952-bf914ccac109" />

## Started using QuickSHELL 
<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/fd3cb080-e68a-4522-8e96-fbcdb32f8893" />
<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/4fc9bd74-cc3a-4efc-8c85-c02144db2c52" />
<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/256ae716-b5c0-49c1-bc5f-1078331b8a6d" />

*The terminal colors are changed using pywal and the waybar colors are changed using matugen theming

*Desktop wallpapers are from: (https://github.com/NischalDawadi/Wallpapers/tree/master)

---

# 📦 Dependencies

> All packages required to fully use these dotfiles on Arch Linux.

## 🪟 Window Manager

| Package | Install | Description |
|---------|---------|-------------|
| `hyprland` | `pacman -S hyprland` | Wayland compositor / window manager |
| `hyprlock` | `pacman -S hyprlock` | Lock screen (triggered via `Super+L`) |
| `sddm` | `pacman -S sddm` | Graphical login screen using the included `arch-dots` theme |
| `xorg-server` | `pacman -S xorg-server` | Display server used by the SDDM greeter |
| `xorg-xwayland` | `pacman -S xorg-xwayland` | XWayland support for legacy X11 apps |
| `wlogout` | `yay -S wlogout` | Power/session menu (triggered via `Super+M`) |
| `jq` | `pacman -S jq` | JSON parser used by the wlogout launcher |

## 🖼️ Wallpaper & Theming & Color Syncing

| Package | Install | Description |
|---------|---------|-------------|
| `swww` | `yay -S swww` | Animated wallpaper daemon |
| `python-pywal` | `pacman -S python-pywal` | Generates color schemes from wallpaper (`wal -R`) |
| `matugen-bin` | `yay -S matugen-bin` | Advanced color sync across apps (GTK, Qt, Kitty, etc.) |

## 📊 Status Bar (Waybar)

| Package | Install | Description |
|---------|---------|-------------|
| `waybar` | `pacman -S waybar` | Status bar (both fun & minimal themes) |
| `pavucontrol` | `pacman -S pavucontrol` | Audio control GUI (pulseaudio click) |
| `swaync` | `yay -S swaync` | Notification daemon + client |
| `playerctl` | `pacman -S playerctl` | Media player control (play/pause/next/prev) |
| `power-profiles-daemon` | `pacman -S power-profiles-daemon` | Battery power profile switcher |
| `network-manager-applet` | `pacman -S network-manager-applet` | `nm-connection-editor` for network click |
| `cava` | `yay -S cava` | Terminal audio visualizer in bar |

## 🔊 Audio

| Package | Install | Description |
|---------|---------|-------------|
| `pipewire` | `pacman -S pipewire` | Modern audio server |
| `pipewire-pulse` | `pacman -S pipewire-pulse` | PulseAudio compatibility layer (for Waybar & cava) |
| `pipewire-alsa` | `pacman -S pipewire-alsa` | ALSA compatibility |
| `wireplumber` | `pacman -S wireplumber` | PipeWire session manager (`wpctl` for volume keys) |

## 🔦 Brightness

| Package | Install | Description |
|---------|---------|-------------|
| `brightnessctl` | `pacman -S brightnessctl` | Keyboard brightness keys (`XF86MonBrightness*`) |

## 📋 Clipboard

| Package | Install | Description |
|---------|---------|-------------|
| `wl-clipboard` | `pacman -S wl-clipboard` | Wayland clipboard (`wl-paste`) |
| `cliphist` | `yay -S cliphist` | Clipboard history manager |

## 🔍 App Launcher

| Package | Install | Description |
|---------|---------|-------------|
| `rofi-wayland` | `yay -S rofi-wayland` | App launcher (`Super+Enter`) |

## 📁 File Manager

| Package | Install | Description |
|---------|---------|-------------|
| `thunar` | `pacman -S thunar` | GTK file manager (`Super+E`) |
| `thunar-archive-plugin` | `pacman -S thunar-archive-plugin` | Archive actions in Thunar context menus |
| `thunar-volman` | `pacman -S thunar-volman` | Removable media integration for Thunar |
| `tumbler` | `pacman -S tumbler` | Thumbnail service for Thunar |
| `ffmpegthumbnailer` | `pacman -S ffmpegthumbnailer` | Video thumbnails |
| `gvfs gvfs-mtp` | `pacman -S gvfs gvfs-mtp` | Trash, mounts, and phone/MTP support |
| `file-roller` | `pacman -S file-roller` | GTK archive manager |
| `papirus-icon-theme` | `pacman -S papirus-icon-theme` | Icon theme used by GTK apps |

## 🖥️ Terminal & Shell

| Package | Install | Description |
|---------|---------|-------------|
| `kitty` | `pacman -S kitty` | GPU-accelerated terminal emulator |
| `zsh` | `pacman -S zsh` | Z shell |
| `starship` | `pacman -S starship` | Cross-shell prompt (loaded in `.zshrc`) |
| `fzf` | `pacman -S fzf` | Fuzzy finder (`Ctrl+R` history search) |

## 🐚 ZSH Plugins

| Package | Install | Description |
|---------|---------|-------------|
| `zsh-autosuggestions` | `pacman -S zsh-autosuggestions` | Fish-like autosuggestions |
| `zsh-syntax-highlighting` | `pacman -S zsh-syntax-highlighting` | Command syntax highlighting |
| `fast-syntax-highlighting` | `yay -S zsh-fast-syntax-highlighting` | Faster syntax highlighting alternative |

## 📸 Screenshots

| Package | Install | Description |
|---------|---------|-------------|
| `hyprshot` | `yay -S hyprshot` | Screenshot tool (`Super+Shift+S` → region to clipboard) |

## 📡 System Info

| Package | Install | Description |
|---------|---------|-------------|
| `fastfetch` | `pacman -S fastfetch` | System info display (uses kitty image protocol) |

## 🎨 Fonts

| Package | Install | Description |
|---------|---------|-------------|
| `ttf-jetbrains-mono-nerd` | `pacman -S ttf-jetbrains-mono-nerd` | Primary font for terminal, hyprlock, waybar |

## 🌐 Network (Optional GUI)

| Package | Install | Description |
|---------|---------|-------------|
| `iwdgui` | `yay -S iwdgui` | Wi-Fi GUI (floated window via Waybar click) |

## 🎮 Nvidia GPU (if applicable)

> Only needed if running an Nvidia GPU. These env vars are set in `hyprland.conf`.

| Package | Install | Description |
|---------|---------|-------------|
| `nvidia` | `pacman -S nvidia` | Proprietary Nvidia drivers |
| `nvidia-utils` | `pacman -S nvidia-utils` | Nvidia utility tools |
| `libva-nvidia-driver` | `yay -S libva-nvidia-driver` | VA-API support (`LIBVA_DRIVER_NAME=nvidia`) |

---

## ⚡ Quick Install

### Pacman (Official Repos)

```bash
sudo pacman -S hyprland hyprlock sddm xorg-server xorg-xwayland python-pywal waybar pavucontrol \
  playerctl power-profiles-daemon network-manager-applet pipewire pipewire-pulse \
  pipewire-alsa wireplumber brightnessctl wl-clipboard thunar thunar-archive-plugin \
  thunar-volman tumbler ffmpegthumbnailer gvfs gvfs-mtp file-roller papirus-icon-theme \
  kitty zsh starship \
  fzf zsh-autosuggestions zsh-syntax-highlighting fastfetch ttf-jetbrains-mono-nerd imagemagick jq
```

### AUR (via yay)

```bash
yay -S swww swaync cava cliphist rofi-wayland hyprshot \
  zsh-fast-syntax-highlighting iwdgui libva-nvidia-driver matugen-bin wlogout
```

> [!NOTE]
> Fonts are required for icons to render correctly in Waybar, Hyprlock, and the terminal.
> Make sure `ttf-jetbrains-mono-nerd` is installed before launching Hyprland.

---

## 🚀 Full Setup Guide

Follow these steps to install the dotfiles on a fresh Arch Linux system:

### 1. Simple Automated Install
Simply run the included installation script to automatically download dependencies, set up directories, and copy configuration files.
```bash
chmod +x install.sh
./install.sh
```

### 2. Manual Configuration (Optional)
If you prefer to copy files manually instead of using `install.sh`:
```bash
cp -r .config/* ~/.config/
mv ~/.config/zsh/.zshrc ~/.zshrc
```

### 3. Install Quickshell Lockscreen
The automated script handles this, but if doing it manually, clone Darkkal44's `qylock` project to make your lockscreen work:
```bash
git clone https://github.com/Darkkal44/qylock.git ~/.local/share/quickshell-lockscreen
chmod +x ~/.local/share/quickshell-lockscreen/lock.sh
```

### 4. Install SDDM Login Theme

The automated installer copies the included SDDM theme and enables SDDM:

```bash
sudo cp -r sddm/arch-dots /usr/share/sddm/themes/
sudo mkdir -p /etc/sddm.conf.d
printf "[Theme]\nCurrent=arch-dots\n" | sudo tee /etc/sddm.conf.d/10-arch-dots.conf
sudo systemctl enable sddm.service
```

### 5. Set Up Wallpapers & Theme System

Create the organized wallpaper folder structure:
```bash
mkdir -p ~/Wallpapers/{Dark,Light}
# Or customize with your own folders (see THEME_SYSTEM.md)
```

Add your wallpapers to these folders and use:
- `Super+W` - Random wallpaper
- `Super+Shift+W` - Toggle dark/light mode
- `Super+Shift+B` - Next wallpaper

### 6. Set Up Fastfetch Images

Organize your fastfetch display images:
```bash
mkdir -p ~/.config/fastfetch/images/{anime,scenery,abstract,other}
# Add images to these folders
# Images will be randomized on each terminal open
```

See `.config/fastfetch/FASTFETCH_IMAGES.md` for details.

### 7. Explore ROFI Dashboard

Open the ROFI scripts dashboard:
```bash
Super+Alt+Space  # Opens main dashboard menu
```

Features:
- **Appearance**: Wallpaper picker with thumbnails
- **Applications**: Quick app launcher
- **System**: System info and useful shortcuts
- **Packages**: Pacman/AUR quick-install
- **Power**: Power menu (shutdown, reboot, suspend)
- **And more!** (Learn, Tools, Keybinds, AI menu)

---

## ⌨️ Custom Keybindings

| Keybind | Action |
|---------|--------|
| `Super + Enter` | App Launcher (Rofi) |
| `Super + Alt + Space` | ROFI Dashboard Menu |
| `Super + T` | Open Terminal (Kitty) |
| `Super + E` | Open File Manager (Thunar) |
| `Super + Q` | Close Active Window |
| `Super + M` | Power Menu (Shutdown / Reboot) |
| `Super + W` | Random Wallpaper & Auto-Sync Theme |
| `Super + Shift + W` | Toggle Dark/Light Mode |
| `Super + Shift + B` | Next Wallpaper |
| `Super + B` | Toggle Waybar Visibility |
| `Super + L` | Lock Screen (Qylock) |
| `Super + V` | Toggle Floating Window |
| `Super + F` | Fullscreen |
| `Super + Shift + F` | Exit Fullscreen |
| `Super + P` | Pseudo Tiling |
| `Super + J` | Toggle Split |
| `Super + S` | Toggle Special Workspace (Scratchpad) |
| `Super + Shift + S` | Screenshot Region to Clipboard |
| `Super + [1-0]` | Switch to Workspace 1-10 |
| `Super + Shift + [1-0]` | Move Active Window to Workspace 1-10 |
| `Super + Arrow Keys` | Move Focus (Left/Right/Up/Down) |
| `Super + Mouse Scroll` | Scroll through Workspaces |
| `Super + Left Mouse (Drag)` | Move Window |
| `Super + Right Mouse (Drag)`| Resize Window |
| `XF86Audio...` | Volume and Media Controls |
| `XF86MonBrightness...` | Screen Brightness Controls |
