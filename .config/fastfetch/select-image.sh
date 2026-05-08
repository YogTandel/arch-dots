#!/usr/bin/env bash
# =============================================================================
# select-image.sh — Random fastfetch image selector
# =============================================================================
# Randomly selects an image from organized folders
# Usage: source this or use directly in fastfetch config

set -uo pipefail

# Image folders (in priority order)
readonly IMAGES_DIR="${HOME}/.config/fastfetch/images"
declare -a FOLDERS=("anime" "scenery" "abstract" "other")

# Find all images
get_random_image() {
    local images=()
    
    # Collect all images from all folders
    for folder in "${FOLDERS[@]}"; do
        local folder_path="${IMAGES_DIR}/${folder}"
        if [[ -d "$folder_path" ]]; then
            while IFS= read -r -d '' img; do
                images+=("$img")
            done < <(find "$folder_path" -maxdepth 1 \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" \) -print0)
        fi
    done
    
    # If no images found, fall back to any in base directory
    if [[ ${#images[@]} -eq 0 ]]; then
        while IFS= read -r -d '' img; do
            images+=("$img")
        done < <(find "${IMAGES_DIR}" -maxdepth 1 \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" \) -print0)
    fi
    
    # If still no images, check old location
    if [[ ${#images[@]} -eq 0 ]] && [[ -f "${HOME}/.config/fastfetch/image.png" ]]; then
        echo "${HOME}/.config/fastfetch/image.png"
        return 0
    fi
    
    # Return random image
    if [[ ${#images[@]} -gt 0 ]]; then
        local idx=$((RANDOM % ${#images[@]}))
        echo "${images[$idx]}"
    else
        echo "" >&2
        return 1
    fi
}

# Run if not sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    get_random_image
fi
