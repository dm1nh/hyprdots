return {
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"mason-org/mason.nvim",
				cmd = "Mason",
				keys = { { "<leader>cm", "<cmd>Mason<r>", desc = "Mason" } },
				build = ":MasonUpdate",
				opts = {
					ensure_installed = { "stylua", "shfmt" },
				},
			},
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"saghen/blink.cmp",
		},
		opts = {
			servers = {
				["*"] = {
					capabilities = {
						workspace = {
							fileOperations = {
								didRename = true,
								willRename = true,
							},
						},
					},
					keys = {
						{ "<leader>cl", "<cmd>LspInfo<cr>", { desc = "LspInfo" } },
						{ "gd", vim.lsp.buf.definition, { desc = "Goto Definition" } },
					},
				},
				lua_ls = {
					-- mason = false, -- set to false if you don't want this server to be installed with mason
					-- Use this to add any additional keymaps
					-- for specific lsp servers
					-- ---@type LazyKeysSpec[]
					-- keys = {},
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							codeLens = {
								enable = true,
							},
							completion = {
								callSnippet = "Replace",
							},
							doc = {
								privateName = { "^_" },
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
						},
					},
				},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts: vim.lsp.Config):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
		config = function(_, opts)
			if opts.servers["*"] then
				vim.lsp.config("*", opts.servers["*"])
			end

			local mason_exclude = {} --@type string[]
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local configure = function(server)
				if server == "*" then
					return false
				end
				local server_opts = opts.servers[server] or {}
				server_opts.capabilities =
					vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})

				local setup = opts.setup[server] or opts.setup["*"]
				if setup and setup(server, server_opts) then
					mason_exclude[#mason_exclude + 1] = server
				else
					vim.lsp.config(server, server_opts)
				end
				return true
			end

			local ensure_installed = vim.tbl_filter(configure, vim.tbl_keys(opts.servers or {}))
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_enable = { exclude = mason_exclude },
			})
		end,
	},
}
