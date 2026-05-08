#!/usr/bin/env bash
# =============================================================================
# main.sh — arch-dots Dashboard (Entry Point)
# All submenus live in ~/.config/rofi/scripts/
# =============================================================================

set -uo pipefail

readonly ROFI_DIR="${HOME}/.config/rofi/scripts"
source "${ROFI_DIR}/lib/common.sh"

# =============================================================================
# DEPENDENCY CHECK
# =============================================================================

if ! command -v rofi &>/dev/null; then
  notify-send "Error" "rofi is not installed"
  exit 1
fi

init_dirs

# =============================================================================
# MAIN MENU
# =============================================================================

show_main_menu() {
  local choice
  choice=$(menu "Dashboard" \
    "󰛔 Tools\n󰈈 Appearance\n󰀻 Applications\n󰹑 System\n󰙵 Cloud Center\n󰏖 Packages\n󰚰 Update\n󰐥 Power")

  case "$choice" in
  "󰛔 Tools")        exec "${ROFI_DIR}/tools.sh" ;;
  "󰈈 Appearance")   exec "${ROFI_DIR}/appearance.sh" ;;
  "󰀻 Applications") exec "${ROFI_DIR}/applications.sh" ;;
  "󰹑 System")       exec "${ROFI_DIR}/system.sh" ;;
  "󰙵 Cloud Center") hyprctl dispatch exec "python3 ${HOME}/.config/cloud-center-v2/cloud-center.py" ;;
  "󰏖 Packages")     exec "${ROFI_DIR}/packages.sh" ;;
  "󰚰 Update")       kitty --hold -e yay -Syu ;;
  "󰐥 Power")        exec "${ROFI_DIR}/power-menu.sh" ;;
  *) exit 0 ;;
  esac
}

# =============================================================================
# CLI SHORTCUTS  (e.g. keybind: main.sh --appearance)
# =============================================================================

main() {
  if [[ -n "${1:-}" ]]; then
    case "$1" in
    --appearance)   exec "${ROFI_DIR}/appearance.sh" ;;
    --applications) exec "${ROFI_DIR}/applications.sh" ;;
    --packages)     exec "${ROFI_DIR}/packages.sh" ;;
    --power)        exec "${ROFI_DIR}/power-menu.sh" ;;
    *) show_main_menu ;;
    esac
  else
    show_main_menu
  fi
}

main "$@"
