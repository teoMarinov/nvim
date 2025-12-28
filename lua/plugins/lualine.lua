return {
	"nvim-lualine/lualine.nvim",

	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		require("lualine").setup({
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { {
					"filename",
					path = 1,
				} },
				lualine_x = {},
				lualine_y = { "lsp_status", "progress" },
				lualine_z = { "location" },
			},

			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},

			options = {
				globalstatus = true,
				theme = "nordic",
			},
		})
	end,
}
