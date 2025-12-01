local templates = {
	"btop",
	"fish",
	"foot",
	"hyprland",
	"imv",
	"mako",
	"rofi",
	"sddm-astronaut-theme",
	"waybar",
	"zathura",
}

local modules = {}

for _, t in ipairs(templates) do
	modules[t] = require("colorscheme.templates." .. t)
end

return modules
