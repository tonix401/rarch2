#!/usr/bin/env bash
delta="$1"
current=$(hyprctl hyprsunset gamma 2>&1)
[[ "$current" =~ ^[0-9] ]] || exit 0
current=$(printf "%.0f" "$current")
new=$((current + delta))
[ "$new" -lt 20 ] && exit 0
[ "$new" -gt 100 ] && exit 0
hyprctl hyprsunset gamma "$new"
pkill -SIGRTMIN+9 waybar
