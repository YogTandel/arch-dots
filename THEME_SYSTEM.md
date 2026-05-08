# 🎨 Arch-Dots Theme System

This document describes the integrated wallpaper-driven theme system for arch-dots, ported from cloudyy-linux with smooth, real-time color syncing across all applications.

## Overview

The theme system automatically generates and applies colors to all apps whenever you switch wallpapers or toggle between dark/light modes. It uses:

- **swww** — Smooth wallpaper transitions with center-grow animation
- **matugen** — Material Design 3 color generation from wallpaper images
- **theme_controller.sh** — Orchestrates wallpaper switching and system-wide theme updates
- **State management** — Persists last wallpaper per theme mode for smart toggling

## Quick Start

### Setup Wallpapers

#### Option 1: Dark/Light Pool (Recommended ⭐)

Create the default structure with automatic mode pooling:

```bash
mkdir -p ~/Wallpapers/Dark
mkdir -p ~/Wallpapers/Light
```

**Why this is best:**
- ✅ Smart theme toggling — remembers last wallpaper per mode
- ✅ Automatic dark/light color generation matching the mood
- ✅ Smooth transitions between themes
- ✅ System "knows" which wallpaper fits which mode

Add images by copying or symlinking:

```bash
# Copy wallpapers
cp ~/Pictures/mountain.jpg ~/Wallpapers/Dark/
cp ~/Pictures/beach.jpg ~/Wallpapers/Light/

# Or use symlinks (if wallpapers are elsewhere)
ln -s ~/Pictures/Wallpapers/mountain.jpg ~/Wallpapers/Dark/mountain.jpg
ln -s ~/Pictures/Wallpapers/beach.jpg ~/Wallpapers/Light/beach.jpg
```

#### Option 2: Custom Folder Names

Use whatever names you want, then **tag** them to modes:

```bash
mkdir -p ~/Wallpapers/{Mountains,Cities,Nature}
cp ~/Pictures/*.jpg ~/Wallpapers/Mountains/
```

Then associate with themes:
```bash
# Tag a wallpaper for dark mode
~/.cloudyy_scripts/theme_controller.sh tag ~/Wallpapers/Mountains/peak.jpg dark

# Tag for light mode
~/.cloudyy_scripts/theme_controller.sh tag ~/Wallpapers/Cities/office.jpg light
```

This creates symlinks in `Dark/` and `Light/` behind the scenes.

#### Option 3: Flat Structure (Simple)

```bash
mkdir ~/Wallpapers
cp ~/Pictures/*.jpg ~/Wallpapers/
```

**Tradeoffs:** Works, but no mode awareness. System cycles through all wallpapers randomly without remembering preferences.

### Recommendation

**Use Option 1 (Dark/Light pools)** for the smoothest experience. If you keep wallpapers organized elsewhere, use Option 2 with symlinks.

### Default Keybindings

| Keybind | Action |
|---------|--------|
| **Super + W** | Random wallpaper (current mode) |
| **Super + Shift + W** | Toggle dark/light theme |
| **Super + Shift + B** | Next wallpaper (alphabetically) |

### Manual Commands

```bash
# Apply a specific wallpaper in dark mode
~/.cloudyy_scripts/theme_controller.sh set-image ~/Wallpapers/Dark/wallpaper.jpg

# Toggle between dark and light theme
~/.cloudyy_scripts/theme_controller.sh toggle

# Get current theme mode (outputs: "dark" or "light")
~/.cloudyy_scripts/theme_controller.sh get-mode

# Debug: Show current theme state
~/.cloudyy_scripts/theme_controller.sh debug
```

## How It Works

### Theme Controller Flow

