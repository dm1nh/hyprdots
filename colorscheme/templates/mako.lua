local util = require("colorscheme.util")

local M = {}

M.name = "mako"

M.path = "mako"
M.filename = "config"

M.gen = function(schema)
	local template = util.template(
		[[# Mako config with ${theme} colorscheme
max-history=5
sort=-time

max-icon-size=48
icon-path=/usr/share/icons/Papirus-Dark:/usr/share/icons/hicolor
font=HollowNight Nerd Font 14
width=360
height=200
margin=6
padding=12
border-size=2
border-radius=12

background-color=${bg_dark1}
text-color=${fg}
border-color=${accent}
progress-color=${accent}

# Urgency overrides
[urgency=low]
border-color=${accent}
default-timeout=2000

[urgency=normal]
border-color=${accent}
default-timeout=3000

[urgency=high]
background-color=${bg_dark1}
text-color=${fg}
border-color=${red}
default-timeout=0
		]],
		schema
	)

	return template
end

return M
