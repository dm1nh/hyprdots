import GLib from "gi://GLib?version=2.0"

export const COMPILED_DIR = `${GLib.get_user_cache_dir()}/ags/user/generated`

async function style() {
  const input = `${App.configDir}/styles/main.scss`
  const output = `${COMPILED_DIR}/styles.css`
  Utils.exec(`mkdir -p ${COMPILED_DIR}`)
  Utils.exec(`sass ${input} ${output}`)
  App.resetCss()
  App.applyCss(output)
  console.log("Styles loaded")
}

style().catch((err) => console.log(err))
