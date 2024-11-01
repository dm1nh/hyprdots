import ToggleButton from "../toggle-button"

const time = Variable("00:00", {
  poll: [1000, 'date "+%H:%M"'],
})

const date = Variable("", {
  poll: [1000, 'date "+%a, %b %d"'],
})

export default function Clock() {
  return ToggleButton({
    name: "clock",
    label: time.bind(),
    tooltipText: date.bind(),
  })
}
