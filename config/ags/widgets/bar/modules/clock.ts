import ToggleButton from "../toggle-button"

const time = Variable("", {
  poll: [1000, 'date "+%H:%M"'],
})

export default function Clock() {
  return ToggleButton({
    name: "clock",
    label: time.bind(),
    onClicked: () => App.toggleWindow("calendar"),
  })
}
