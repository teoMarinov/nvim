return {
	{
		"ribru17/bamboo.nvim",

		lazy = false,

		priority = 1000,

		config = function()
			require("bamboo").setup({})
		end,
	},

	{
		"folke/tokyonight.nvim",

		lazy = false,

		priority = 1000,

		opts = {},

		config = function()
			require("tokyonight")
		end,
	},

	{
		"catppuccin/nvim",

		name = "catppuccin",

		priority = 1000,

		config = function()
			require("catppuccin").setup()
		end,
	},

	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,

		config = function()
			require("nordic").setup({})
		end,
	},
}
