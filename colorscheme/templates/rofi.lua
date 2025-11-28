local util = require("colorscheme.util")

local M = {}

M.name = "rofi"

M.path = "rofi"
M.filename = "colors.rasi"

M.gen = function(schema)
	local template = util.template(
		[[
/* ${theme} colorscheme for rofi */
/* ~/.config/rofi/colors.rasi */
* {
  none: #00000000;
	bg: ${bg};
	bg-dark: ${bg_dark};
	bg-dark1: ${bg_dark1};
	bg-highlight: ${bg_highlight};
	blue: ${blue};
	blue0: ${blue0};
	blue1: ${blue1};
	blue2: ${blue2};
	blue5: ${blue5};
	blue6: ${blue6};
	blue7: ${blue7};
	comment: ${comment};
	cyan: ${cyan};
	dark3: ${dark3};
	dark5: ${dark5};
	fg: ${fg};
	fg-dark: ${fg_dark};
	fg-gutter: ${fg_gutter};
	green: ${green};
	green1: ${green1};
	green2: ${green2};
	magenta: ${magenta};
	magenta2: ${magenta2};
	orange: ${orange};
	purple: ${purple};
	red: ${red};
	red1: ${red1};
	teal: ${teal};
	terminal-black: ${terminal_black};
	yellow: ${yellow};
	accent: ${accent};
}]],
		schema
	)

	return template
end

return M