1. **Wallpaper switching** — `theme_controller.sh` is called with a wallpaper
2. **Wallpaper transition** — `swww` animates the wallpaper change (fast, non-blocking)
3. **Color generation** — `matugen` analyzes the wallpaper and generates Material Design colors
4. **Template rendering** — matugen renders all `.tera` templates:
   - `colors-swaync.css` → swaync notification daemon
   - `kitty-colors.conf` → Kitty terminal
   - `hyprland-colors.conf` → Hyprland border/accent colors
   - `gtk-colors.css` → GTK3/4 apps
   - `colors-swayosd.css` → Volume/brightness OSD
   - `btop.theme` → System monitor
5. **Post-hooks** — matugen runs post_hooks to reload affected apps
6. **System theme sync** — Sets GTK/Qt/Firefox preferences for light/dark mode
7. **State persistence** — Saves wallpaper path and mode for next login

### Example: Dark Mode Toggle

```
Current state: Dark mode, ~/Wallpapers/Dark/mountain.jpg

User presses: Super + Shift + W

↓

Check saved wallpaper for light mode...
→ Found: ~/Wallpapers/Light/beach.jpg

↓

Apply wallpaper + generate colors:
  swww animate transition (2s)
  matugen generate material colors
  
↓

Post-hooks reload apps:
  waybar: colors.css updated
  swaync: colors-swaync.css updated  
  kitty: colors.conf updated
  
↓

Set system theme: prefer-light
  gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
  Update Firefox user.js
  Update qt6ct.conf

↓

Save state:
  ~/.config/hypr/theme_state/state.conf:
    THEME_MODE="light"
    CURRENT_WALL="/home/user/Wallpapers/Light/beach.jpg"
```

## File Structure

```
~/.config/
├── hypr/
│   ├── hyprland.conf          # Keybinds + exec-once for theme restore
│   └── theme_state/           # Auto-created on first run
│       ├── state.conf         # Current wallpaper + mode
│       ├── state              # Binary: 1=light, 0=dark (for scripts)
│       ├── system_theme.env   # GTK/Qt env exports
│       ├── dark_last          # Last wallpaper used in dark mode
│       ├── light_last         # Last wallpaper used in light mode
│       └── current_wallpaper/ # Snapshot of active wallpaper
│
├── matugen/
│   ├── config.toml            # Templates + post_hooks config
│   ├── templates/             # .tera template files
│   │   ├── hyprland-colors.conf
│   │   ├── kitty-colors.conf
│   │   ├── gtk-colors.css
│   │   ├── colors-swaync.css
│   │   ├── colors-swayosd.css
│   │   ├── btop.theme
│   │   └── ... (others)
│   └── generated/             # Output files (auto-generated)
│       ├── hyprcolors.conf
│       ├── colors-swaync.css
│       ├── gtk-3.css
│       └── ... (others)
│
├── swaync/
│   └── style.css              # Imports @import url("../matugen/generated/colors-swaync.css")
│
└── ...

~/.local/bin/ (optional, for convenient calls)
└── theme → symlink to ~/.cloudyy_scripts/theme_controller.sh

~/Wallpapers/
├── Dark/                      # Dark-mode wallpapers (or symlinks)
│   ├── wallpaper1.jpg
│   └── wallpaper2.png
└── Light/                     # Light-mode wallpapers (or symlinks)
    ├── beach.jpg
    └── office.png

~/.cloudyy_scripts/
└── theme_controller.sh        # Main theme orchestrator
```

## Organizing Wallpapers

### Using Tags for Custom Folders

If you store wallpapers in custom folders by color or theme, use the tagging system to associate them with dark/light modes. **You decide which wallpaper works best with each mode** — the system just remembers your choices.

#### Example: Pink & Multi-Color Organization

```bash
# Organize by color/aesthetic (your choice)
mkdir -p ~/Wallpapers/{Pink,Blue,Purple,Nature,Abstract,Anime}

# Copy your wallpapers
cp ~/Pictures/pink-sunset.jpg ~/Wallpapers/Pink/
cp ~/Pictures/pink-aesthetic.jpg ~/Wallpapers/Pink/
cp ~/Pictures/blue-ocean.jpg ~/Wallpapers/Blue/
cp ~/Pictures/purple-galaxy.jpg ~/Wallpapers/Purple/
cp ~/Pictures/forest.jpg ~/Wallpapers/Nature/
cp ~/Pictures/abstract-art.jpg ~/Wallpapers/Abstract/
```

