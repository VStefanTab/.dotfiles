#!/bin/sh

# --- Load user X resources (fonts, DPI, colors, etc.) ---
if [ -f ~/.Xresources ]; then
    xrdb -merge ~/.Xresources
fi

output=$(xrandr | awk '/ connected/{print $1; exit}')
xrandr --output "$output" --mode 2560x1600

# --- Set environment variables for scaling (optional) ---
# ---export GDK_SCALE=1
# ---export GDK_DPI_SCALE=1
# ---export QT_SCALE_FACTOR=1
# ---export XCURSOR_SIZE=24

# --- Start background services (optional) ---
# nm-applet &
# picom &
# feh --bg-fill ~/Pictures/wallpaper.jpg &

# --- Finally, start i3 ---
exec i3
