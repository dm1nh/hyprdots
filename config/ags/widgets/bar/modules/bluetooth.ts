import icons from "lib/icons"
import { sh } from "lib/utils"
import ToggleButton from "../toggle-button"

const bluetooth = await Service.import("bluetooth")

const icon = Widget.Icon({
  icon: bluetooth.bind("enabled").as((on) => (on ? icons.bluetooth.enabled : icons.bluetooth.disabled)),
})

function toggle() {
  if (bluetooth.enabled) {
    bluetooth.enabled = false
    Utils.notify({
      iconName: icons.bluetooth.enabled,
      summary: "Bluetooth",
      body: "Off",
    })
  } else {
    bluetooth.enabled = true
    Utils.notify({
      iconName: icons.bluetooth.enabled,
      summary: "Bluetooth",
      body: "On",
    })
  }
}

export default function Bluetooth() {
  return ToggleButton({
    name: "bluetooth",
    onClicked: toggle,
    onSecondaryClickRelease: () => sh("blueman-manager"),
    connection: [bluetooth, () => bluetooth.enabled],
    child: icon,
  })
}
