#!/usr/bin/env bash

set -euo pipefail

readonly CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/wlogout"
readonly LAYOUT_FILE="${CONFIG_DIR}/layout"
readonly ICONS_DIR="${CONFIG_DIR}/icons"
readonly MATUGEN_COLORS="${XDG_CONFIG_HOME:-$HOME/.config}/matugen/generated/colors.css"
readonly TMP_CSS="/tmp/wlogout-${UID}.css"

readonly REF_HEIGHT=1080
readonly BASE_ICON_SIZE=100
readonly BASE_BUTTON_RAD=20
readonly BASE_ACTIVE_RAD=25
readonly BASE_MARGIN=60
readonly BASE_HOVER_OFFSET=15
readonly BASE_COL_SPACING=5

if [[ -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
  echo "ERROR: Not running inside Hyprland." >&2
  exit 1
fi

if [[ ! -f "$LAYOUT_FILE" ]]; then
  echo "ERROR: wlogout layout not found at $LAYOUT_FILE" >&2
  exit 1
fi

if [[ ! -d "$ICONS_DIR" ]]; then
  echo "ERROR: wlogout icons directory not found at $ICONS_DIR" >&2
  exit 1
fi

if pkill -x wlogout; then
  exit 0
fi

trap 'rm -f "$TMP_CSS"' EXIT

MON_DATA=$(hyprctl monitors -j 2>/dev/null | jq -r '
  (first(.[] | select(.focused)) // .[0] // {height: 1080, scale: 1})
  | "\(.height) \(.scale)"
')

read -r HEIGHT SCALE <<<"${MON_DATA:-1080 1}"

CALC_VARS=$(awk -v h="$HEIGHT" -v s="$SCALE" -v rh="$REF_HEIGHT" \
  -v i="$BASE_ICON_SIZE" -v br="$BASE_BUTTON_RAD" \
  -v ar="$BASE_ACTIVE_RAD" -v m="$BASE_MARGIN" \
  -v ho="$BASE_HOVER_OFFSET" -v cs="$BASE_COL_SPACING" '
BEGIN {
  ratio = (h / s) / rh;
  if (ratio < 0.5) ratio = 0.5;
  if (ratio > 2.0) ratio = 2.0;

  printf "%d %d %d %d %d %d",
    int(i * ratio), int(br * ratio), int(ar * ratio),
    int(m * ratio), int(ho * ratio), int(cs * ratio)
}')

read -r ICON_SIZE BTN_RAD ACT_RAD MARGIN HOVER_OFFSET COL_SPACING <<<"$CALC_VARS"
HOVER_MARGIN=$((MARGIN - HOVER_OFFSET))

{
  if [[ -f "$MATUGEN_COLORS" ]]; then
    printf '@import url("file://%s");\n\n' "$MATUGEN_COLORS"
  else
    cat <<'EOF'
@define-color primary #89b4fa;
@define-color on_primary #11111b;
@define-color secondary_container #313244;
@define-color on_secondary_container #cdd6f4;
@define-color tertiary_container #45475a;
@define-color on_tertiary_container #f5c2e7;
@define-color outline #6c7086;

EOF
  fi

  cat <<EOF
window {
  background-color: rgba(0, 0, 0, 0.6);
}

button {
  background-color: @secondary_container;
  color: @on_secondary_container;
  border: 2px solid @outline;
  border-radius: ${BTN_RAD}px;
  outline-style: none;
  background-repeat: no-repeat;
  background-position: center;
  background-size: ${ICON_SIZE}px ${ICON_SIZE}px;
  box-shadow: none;
  margin: 0;
  transition:
    background-color 0.2s ease,
    color 0.2s ease,
    border-radius 0.2s ease,
    margin 0.2s ease;
}

button:focus {
  background-color: @tertiary_container;
  color: @on_tertiary_container;
}

button:hover {
  background-color: @primary;
  color: @on_primary;
  border-radius: ${ACT_RAD}px;
}

#lock {
  background-image: url("file://${ICONS_DIR}/lock.png");
  margin: ${MARGIN}px 0;
}
button:hover#lock { margin: ${HOVER_MARGIN}px 0; }

#logout {
  background-image: url("file://${ICONS_DIR}/logout.png");
  margin: ${MARGIN}px 0;
}
button:hover#logout { margin: ${HOVER_MARGIN}px 0; }

#suspend {
  background-image: url("file://${ICONS_DIR}/suspend.png");
  margin: ${MARGIN}px 0;
}
button:hover#suspend { margin: ${HOVER_MARGIN}px 0; }

#reboot {
  background-image: url("file://${ICONS_DIR}/reboot.png");
  margin: ${MARGIN}px 0;
}
button:hover#reboot { margin: ${HOVER_MARGIN}px 0; }

#shutdown {
  background-image: url("file://${ICONS_DIR}/shutdown.png");
  margin: ${MARGIN}px 0;
}
button:hover#shutdown { margin: ${HOVER_MARGIN}px 0; }
EOF
} >"$TMP_CSS"

wlogout \
  --layout "$LAYOUT_FILE" \
  --css "$TMP_CSS" \
  --protocol layer-shell \
  --buttons-per-row 5 \
  --column-spacing "$COL_SPACING" \
  --row-spacing 0 \
  "$@"
