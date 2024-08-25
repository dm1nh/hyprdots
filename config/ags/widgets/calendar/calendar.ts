export default function Calendar() {
  return Widget.Window({
    className: "calendar",
    name: "calendar",
    anchor: ["bottom", "right"],
    visible: false,
    child: Widget.Box({
      child: Widget.Calendar({
        className: "calendar",
        showDayNames: true,
        showHeading: true,
      }),
    }),
  })
}
