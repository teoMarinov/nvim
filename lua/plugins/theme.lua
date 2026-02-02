return {
	{
		"ribru17/bamboo.nvim",

		lazy = false,
		priority = 1000,
		config = function()
			require("bamboo").setup({
				transparent = true,
				lualine = {
					transparent = true,
				},

				colors = {
					bg0 = "#131313",
				},

				code_style = {
					comments = { italic = true, bold = false },
					conditionals = { italic = false, bold = false },
					keywords = { bold = false },
					functions = { bold = false },
					namespaces = { italic = false, bold = false },
					parameters = { italic = false, bold = false },
					strings = { bold = false },
					variables = { bold = false },
				},
			})
		end,
	},

	{
		"catppuccin/nvim",

		name = "catppuccin",

		priority = 1000,

		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				float = {
					transparent = true,
				},
				no_italic = true,
				no_bold = true,
			})
		end,
	},
}
