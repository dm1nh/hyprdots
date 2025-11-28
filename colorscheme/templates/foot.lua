local util = require("colorscheme.util")

local M = {}

M.name = "foot"

M.path = "foot"
M.filename = "colors.ini"

M.gen = function(schema)
	local sch = util.convert(schema)
	local template = util.template(
		[[
# ${theme} colorscheme for foot
[colors]
foreground=${fg}
background=${bg}

cursor=${bg} ${accent}

regular0=${terminal_black}
regular1=${red}
regular2=${green}
regular3=${yellow}
regular4=${blue}
regular5=${magenta}
regular6=${cyan}
regular7=${fg}


bright0=${terminal_black}
bright1=${red}
bright2=${green}
bright3=${yellow}
bright4=${blue}
bright5=${magenta}
bright6=${cyan}
bright7=${fg}

selection-foreground=${bg}
selection-background=${accent}

search-box-no-match=${bg} ${green}
search-box-match=${bg} ${red}

jump-labels=${bg} ${magenta2}
urls=${blue0}]],
		sch
	)

	return template
end

return M
