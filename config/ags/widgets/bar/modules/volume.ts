import ToggleButton from "../toggle-button"
import { sh } from "lib/utils"
import icons from "lib/icons"

const audio = await Service.import("audio")

export default function Volume() {
  const iconsByVolume = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  }

  function getIcon() {
    const icon = audio.speaker.is_muted
      ? 0
      : [101, 67, 34, 1, 0].find((threshold) => threshold <= audio.speaker.volume * 100)

    return icon ? icons.audio.volume[iconsByVolume[icon]] : icons.audio.volume.muted
  }

  function toggle() {
    if (audio.speaker.is_muted) {
      audio.speaker.is_muted = false
      Utils.notify({
        iconName: icons.audio.volume.high,
        summary: "Volume",
        body: "On",
      })
    } else {
      audio.speaker.is_muted = true
      Utils.notify({
        iconName: icons.audio.volume.muted,
        summary: "Volume",
        body: "Muted",
      })
    }
  }

  const icon = ToggleButton({
    name: "volume",
    child: Widget.Icon({ icon: Utils.watch(getIcon(), audio.speaker, getIcon), size: 16 }),
    onClicked: toggle,
    onSecondaryClickRelease: () => sh("pavucontrol"),
    connection: [audio.speaker, () => !audio.speaker.is_muted],
  })

  const slider = Widget.Slider({
    hexpand: true,
    drawValue: false,
    on_change: ({ value }) => (audio.speaker.volume = value),
    setup: (self) =>
      self.hook(audio.speaker, () => {
        self.value = audio.speaker.volume || 0
        self.toggleClassName("active", !audio.speaker.is_muted)
      }),
  })

  return Widget.Box({
    className: "volume",
    css: "min-width: 128px",
    spacing: 8,
    children: [icon, slider],
  })
}
