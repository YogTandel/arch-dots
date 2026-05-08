#!/usr/bin/env bash
# =============================================================================
# fastfetch-image-setup.sh — Initialize and link random fastfetch image
# =============================================================================
# Sets up a symlink from ~/.config/fastfetch/image.png to a random image
# from the organized folders. Run this at startup or manually.

set -uo pipefail

readonly IMAGES_DIR="${HOME}/.config/fastfetch/images"
readonly IMAGE_LINK="${HOME}/.config/fastfetch/image.png"
declare -a FOLDERS=("anime" "scenery" "abstract" "other")

get_random_image() {
    local images=()
    
    # Collect all images from all folders
    for folder in "${FOLDERS[@]}"; do
        local folder_path="${IMAGES_DIR}/${folder}"
        if [[ -d "$folder_path" ]]; then
            while IFS= read -r -d '' img; do
                images+=("$img")
            done < <(find "$folder_path" -maxdepth 1 \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" \) -print0 2>/dev/null)
        fi
    done
    
    # Return random image
    if [[ ${#images[@]} -gt 0 ]]; then
        local idx=$((RANDOM % ${#images[@]}))
        echo "${images[$idx]}"
    else
        return 1
    fi
}

main() {
    local random_image
    random_image=$(get_random_image) || {
        echo "❌ No images found in ${IMAGES_DIR}" >&2
        return 1
    }
    
    # Remove old symlink if it exists
    if [[ -L "$IMAGE_LINK" ]]; then
        rm "$IMAGE_LINK"
    fi
    
    # Create new symlink
    ln -s "$random_image" "$IMAGE_LINK"
    echo "✓ Linked: $IMAGE_LINK → $(basename "$random_image")"
}

main "$@"
