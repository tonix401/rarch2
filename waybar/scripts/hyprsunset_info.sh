#!/usr/bin/env bash
gamma_raw=$(hyprctl hyprsunset gamma 2>&1)
temperature_raw=$(hyprctl hyprsunset temperature 2>&1)

if ! [[ "$gamma_raw" =~ ^[0-9] ]]; then
  echo '{"text":"--","tooltip":"hyprsunset not running","percentage":0}'
  exit 0
fi

gamma=$(printf "%.0f" "$gamma_raw")
temperature=$(printf "%.0f" "$temperature_raw")

min=20
max=100
pct=$(( (gamma - min) * 100 / (max - min) ))
[ "$pct" -lt 0 ] && pct=0
[ "$pct" -gt 100 ] && pct=100

jq -cn \
  --arg text "${pct}/${temperature}" \
  --arg tooltip "$(printf 'Gamma: %d\nTemperature: %dK' "$gamma" "$temperature")" \
  --argjson percentage "$pct" \
  '{text: $text, tooltip: $tooltip, percentage: $percentage}'
