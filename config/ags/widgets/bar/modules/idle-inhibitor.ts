import ToggleButton from "../toggle-button"
import { sh } from "lib/utils"
import icons from "lib/icons"

const enabled = Variable(false, {
  listen: ["pgrep hypridle", (out) => !out],
})

const icon = Widget.Label({
  label: enabled.bind().as((value) => (value ? icons.idleInhibitor.enabled : icons.idleInhibitor.disabled)),
})

function toggle() {
  if (enabled.value) {
    enabled.setValue(false)
    sh(`hypridle &`)
  } else {
    enabled.setValue(true)
    sh(`pkill hypridle`)
  }
}

export default function IdleInhibitor() {
  return ToggleButton({
    name: "idle",
    child: icon,
    tooltipText: enabled.bind().as((value) => (value ? "Enabled" : "Disabled")),
    onClicked: toggle,
    connection: [enabled, () => enabled.value],
  })
}
