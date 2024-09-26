#!/usr/bin/env bash

lock() {
  pkill hyprlock
  hyprlock &
}

gsettings() {
  config="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini"
  if [ ! -f "$config" ]; then exit 1; fi

  gnome_schema="org.gnome.desktop.interface"
  gtk_theme="$(grep 'gtk-theme-name' "$config" | sed 's/.*\s*=\s*//')"
  icon_theme="$(grep 'gtk-icon-theme-name' "$config" | sed 's/.*\s*=\s*//')"
  cursor_theme="$(grep 'gtk-cursor-theme-name' "$config" | sed 's/.*\s*=\s*//')"
  font_name="$(grep 'gtk-font-name' "$config" | sed 's/.*\s*=\s*//')"
  gsettings set "$gnome_schema" gtk-theme "$gtk_theme"
  gsettings set "$gnome_schema" icon-theme "$icon_theme"
  gsettings set "$gnome_schema" cursor-theme "$cursor_theme"
  gsettings set "$gnome_schema" font-name "$font_name"
}

portal() {
  sleep 1
  killall -e xdg-desktop-portal-hyprland
  killall -e xdg-desktop-portal-wlr
  killall xdg-desktop-portal
  /usr/lib/xdg-desktop-portal-hyprland &
  sleep 2
  /usr/lib/xdg-desktop-portal &
}

case $1 in
lock)
  lock
  ;;
gsettings)
  gsettings
  ;;
portal)
  portal
  ;;
esac
