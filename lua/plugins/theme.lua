return {
	{
		"ribru17/bamboo.nvim",

		lazy = false,

		priority = 1000,

		config = function()
			require("bamboo").setup({})

			require("bamboo").load()
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

	config = function()
		vim.cmd.colorscheme("bamboo")
	end,
}
