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
├── config.jsonc         # Fastfetch config (uses cache-managed current image)
└── fastfetch-image-setup.sh
```

The active image is generated at:

```bash
~/.cache/fastfetch/current-image.png
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

3. **Auto-randomize on session startup:**

   Hyprland runs this once at session start:
   ```bash
   exec-once = ~/.config/fastfetch/fastfetch-image-setup.sh
   ```

## Usage

**Run fastfetch with random image:**
```bash
~/.config/fastfetch/fastfetch-image-setup.sh
fastfetch
```

**Change image manually:**
```bash
~/.config/fastfetch/fastfetch-image-setup.sh
```

**View current image:**
```bash
file ~/.cache/fastfetch/current-image.png
```

## Notes

- The `~/.cache/fastfetch/current-image.png` symlink always points to the current random image
- `config.jsonc` reads from the generated cache path
- `.zshrc` only runs `fastfetch`; it does not change the image on every new terminal
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