#### Tag Wallpapers to Modes

Now decide which wallpapers work best in which mode:

```bash
# Pink sunset → dark mode (looks moody & rich)
~/.cloudyy_scripts/theme_controller.sh tag ~/Wallpapers/Pink/pink-sunset.jpg dark

# Pink aesthetic → light mode (soft & airy)
~/.cloudyy_scripts/theme_controller.sh tag ~/Wallpapers/Pink/pink-aesthetic.jpg light

# Blue ocean → works in both modes
~/.cloudyy_scripts/theme_controller.sh tag ~/Wallpapers/Blue/blue-ocean.jpg dark
~/.cloudyy_scripts/theme_controller.sh tag ~/Wallpapers/Blue/blue-ocean.jpg light

# Purple galaxy → only dark mode
~/.cloudyy_scripts/theme_controller.sh tag ~/Wallpapers/Purple/purple-galaxy.jpg dark

# Nature images → flexible
~/.cloudyy_scripts/theme_controller.sh tag ~/Wallpapers/Nature/forest.jpg dark
~/.cloudyy_scripts/theme_controller.sh tag ~/Wallpapers/Nature/forest.jpg light

# Abstract art → dark only
~/.cloudyy_scripts/theme_controller.sh tag ~/Wallpapers/Abstract/abstract-art.jpg dark
```

#### How It Works

After tagging, the system creates **symlinks** in `~/Wallpapers/Dark/` and `~/Wallpapers/Light/`:

```bash
# Your originals stay organized by color:
~/Wallpapers/Pink/pink-sunset.jpg
~/Wallpapers/Pink/pink-aesthetic.jpg
~/Wallpapers/Blue/blue-ocean.jpg
# ... etc

# Symlinks appear in pools:
~/Wallpapers/Dark/
  ├── pink-sunset.jpg → ~/Wallpapers/Pink/pink-sunset.jpg
  ├── blue-ocean.jpg → ~/Wallpapers/Blue/blue-ocean.jpg
  └── purple-galaxy.jpg → ~/Wallpapers/Purple/purple-galaxy.jpg

~/Wallpapers/Light/
  ├── pink-aesthetic.jpg → ~/Wallpapers/Pink/pink-aesthetic.jpg
  └── blue-ocean.jpg → ~/Wallpapers/Blue/blue-ocean.jpg
```

When you toggle theme or press Super+W, the system picks from these pools automatically!

#### Untag Wallpapers

Remove a wallpaper from a mode:

```bash
~/.cloudyy_scripts/theme_controller.sh untag ~/Wallpapers/Pink/pink-sunset.jpg dark
```

This deletes the symlink **without touching your original file**.

#### View Your Pools

```bash
# See all dark-mode wallpapers (symlinks)
ls -la ~/Wallpapers/Dark/

# See all light-mode wallpapers
ls -la ~/Wallpapers/Light/
```

#### Key Advantage

**You have total control:**
- Pink wallpaper can be dark OR light OR both (you decide per image)
- Same with blue, purple, abstract — tag each one individually
- Keep originals organized however you want (by color, aesthetic, artist, etc.)
- Matugen generates appropriate colors regardless of the wallpaper's color

## Matugen Configuration

The `~/.config/matugen/config.toml` defines all color generation templates and post-hooks.

### Adding New App Colors

To add a new app to the theme system:

1. Create a template file: `~/.config/matugen/templates/myapp-colors.conf`
2. Use matugen variables like `{{colors.primary.default.hex}}`
3. Add to `config.toml`:
```toml
[templates.myapp]
input_path = "~/.config/matugen/templates/myapp-colors.conf"
output_path = "~/.config/myapp/theme.conf"
post_hook = 'pkill -USR1 myapp || true'  # Optional: reload app
```
4. Restart hyprland or run: `matugen image ~/Wallpapers/Dark/wallpaper.jpg`

