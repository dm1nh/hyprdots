local util = require("colorscheme.util")

local M = {}

M.name = "hyprland"

M.path = "hypr"
M.filename = "colors.conf"

M.gen = function(schema)
	local sch = util.convert(schema)
	local template = util.template(
		[[
# ${theme} colorscheme for hyprland
	$bg = ${bg}
	$bg_dark = ${bg_dark}
	$bg_dark1 = ${bg_dark1}
	$bg_highlight = ${bg_highlight}
	$blue = ${blue}
	$blue0 = ${blue0}
	$blue1 = ${blue1}
	$blue2 = ${blue2}
	$blue5 = ${blue5}
	$blue6 = ${blue6}
	$blue7 = ${blue7}
	$comment = ${comment}
	$cyan = ${cyan}
	$dark3 = ${dark3}
	$dark5 = ${dark5}
	$fg = ${fg}
	$fg_dark = ${fg_dark}
	$fg_gutter = ${fg_gutter}
	$green = ${green}
	$green1 = ${green1}
	$green2 = ${green2}
	$magenta = ${magenta}
	$magenta2 = ${magenta2}
	$orange = ${orange}
	$purple = ${purple}
	$red = ${red}
	$red1 = ${red1}
	$teal = ${teal}
	$terminal_black = ${terminal_black}
	$yellow = ${yellow}
	$accent = ${accent}
]],
		sch
	)

	return template
end

return M
