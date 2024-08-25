import type GObject from "gi://GObject?version=2.0"
import { type ButtonProps } from "types/widgets/button"

type ToggleButtonProps = ButtonProps & {
  name: string
  connection?: [GObject.Object | undefined, (() => boolean) | undefined]
  activate?: (self: any) => void
  deactivate?: (self: any) => void
}

export default function ToggleButton({
  name,
  connection: [service, condition] = [undefined, undefined],
  activate,
  deactivate,
  setup,
  ...props
}: ToggleButtonProps) {
  return Widget.Button({
    className: `toggle-button ${name}`,
    setup: (self) => {
      if (service && condition) {
        self.hook(service, () => {
          self.toggleClassName("active", condition())

          if (condition()) {
            activate?.(self)
          } else {
            deactivate?.(self)
          }
        })
      }

      if (setup) setup(self)
    },
    ...props,
  })
}
