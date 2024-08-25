import icons from "lib/icons"

const hyprland = await Service.import("hyprland")

export default function ActiveClient() {
  return Widget.Box({
    className: "active-client",
    spacing: 8,
    children: [
      Widget.Icon({
        icon: hyprland.active.client
          .bind("class")
          .as((cls) => (Utils.lookUpIcon(cls) ? cls : icons.clients[cls] ?? icons.clients.default)),
        size: 16,
      }),
      Widget.Label({
        label: hyprland.active.client.bind("title").as((title) => (title !== "" ? title : "Start some cool projects!")),
        maxWidthChars: 80,
        truncate: "end",
      }),
    ],
  })
}
