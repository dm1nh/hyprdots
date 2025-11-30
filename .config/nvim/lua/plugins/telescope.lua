-- Fuzzy Finder (files, lsp, etc)
return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-tree/nvim-web-devicons" },
	},
	keys = function()
		local builtin = require("telescope.builtin")
		return {
			{ "<leader>sb", builtin.buffers, { desc = "Buffers" } },
			{ "<leader>sf", builtin.find_files, { desc = "Files" } },
			{ "<leader>sg", builtin.live_grep, { desc = "Grep" } },
			{ "<leader>sh", builtin.help_tags, { desc = "Help tags" } },
			{ "<leader>sk", builtin.keymaps, { desc = "Keymaps" } },
			{ "<leader>ss", builtin.builtin, { desc = "Select telescopes" } },
			{ "<leader>sw", builtin.grep_string, { desc = "Search current word" } },
			{ "<leader>sr", builtin.resume, { desc = "Resume" } },
			{ "<leader>s.", builtin.oldfiles, { desc = "Recent files" } },
			{ "<leader><leader>", builtin.find_files, { desc = "Files" } },
			{ "<leader>/", builtin.live_grep, { desc = "Grep" } },

			{ "<leader>xx", builtin.diagnostics, { desc = "Diagnostics" } },
		}
	end,
	config = function()
		require("telescope").setup()

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
	end,
}
