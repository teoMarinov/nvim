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
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				"prettier",
				"eslint",
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
