#!/usr/bin/env bash

colorpicker() {
  theme="~/.config/rofi/colorpicker.rasi"

  killall -q rofi

  # Options
  hex="HEX"
  rgb="RGB"
  hsl="HSL"

  # Variables passed to dmenu
  opts="$hex\n$rgb\n$hsl"
  opt=$(echo -e "$opts" | rofi -dmenu -p "hyprpicker" -theme $theme)

  if [ -z $opt ]; then
    exit 0
  fi

  sleep 1
  case $opt in
  $hex)
    ~/.config/hypr/scripts/colorpicker.sh --hex
    ;;
  $rgb)
    ~/.config/hypr/scripts/colorpicker.sh --rgb
    ;;
  $hsl)
    ~/.config/hypr/scripts/colorpicker.sh --hsl
    ;;
  esac
}

applauncher() {
  theme="~/.config/rofi/applauncher.rasi"
  killall -q rofi
  opt=$(rofi -show drun -theme $theme)

  if [ -z $opt ]; then
    exit 0
  fi
}

quit() {
  theme="~/.config/rofi/quit.rasi"
  uptime=$(uptime -p | sed -e 's/up //g')

  killall -q rofi

  # options
  suspend=""
  lock=""
  logout=""
  reboot=""
  shutdown=""

  # variables passed to dmenu
  opts="$suspend\n$lock\n$logout\n$reboot\n$shutdown"

  opt=$(echo -e $opts | rofi -dmenu -p "Uptime: $uptime" -theme $theme -selected-row 2)

  if [ -z $opt ]; then
    exit 0
  fi

  case $opt in
  $shutdown)
    poweroff
    ;;
  $reboot)
    reboot
    ;;
  $logout)
    hyprctl dispatch exit 0
    ;;
  $lock)
		swaylock
    ;;
  $suspend)
    systemctl suspend
    ;;
  esac
}

screenshot() {
  theme="~/.config/rofi/screenshot.rasi"

  killall -q rofi

  # Options
  fullscreen=""
  selection=""

  # Variables passed to dmenu
  opts="$screen\n$select"

  opt=$(echo -e $opts | rofi -dmenu -p "niri" -theme $theme)

  if [ -z $opt ]; then
    exit 0
  fi

  case $opt in
  $screen)
		niri msg action screenshot-screen
    ;;
  $select)
		niri msg action screenshot
    ;;
  esac
}

case $1 in
colorpicker) colorpicker ;;
applauncher) applauncher ;;
screenshot) screenshot ;;
quit) quit ;;
esac
