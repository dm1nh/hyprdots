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

docs() {
  theme="~/.config/rofi/docs.rasi"
  killall -q rofi

  opt=$(printf "%s\n" $(ls ~/Documents) | rofi -dmenu -p "zathura" -theme $theme)

  if [ -z $opt ]; then
    exit 0
  fi

  zathura "~/Documents/$opt"
  exit 0
}

launcher() {
  theme="~/.config/rofi/launcher.rasi"
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
    ~/.config/hypr/scripts/util.sh lock
    ;;
  $suspend)
    systemctl suspend
    ;;
  esac
}

record() {
  pid=$(pidof wf-recorder)

  # TODO: How can I stop wf-recorder normally without damaging video file.
  if [ -n "$pid" ]; then
    notify-send "A recording instance has already running"
  else
    theme="~/.config/rofi/record.rasi"
    killall -q rofi

    # Options
    fullscreen_sound=""
    fullscreen=""
    sound=""
    selection=""

    # Variables passed to dmenu
    opts="$fullscreen_sound\n$fullscreen\n$sound\n$selection"

    opt=$(echo -e $opts | rofi -dmenu -p "wf-recorder" -theme $theme)

    if [ -z $opt ]; then
      exit 0
    fi

    case $opt in

    $fullscreen_sound)
      ~/.config/hypr/scripts/record.sh --fullscreen-sound
      ;;
    $fullscreen)
      ~/.config/hypr/scripts/record.sh --fullscreen
      ;;
    $sound)
      ~/.config/hypr/scripts/record.sh --sound
      ;;
    $selection)
      ~/.config/hypr/scripts/record.sh
      ;;
    esac
  fi
}

screenshot() {
  theme="~/.config/rofi/screenshot.rasi"

  killall -q rofi

  # Options
  fullscreen=""
  selection=""

  # Variables passed to dmenu
  opts="$fullscreen\n$selection"

  opt=$(echo -e $opts | rofi -dmenu -p "grim & swappy" -theme $theme)

  if [ -z $opt ]; then
    exit 0
  fi

  case $opt in
  $fullscreen)
    sleep 0.5
    ~/.config/hypr/scripts/screenshot.sh --fullscreen
    ;;
  $selection)
    sleep 0.5
    ~/.config/hypr/scripts/screenshot.sh --selection
    ;;
  esac
}

clients() {
  theme="~/.config/rofi/clients.rasi"

  killall -q rofi

  opt=$(hyprctl clients -j | jq -r '.[] | "\(.pid) :: \(.title)"' | rofi -dmenu -p "Clients" -theme $theme)

  if [ -z "$opt"]; then
    exit 0
  fi

  IFS=" :: " read -a splitted <<<"$opt"

  pid=${splitted[0]}

  if [ -z "$pid"]; then
    exit 0
  fi

  hyprctl dispatch focuswindow pid:$pid
  exit 0
}

case $1 in
colorpicker) colorpicker ;;
docs) docs ;;
launcher) launcher ;;
record) record ;;
screenshot) screenshot ;;
clients) clients ;;
quit) quit ;;
esac
