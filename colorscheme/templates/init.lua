local templates = {
	"ags",
	"alacritty",
	"btop",
	"fish",
	"foot",
	"hyprland",
	"imv",
	-- "cozy-gtk",
	"rofi",
	"sddm-astronaut-theme",
	"zathura",
}

local modules = {}

for _, t in ipairs(templates) do
	modules[t] = require("colorscheme.templates." .. t)
end

return modules
