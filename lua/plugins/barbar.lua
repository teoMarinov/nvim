if true then
	return {}
end
return {
	"romgrk/barbar.nvim",

	config = function()
		require("lazy").setup({
			{
				dependencies = {
					"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
					"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
				},

				init = function()
					vim.g.barbar_auto_setup = false
				end,

				opts = {
					sidebar_filetypes = {
						-- for Neo‑tree
						["neo-tree"] = {
							event = "BufWipeout",
							text = "Neo‑tree",
							align = "left",
						},

						NvimTree = true,
					},
					-- other barbar options here
				},

				version = "^1.0.0",
			},
		})
	end,
}
