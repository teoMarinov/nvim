return {
	"stevearc/oil.nvim",

	dependencies = { { "echasnovski/mini.icons", opts = {} } },

	opts = {},

	lazy = false,

	config = function()
		require("oil").setup({
			default_file_explorer = true,

			columns = {
				"icon",
			},

			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false,
			},

			win_options = {
				signcolumn = "yes",
			},

			delete_to_trash = false,

			view_options = {
				show_hidden = true,
			},
		})
	end,
}
