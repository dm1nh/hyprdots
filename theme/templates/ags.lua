local util = require("theme.util")

local M = {}

M.name = "ags"

M.path = "ags/styles"
M.filename = "_palette.scss"

M.gen = function(schema)
	local template = util.template(
		[[
/* ${theme} colorscheme for eww */
/* ~/.config/ags/styles/_palette.scss */
  $accent:       ${accent};
  $dark:         ${dark};
  $dark0:        ${dark0};
  $dark1:        ${dark1};
  $dark2:        ${dark2};
  $dark3:        ${dark3};
  $dark4:        ${dark4};
  $dark5:        ${dark5};
  $white:        ${white};
  $white0:       ${white0};
  $white1:       ${white1};
  $white2:       ${white2};
  $red:          ${red};
  $red0:         ${red0};
  $red1:         ${red1};
  $red2:         ${red2};
  $orange:        ${orange};
  $orange0:       ${orange0};
  $orange1:       ${orange1};
  $orange2:       ${orange2};
  $yellow:       ${yellow};
  $yellow0:      ${yellow0};
  $yellow1:      ${yellow1};
  $yellow2:      ${yellow2};
  $green:        ${green};
  $green0:       ${green0};
  $green1:       ${green1};
  $green2:       ${green2};
  $aqua:         ${aqua};
  $aqua0:        ${aqua0};
  $aqua1:        ${aqua1};
  $aqua2:        ${aqua2};
  $blue:         ${blue};
  $blue0:        ${blue0};
  $blue1:        ${blue1};
  $blue2:        ${blue2};
  $purple:       ${purple};
  $purple0:      ${purple0};
  $purple1:      ${purple1};
  $purple2:      ${purple2};
  $magenta:      ${magenta};
  $magenta0:     ${magenta0};
  $magenta1:     ${magenta1};
  $magenta2:     ${magenta2};

]],
		schema
	)

	return template
end

return M
