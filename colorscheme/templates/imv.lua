local util = require("colorscheme.util")

local M = {}

M.name = "imv"

M.path = "imv"
M.filename = "config"

M.gen = function(schema)
	local template = util.template(
		[[
# ${theme} for imv
# ~/.config/imv/config

# styling
[options]
background = ${dark1}
fullscreen = false
overlay = true
overlay_text_color = ${white1}
overlay_background_color = ${dark2}
overlay_background_alpha = ff
overlay_font = Galax Nerd Font Regular:16
overlay_position_bottom = false

# bindings
[binds]
j = next
k = prev]],
		schema
	)

	return template
end

return M
