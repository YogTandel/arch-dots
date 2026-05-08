#!/usr/bin/env bash
# =============================================================================
# tools.sh — Tools Menu
# =============================================================================

set -uo pipefail

readonly ROFI_DIR="${HOME}/.config/rofi/scripts"
source "${ROFI_DIR}/lib/common.sh"

show_tools_menu() {
  local choice
  choice=$(menu "Tools" \
    "󰀲 LocalSend")

  case "$choice" in
  "󰀲 LocalSend")
    localsend &
    ;;
  *) back_to_main ;;
  esac
}

show_tools_menu
