local util = require("theme.util")

local M = {}

M.name = "foot"

M.path = "foot"
M.filename = "theme.ini"

M.gen = function(schema)
	local sch = util.remove_hashtag_from_schema(schema)
	local template = util.template(
		[[
# Catppuccin Macchiato

[colors]
foreground=${white1}
background=${dark0}

regular0=${grey}
regular1=${red1}
regular2=${green1}
regular3=${orange1}
regular4=${blue1}
regular5=${purple1}
regular6=${aqua1}
regular7=${white1}

bright0=${grey1}
bright1=${red2}
bright2=${green2}
bright3=${orange2}
bright4=${blue2}
bright5=${purple2}
bright6=${aqua2}
bright7=${white2}

selection-foreground=${white}
selection-background=${dark1}

search-box-no-match=${dark1} ${red1}
search-box-match=${dark1} ${green1}

jump-labels=${dark1} ${blue1}
urls=${aqua1}
    ]],
		sch
	)

	return template
end

return M
