local templates = {
	"ags",
	"alacritty",
	"btop",
	"fish",
	"hyprland",
	"imv",
	"interstellar-gtk",
	"interstellar-darker-gtk",
	"rofi",
	"sddm-astronaut-theme",
	"zathura",
}

local modules = {}

for _, t in ipairs(templates) do
	modules[t] = require("theme.templates." .. t)
end

return modules
