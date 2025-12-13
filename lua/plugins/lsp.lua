return {
	{
		"folke/lazydev.nvim",

		ft = "lua",

		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"neovim/nvim-lspconfig",

		dependencies = {
			{ "williamboman/mason.nvim", config = true },

			"williamboman/mason-lspconfig.nvim",

			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },

			"saghen/blink.cmp",
		},

		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					--  Most Language Servers support renaming across files, etc.
					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

					map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					-- Highligh on hover
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- Toggle inline hints
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

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

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local servers = {
				ts_ls = {
					settings = {
						single_file_suport = false,

						init_options = {
							hostInfo = "neovim",
							preference = { includeCompletionsForModuleExports = true },
						},
					},
				},

				eslint = {
					on_attach = function(_, buffer)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = buffer,
							command = "EslintFixAll",
						})
					end,
				},

				lua_ls = {},
				pyright = {},
				ruff = {},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				"prettier",
				"eslint",
				"ruff",
				"black",
				"isort",
			})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}

						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{
		"saghen/blink.cmp",

		version = "*",

		opts = {
			keymap = { preset = "enter" },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
	},
}

-- return {
--   {
--     "hrsh7th/nvim-cmp",
--
--     dependencies = {
--       "hrsh7th/cmp-nvim-lsp",         -- LSP source for nvim-cmp
--       "hrsh7th/cmp-buffer",           -- Source for buffer words
--       "hrsh7th/cmp-path",             -- Source for filesystem paths
--       "L3MON4D3/LuaSnip",             -- Snippet engine
--       "saadparwaiz1/cmp_luasnip",     -- LuaSnip completion source
--       "rafamadriz/friendly-snippets", -- Predefined snippets
--     },
--
--     config = function()
--       local cmp = require("cmp")
--       local luasnip = require("luasnip")
--
--       require("luasnip.loaders.from_vscode").lazy_load()
--
--       cmp.setup({
--         snippet = {
--           expand = function(args)
--             luasnip.lsp_expand(args.body)
--           end,
--         },
--
--         window = {
--           completion = cmp.config.window.bordered(),
--           documentation = cmp.config.window.bordered(),
--         },
--
--         mapping = cmp.mapping.preset.insert({
--           ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--           ["<C-f>"] = cmp.mapping.scroll_docs(4),
--           ["<C-Space>"] = cmp.mapping.complete(),
--           ["<CR>"] = cmp.mapping.confirm({ select = true }),
--         }),
--
--         sources = cmp.config.sources({
--           { name = "nvim_lsp", group_index = 2 },
--           { name = "luasnip",  group_index = 2 },
--           { name = "buffer",   group_index = 2 },
--           { name = "path",     group_index = 2 },
--         }),
--       })
--     end,
--   },
--
--   {
--     "neovim/nvim-lspconfig",
--
--     dependencies = {
--       "hrsh7th/cmp-nvim-lsp",
--       "williamboman/mason.nvim",
--       "williamboman/mason-lspconfig.nvim",
--     },
--
--     config = function()
--       local util = require("lspconfig.util")
--
--       vim.lsp.config("tsserver", {
--         settings = {
--           root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"),
--           single_file_suport = false,
--
--           init_options = {
--             hostInfo = "neovim",
--
--             preference = {
--               includeCompletionsForModuleExports = true,
--             },
--           },
--         },
--       })
--     end,
--   },
--
--   {
--     "ray-x/lsp_signature.nvim",
--     event = "VeryLazy",
--     opts = {},
--     config = function(_, opts)
--       require("lsp_signature").setup(opts)
--     end,
--   },
--
--   {
--     "williamboman/mason.nvim",
--
--     dependencies = { "williamboman/mason-lspconfig.nvim" },
--
--     config = function()
--       require("mason").setup()
--       local mason_lspconfig = require("mason-lspconfig")
--
--       mason_lspconfig.setup({
--         automatic_installation = false,
--       })
--     end,
--
--   },
--
--   {
--     "nvimtools/none-ls.nvim",
--
--     dependencies = {
--       "nvimtools/none-ls-extras.nvim",
--     },
--
--     config = function()
--       local null_ls = require("null-ls")
--
--       null_ls.setup({
--         sources = {
--           null_ls.builtins.formatting.stylua,
--           null_ls.builtins.formatting.prettier,
--         },
--       })
--     end,
--   },
-- }
