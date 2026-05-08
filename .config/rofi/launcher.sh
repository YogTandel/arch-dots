#!/usr/bin/env bash
# =============================================================================
# launcher.sh — arch-dots Rofi Entry Point
# Launches the main dashboard which chains into all submenus
# =============================================================================

exec "${HOME}/.config/rofi/scripts/main.sh" "$@"
