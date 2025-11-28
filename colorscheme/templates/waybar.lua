local util = require("colorscheme.util")

local M = {}

M.name = "waybar"

M.path = "waybar"
M.filename = "colors.css"

M.gen = function(schema)
	local template = util.template(
		[[
/* ${theme} colorscheme for waybar */
/* ~/.config/waybar/colors.css */

@define-color bg ${bg};
@define-color bg_dark ${bg_dark};
@define-color bg_dark1 ${bg_dark1};
@define-color bg_highlight ${bg_highlight};
@define-color blue ${blue};
@define-color blue0 ${blue0};
@define-color blue1 ${blue1};
@define-color blue2 ${blue2};
@define-color blue5 ${blue5};
@define-color blue6 ${blue6};
@define-color blue7 ${blue7};
@define-color comment ${comment};
@define-color cyan ${cyan};
@define-color dark3 ${dark3};
@define-color dark5 ${dark5};
@define-color fg ${fg};
@define-color fg_dark ${fg_dark};
@define-color fg_gutter ${fg_gutter};
@define-color green ${green};
@define-color green1 ${green1};
@define-color green2 ${green2};
@define-color magenta ${magenta};
@define-color magenta2 ${magenta2};
@define-color orange ${orange};
@define-color purple ${purple};
@define-color red ${red};
@define-color red1 ${red1};
@define-color teal ${teal};
@define-color terminal_black ${terminal_black};
@define-color yellow ${yellow};
@define-color accent ${accent};]],
		schema
	)

	return template
end

return M
