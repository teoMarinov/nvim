return {
	"nvim-treesitter/nvim-treesitter",

	branch = "master",

	dependencies = { "windwp/nvim-ts-autotag" },

	lazy = false,

	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = true,

			ensure_installed = {
				"lua",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"jsdoc",
				"json",
				"csv",
				"yaml",
			},

			ignore_install = {},

			indent = { enable = true },

			highlight = { enable = true },
		})
	end,
}
