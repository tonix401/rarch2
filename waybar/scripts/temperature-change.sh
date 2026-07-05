#!/usr/bin/env bash
delta="$1"
current=$(hyprctl hyprsunset temperature 2>&1)
[[ "$current" =~ ^[0-9] ]] || exit 0
current=$(printf "%.0f" "$current")
new=$((current + delta))
[ "$new" -lt 3000 ] && exit 0
[ "$new" -gt 8000 ] && exit 0
hyprctl hyprsunset temperature "$new"
pkill -SIGRTMIN+9 waybar