## GTK/Qt/Firefox Integration

The theme_controller automatically syncs system preferences:

### GTK3/4
- Sets `org.gnome.desktop.interface color-scheme` via `gsettings`
- Updates `prefer-light` / `prefer-dark` preference
- Apps like Thunar, GNOME apps respond automatically

### Qt6
- Updates `~/.config/qt6ct/qt6ct.conf` style setting
- Sets `QT_STYLE_OVERRIDE` environment variable

### Firefox / Zen Browser
- Injects `user.js` prefs:
  - `ui.systemUsesDarkTheme` (0 or 1)
  - `browser.theme.content-theme` (for tab/content colors)
  - `browser.theme.toolbar-theme`
- Works with both native and Flatpak installations

## Troubleshooting

## Troubleshooting

### No wallpapers found when toggling theme

**Problem:** `~/.cloudyy_scripts/theme_controller.sh toggle` fails with "No wallpapers found"

**Solution:** Check your folder structure:
```bash
~/.cloudyy_scripts/theme_controller.sh debug
```

Should show:
```
Dark dir:  YES
Light dir: YES
```

If not, create them:
```bash
mkdir -p ~/Wallpapers/Dark
mkdir -p ~/Wallpapers/Light
```

### Wallpapers not found after using custom folders

**Problem:** You created `~/Wallpapers/Mountains/` but the system doesn't see them.

**Solution:** This is expected! The system only looks in `Dark/` and `Light/` by default. Use tagging:

```bash
~/.cloudyy_scripts/theme_controller.sh tag ~/Wallpapers/Mountains/peak.jpg dark
~/.cloudyy_scripts/theme_controller.sh tag ~/Wallpapers/Mountains/peak.jpg light
```

Now they'll show up when toggling themes.

### Wallpapers not found
```bash
~/.cloudyy_scripts/theme_controller.sh debug
```
Check that `~/Wallpapers/Dark` and/or `~/Wallpapers/Light` exist and contain images.

### Colors not updating
1. Verify matugen is installed: `which matugen`
2. Check template syntax: `cat ~/.config/matugen/templates/colors-swaync.css`
3. Test manually: `matugen image ~/Wallpapers/Dark/wallpaper.jpg -m dark`
4. Watch generated files: `ls -la ~/.config/matugen/generated/`

### Apps not reloading
- **swaync**: Restarts on config change automatically
- **waybar**: Monitors `~/.config/waybar/colors.css` file changes
- **kitty**: Run `kitty @ set-colors -a /path/to/colors.conf` or restart
- **Hyprland**: `hyprctl reload` is called automatically via post_hook

### Permission denied on theme_controller.sh
```bash
chmod +x ~/.cloudyy_scripts/theme_controller.sh
```

## Environment Variables

After `theme_controller.sh` runs, these are available for shell configs:

```bash
source ~/.config/hypr/theme_state/system_theme.env

# Available variables:
# GTK_THEME_VARIANT="dark" or "light"
# QT_STYLE_OVERRIDE="kvantum-dark" or "kvantum-light"
# COLORFGBG="0;7" (dark) or "7;0" (light)
```

Use in `~/.zshrc` or `~/.bashrc`:
```bash
[[ -f ~/.config/hypr/theme_state/system_theme.env ]] && source ~/.config/hypr/theme_state/system_theme.env
```

## Performance Notes

- **Wallpaper transition** — Non-blocking, runs in parallel with color generation
- **Matugen** — ~500ms to generate colors (file-locked to prevent corruption)
- **Post-hooks** — Run sequentially after colors are generated
- **No CPU spike** — SwayNC specifically avoids `backdrop-filter: blur()` in CSS to prevent continuous redraws

## Credits

Ported from [cloudyy-linux](https://github.com/cloudyy-linux) theme system.
Adapted for arch-dots with multi-app support and enhanced state management.
