import Workspaces from "./modules/workspaces"
import Clock from "./modules/clock"
import ActiveClient from "./modules/active-client"
import Volume from "./modules/volume"
import IdleInhibitor from "./modules/idle-inhibitor"

export default function Bar() {
  return Widget.Window({
    className: "bar",
    name: "bar",
    anchor: ["bottom", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      className: "bar-box",
      start_widget: Widget.Box({
        hexpand: true,
        spacing: 24,
        children: [Workspaces(), ActiveClient()],
      }),
      center_widget: Widget.Box({
        hexpand: true,
        children: [],
      }),
      end_widget: Widget.Box({
        hpack: "end",
        hexpand: true,
        spacing: 16,
        children: [Volume(), IdleInhibitor(), Clock()],
      }),
    }),
  })
}
