const hyprland = await Service.import("hyprland")

const icons = {
  default: "new-window-symbolic",
  alacritty: "utilities-terminal-symbolic",
  calc: "gnome-calculator-symbolic",
  pavucontrol: "sound-symbolic",
  btop: "utilities-system-monitor-symbolic",
}

export default function ActiveClient() {
  return Widget.Box({
    className: "active-client",
    spacing: 8,
    children: [
      Widget.Icon({
        icon: hyprland.active.client.bind("class").as((cls) => (Utils.lookUpIcon(cls) ? cls : icons[cls] ?? "")),
        size: 16,
      }),
      Widget.Label({
        label: hyprland.active.client.bind("class").as((cls) => cls),
        maxWidthChars: 80,
        truncate: "end",
      }),
    ],
  })
}
