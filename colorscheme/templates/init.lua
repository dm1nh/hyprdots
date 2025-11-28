local templates = {
	"btop",
	"dunst",
	"fish",
	"foot",
	"hyprland",
	"imv",
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
