# Fastfetch Image Organization

Organize your fastfetch images into folders for better randomization and categorization.

## Folder Structure

```
~/.config/fastfetch/
├── images/
│   ├── anime/           # Anime/manga images
│   ├── scenery/         # Landscape/nature images
│   ├── abstract/        # Abstract art
│   └── other/           # Everything else
├── config.jsonc         # Fastfetch config (uses image.png symlink)
├── image.png           # Symlink to random image (auto-managed)
└── fastfetch-image-setup.sh
```

## Setup

1. **Organize your images:**
   ```bash
   # Move images to appropriate folders
   mv ~/Pictures/anime_girl.jpg ~/.config/fastfetch/images/anime/
   mv ~/Pictures/mountain.png ~/.config/fastfetch/images/scenery/
   ```

2. **Initialize the first image:**
   ```bash
   ~/.config/fastfetch/fastfetch-image-setup.sh
   ```

3. **Auto-randomize on startup (optional):**
   
   Add to your shell rc file (~/.bashrc or ~/.zshrc):
   ```bash
   # Randomize fastfetch image on shell start
   ~/.config/fastfetch/fastfetch-image-setup.sh &> /dev/null
   ```
   
   Or add to Hyprland config (~/.config/hypr/hyprland.conf):
   ```bash
   exec-once = ~/.config/fastfetch/fastfetch-image-setup.sh
   ```

## Usage

**Run fastfetch with random image:**
```bash
fastfetch
```

**Change image manually:**
```bash
~/.config/fastfetch/fastfetch-image-setup.sh
```

**View current image:**
```bash
file ~/.config/fastfetch/image.png
```

## Notes

- The `image.png` symlink always points to the current random image
- `config.jsonc` is unchanged and always reads from `image.png`
- Run `fastfetch-image-setup.sh` multiple times to cycle through images
- If no images exist, fastfetch will show no logo
- Supported formats: .jpg, .png, .gif

## Organizing Existing Images

**By theme:**
- **anime/** - Characters, anime scenes
- **scenery/** - Landscapes, nature, cities
- **abstract/** - Art, patterns, geometric
- **other/** - Logos, mixes, uncategorized

Or reorganize however you like! The script treats all folders equally.
