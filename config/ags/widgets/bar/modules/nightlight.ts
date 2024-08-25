import ToggleButton from "../toggle-button"
import { sh } from "lib/utils"
import icons from "lib/icons"

const enabled = Variable(false, {
  listen: ["pgrep wlsunset", (out) => !!out],
})

const icon = Widget.Icon({
  icon: enabled.bind().as((value) => (value ? icons.nightlight.enabled : icons.nightlight.disabled)),
})

function toggle() {
  if (enabled.value) {
    enabled.setValue(false)
    sh(`pkill wlsunset`)
    Utils.notify({
      iconName: icons.nightlight.disabled,
      summary: "Nightlight",
      body: "Off",
    })
  } else {
    enabled.setValue(true)
    sh(`wlsunset -T 5750 &`)
    Utils.notify({
      iconName: icons.nightlight.enabled,
      summary: "Nightlight",
      body: "On",
    })
  }
}

export default function Nightlight() {
  return ToggleButton({
    name: "nightlight",
    child: icon,
    onClicked: toggle,
    connection: [enabled, () => enabled.value],
  })
}
