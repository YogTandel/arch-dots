# 📦 Dependencies

> All packages required to fully use these dotfiles on Arch Linux.

---

## 🪟 Window Manager

| Package | Install | Description |
|---------|---------|-------------|
| `hyprland` | `pacman -S hyprland` | Wayland compositor / window manager |
| `hyprlock` | `pacman -S hyprlock` | Lock screen (triggered via `Super+L`) |
| `xorg-xwayland` | `pacman -S xorg-xwayland` | XWayland support for legacy X11 apps |

---

## 🖼️ Wallpaper & Theming

| Package | Install | Description |
|---------|---------|-------------|
| `swww` | `yay -S swww` | Animated wallpaper daemon |
| `python-pywal` | `pacman -S python-pywal` | Generates color schemes from wallpaper (`wal -R`) |

---

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

---

## 🔊 Audio

| Package | Install | Description |
|---------|---------|-------------|
| `pipewire` | `pacman -S pipewire` | Modern audio server |
| `pipewire-pulse` | `pacman -S pipewire-pulse` | PulseAudio compatibility layer (for Waybar & cava) |
| `pipewire-alsa` | `pacman -S pipewire-alsa` | ALSA compatibility |
| `wireplumber` | `pacman -S wireplumber` | PipeWire session manager (`wpctl` for volume keys) |

---

## 🔦 Brightness

| Package | Install | Description |
|---------|---------|-------------|
| `brightnessctl` | `pacman -S brightnessctl` | Keyboard brightness keys (`XF86MonBrightness*`) |

---

## 📋 Clipboard

| Package | Install | Description |
|---------|---------|-------------|
| `wl-clipboard` | `pacman -S wl-clipboard` | Wayland clipboard (`wl-paste`) |
| `cliphist` | `yay -S cliphist` | Clipboard history manager |

---

## 🔍 App Launcher

| Package | Install | Description |
|---------|---------|-------------|
| `rofi-wayland` | `yay -S rofi-wayland` | App launcher (`Super+Enter`) |

---

## 📁 File Manager

| Package | Install | Description |
|---------|---------|-------------|
| `dolphin` | `pacman -S dolphin` | File manager (`Super+E`) |

---

## 🖥️ Terminal & Shell

| Package | Install | Description |
|---------|---------|-------------|
| `kitty` | `pacman -S kitty` | GPU-accelerated terminal emulator |
| `zsh` | `pacman -S zsh` | Z shell |
| `starship` | `pacman -S starship` | Cross-shell prompt (loaded in `.zshrc`) |
| `fzf` | `pacman -S fzf` | Fuzzy finder (`Ctrl+R` history search) |

---

## 🐚 ZSH Plugins

| Package | Install | Description |
|---------|---------|-------------|
| `zsh-autosuggestions` | `pacman -S zsh-autosuggestions` | Fish-like autosuggestions |
| `zsh-syntax-highlighting` | `pacman -S zsh-syntax-highlighting` | Command syntax highlighting |
| `fast-syntax-highlighting` | `yay -S zsh-fast-syntax-highlighting` | Faster syntax highlighting alternative |

---

## 📸 Screenshots

| Package | Install | Description |
|---------|---------|-------------|
| `hyprshot` | `yay -S hyprshot` | Screenshot tool (`Super+Shift+S` → region to clipboard) |

---

## 📡 System Info

| Package | Install | Description |
|---------|---------|-------------|
| `fastfetch` | `pacman -S fastfetch` | System info display (uses kitty image protocol) |

---

## 🎨 Fonts

| Package | Install | Description |
|---------|---------|-------------|
| `ttf-jetbrains-mono-nerd` | `pacman -S ttf-jetbrains-mono-nerd` | Primary font for terminal, hyprlock, waybar |

---

## 🌐 Network (Optional GUI)

| Package | Install | Description |
|---------|---------|-------------|
| `iwdgui` | `yay -S iwdgui` | Wi-Fi GUI (floated window via Waybar click) |

---

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
sudo pacman -S hyprland hyprlock xorg-xwayland python-pywal waybar pavucontrol \
  playerctl power-profiles-daemon network-manager-applet pipewire pipewire-pulse \
  pipewire-alsa wireplumber brightnessctl wl-clipboard dolphin kitty zsh starship \
  fzf zsh-autosuggestions zsh-syntax-highlighting fastfetch ttf-jetbrains-mono-nerd
```

### AUR (via yay)

```bash
yay -S swww swaync cava cliphist rofi-wayland hyprshot \
  zsh-fast-syntax-highlighting iwdgui libva-nvidia-driver
```

---

> [!NOTE]
> Fonts are required for icons to render correctly in Waybar, Hyprlock, and the terminal.
> Make sure `ttf-jetbrains-mono-nerd` is installed before launching Hyprland.

> cp -r d:\arch-dots\.config/* ~/.config/
> mv ~/.config/zsh/.zshrc ~/.zshrc
> cp ~/.config/waybar/funconfig.jsonc ~/.config/waybar/config.jsonc
> cp ~/.config/waybar/funstyle.css ~/.config/waybar/style.css

> cp ~/.config/waybar/funconfig.jsonc ~/.config/waybar/config.jsonc
> cp ~/.config/waybar/funstyle.css ~/.config/waybar/style.css