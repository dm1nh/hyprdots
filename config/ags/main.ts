import { COMPILED_DIR } from "styles/styles"
import Bar from "widgets/bar/bar"
import NotificationPopups from "widgets/notifications/notification-popups"

App.config({
  style: `${COMPILED_DIR}/styles.css`,
  windows: [Bar(), NotificationPopups(0)],
})
