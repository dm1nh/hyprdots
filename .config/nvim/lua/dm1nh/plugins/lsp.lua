return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim" },
			{ "mason-org/mason-lspconfig.nvim" },
			{
				"j-hui/fidget.nvim",
				opts = {},
			},
		},
		config = vim.schedule_wrap(function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					---@param opts vim.keymap.set.Opts
					local map = function(keys, func, opts, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, vim.tbl_extend("force", opts, { buffer = event.buf }))
					end

					map("<leader>cl", "<cmd>LspInfo<cr>", { desc = "LSP Info" })
					map("gd", vim.lsp.buf.definition, { desc = "Goto definition" })
					map("gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
					map("gr", vim.lsp.buf.references, { desc = "Goto references", nowait = true })
					map("gy", vim.lsp.buf.type_definition, { desc = "Goto type definitions" })
					map("K", vim.lsp.buf.hover, { desc = "Hover" })
					map("gK", vim.lsp.buf.signature_help, { desc = "Signature help" })
					map("<c-k>", vim.lsp.buf.signature_help, { desc = "Signature help" }, "i")
					map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" }, { "n", "x" })
					map("<leader>cc", vim.lsp.codelens.run, { desc = "Codelens run" }, { "n", "x" })
					map("<leader>cC", vim.lsp.codelens.refresh, { desc = "Codelens refresh" })
					map("<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if
						client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, { desc = "Toggle inlay hints" })
					end
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			-- Ensure the servers and tools above are installed
			--
			-- To check the current status of installed tools and/or manually install
			-- other tools, you can run
			--    :Mason
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"texlab",
				},
				automatic_enable = true,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "Lua 5.1" },
						diagnostics = {
							globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
						},
					},
				},
			})

			-- Manually set up servers not in the registry
			vim.lsp.config("gdscript", {})
			vim.lsp.enable("gdscript")
		end),
	},
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
}
