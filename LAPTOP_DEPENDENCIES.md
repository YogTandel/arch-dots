# Laptop Dependencies and Setup

Target laptop from your screenshot:

- Model: ASUS ROG Strix G513RC / G513RC series
- CPU: AMD Ryzen 7 6800H
- GPU: NVIDIA GeForce RTX 3050 Laptop GPU
- RAM: 16 GB
- Desktop: Hyprland + SDDM + QuickShell + Matugen

This file is the hardware-specific install checklist. `install.sh` installs the dotfiles stack; use this file to make sure the laptop base, NVIDIA hybrid graphics, firmware, and services are correct.

## 1. Base System

Install these before or alongside the dotfiles:

```bash
sudo pacman -S --needed \
  base-devel git linux linux-headers linux-firmware amd-ucode \
  networkmanager bluez bluez-utils \
  pipewire pipewire-pulse pipewire-alsa wireplumber \
  xdg-desktop-portal xdg-desktop-portal-hyprland xdg-user-dirs \
  polkit-gnome
```

Enable core services:

```bash
sudo systemctl enable NetworkManager.service
sudo systemctl enable bluetooth.service
```

## 2. AMD Integrated GPU

The Ryzen 7 6800H includes an AMD iGPU. Keep the Mesa stack installed even when using NVIDIA:

```bash
sudo pacman -S --needed \
  mesa vulkan-radeon libva-mesa-driver mesa-utils vulkan-tools
```

Useful checks:

```bash
glxinfo -B
vulkaninfo --summary
```

## 3. NVIDIA RTX 3050 Laptop GPU

For the RTX 3050 Laptop GPU, use the proprietary NVIDIA stack:

```bash
sudo pacman -S --needed \
  nvidia nvidia-utils nvidia-settings nvidia-prime \
  egl-wayland opencl-nvidia
```

AUR package used by this dotfiles setup for VA-API on NVIDIA:

```bash
yay -S --needed libva-nvidia-driver
```

Use PRIME render offload when you want an app to run on the NVIDIA GPU:

```bash
prime-run <app>
prime-run glxinfo -B
prime-run vulkaninfo --summary
```

Good examples:

```bash
prime-run steam
prime-run blender
prime-run gamescope
```

## 4. Hyprland and NVIDIA Notes

The dotfiles already include Hyprland. For NVIDIA laptops, keep these packages available:

```bash
sudo pacman -S --needed \
  hyprland xorg-xwayland qt5-wayland qt6-wayland \
  wayland-protocols xdg-desktop-portal-hyprland
```

If you get flickering, black screens, or high CPU usage after login, check NVIDIA/Hyprland guidance first. Hybrid NVIDIA laptops are more sensitive than AMD-only laptops.

## 5. SDDM Login Screen

The repo includes a custom SDDM theme in:

```bash
sddm/arch-dots/
```

Required packages:

```bash
sudo pacman -S --needed sddm xorg-server
```

`install.sh` copies the theme and enables SDDM. Manual setup:

```bash
sudo cp -r sddm/arch-dots /usr/share/sddm/themes/
sudo mkdir -p /etc/sddm.conf.d
printf "[Theme]\nCurrent=arch-dots\n" | sudo tee /etc/sddm.conf.d/10-arch-dots.conf
sudo systemctl enable sddm.service
```

## 6. ASUS ROG Extras

Optional, but useful for ASUS ROG laptops:

```bash
yay -S --needed asusctl supergfxctl rog-control-center
```

Enable services:

```bash
sudo systemctl enable --now asusd.service
sudo systemctl enable --now supergfxd.service
```

User service:

```bash
systemctl --user enable --now asusd-user.service
```

Use these tools for battery charge limit, keyboard lighting, fan profiles, and GPU mode controls. Do not enable custom fan curves until the rest of the system is stable.

## 7. Dotfiles Stack

These are already covered by `install.sh`, but this is the expected stack:

```bash
sudo pacman -S --needed \
  hyprland hyprlock xorg-server xorg-xwayland python-pywal waybar \
  pavucontrol playerctl power-profiles-daemon network-manager-applet \
  brightnessctl wl-clipboard thunar thunar-archive-plugin thunar-volman \
  tumbler ffmpegthumbnailer gvfs gvfs-mtp file-roller papirus-icon-theme \
  kitty zsh starship fzf zsh-autosuggestions zsh-syntax-highlighting \
  fastfetch ttf-jetbrains-mono-nerd imagemagick gtk4 libadwaita \
  python-gobject python-yaml jq sddm
```

```bash
yay -S --needed \
  swww swaync cava cliphist rofi-wayland hyprshot \
  zsh-fast-syntax-highlighting iwdgui libva-nvidia-driver matugen-bin \
  quickshell-git ttf-material-symbols-variable-git wlogout
```

## 8. Recommended Install Order

1. Install Arch base system.
2. Install network, firmware, AMD microcode, Mesa, and NVIDIA packages from this file.
3. Enable `NetworkManager`, `bluetooth`, and later `sddm`.
4. Clone this repo.
5. Run:

```bash
chmod +x install.sh
./install.sh
```

6. Reboot.
7. Choose Hyprland from SDDM.
8. Test NVIDIA offload:

```bash
prime-run glxinfo -B
```

## 9. Quick Debug Commands

```bash
lspci -k | grep -A 3 -E "VGA|3D|Display"
glxinfo -B
prime-run glxinfo -B
vulkaninfo --summary
systemctl status sddm
journalctl -b -u sddm --no-pager
journalctl -b | grep -i nvidia
```

## References

- ArchWiki PRIME: https://wiki.archlinux.org/title/PRIME
- ArchWiki NVIDIA Optimus: https://wiki.archlinux.org/title/NVIDIA_Optimus
- ArchWiki Hyprland: https://wiki.archlinux.org/title/Hyprland
- ArchWiki SDDM: https://wiki.archlinux.org/title/SDDM
- ArchWiki ASUS Linux: https://wiki.archlinux.org/title/ASUS_Linux
- ArchWiki asusctl: https://wiki.archlinux.org/title/Asusctl
