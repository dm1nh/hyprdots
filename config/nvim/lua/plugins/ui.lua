return {
	{ -- disable tabline
		"akinsho/bufferline.nvim",
		enabled = false,
	},

	{ -- disable lualine
		"nvim-lualine/lualine.nvim",
		enabled = false,
	},

	{ -- use my own statusline
		"dm1nh/statusline",
		event = "VeryLazy",
		dev = true,
		config = function()
			require("statusline").setup()
		end,
	},

	{
		"echasnovski/mini.icons",
		opts = {
			directory = require("config.defaults").override_icons.directory,
			file = require("config.defaults").override_icons.file,
			filetype = require("config.defaults").override_icons.filetype,
			extension = require("config.defaults").override_icons.extension,
		},
	},

	{ -- dashboard
		"folke/snacks.nvim",
		opts = {
			dashboard = {
				preset = {
					header = [[
██████╗ ███╗   ███╗ ██╗███╗   ██╗██╗  ██╗
██╔══██╗████╗ ████║███║████╗  ██║██║  ██║
██║  ██║██╔████╔██║╚██║██╔██╗ ██║███████║
██║  ██║██║╚██╔╝██║ ██║██║╚██╗██║██╔══██║
██████╔╝██║ ╚═╝ ██║ ██║██║ ╚████║██║  ██║
╚═════╝ ╚═╝     ╚═╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝
      ]],
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = "󰍉 ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = "󰺮 ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = "󰒓 ", key = "c", desc = "Configuration", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = "󱍷 ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = "󰈆 ", key = "q", desc = "Quit Neovim", action = ":qa" },
          },
				},
			},
		},
	},
}
