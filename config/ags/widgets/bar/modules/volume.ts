import ToggleButton from "../toggle-button"
import { sh } from "lib/utils"
import icons from "lib/icons"

const audio = await Service.import("audio")

export default function Volume() {
  const iconsByVolume = {
    101: "overamplified",
    51: "high",
    1: "low",
    0: "muted",
  }

  function getIcon() {
    const icon = audio.speaker.is_muted
      ? 0
      : [101, 51, 1, 0].find((threshold) => threshold <= audio.speaker.volume * 100)

    return icon ? icons.volume[iconsByVolume[icon]] : icons.volume.muted
  }

  function getVol() {
    return Math.floor(audio.speaker.volume * 100) + "%"
  }

  function toggle() {
    if (audio.speaker.is_muted) {
      audio.speaker.is_muted = false
    } else {
      audio.speaker.is_muted = true
    }
  }

  return ToggleButton({
    name: "volume",
    child: Widget.Box({
      spacing: 8,
      children: [
        Widget.Label({ label: Utils.watch(getIcon(), audio.speaker, getIcon) }),
        Widget.Label({ className: "percentage", label: Utils.watch(getVol(), audio.speaker, getVol) }),
      ],
    }),
    onClicked: toggle,
    onScrollUp: () => sh(`pamixer -i 5`),
    onScrollDown: () => sh(`pamixer -d 5`),
    onSecondaryClickRelease: () => sh(`pavucontrol`),
    connection: [audio.speaker, () => !audio.speaker.is_muted],
  })
}
