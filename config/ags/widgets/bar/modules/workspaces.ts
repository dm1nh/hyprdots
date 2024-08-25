import { range } from "lib/utils"

const hyprland = await Service.import("hyprland")

function dispatch(arg: string | number) {
  hyprland.messageAsync(`dispatch workspace ${arg}`)
}

export default function Workspaces() {
  return Widget.Box({
    class_name: "workspaces",
    child: Widget.Box({
      class_name: "workspace-box",
      spacing: 12,
      children: range(6).map((i) =>
        Widget.Button({
          className: "workspace-button",
          onClicked: () => dispatch(i),
          attribute: i,
          setup: (self) =>
            self.hook(hyprland, () => {
              self.toggleClassName("active", hyprland.active.workspace.id === i)
              self.toggleClassName("occupied", (hyprland.getWorkspace(i)?.windows || 0) > 0)
            }),
        })
      ),
    }),
  })
}
