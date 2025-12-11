-- if true then return {} end
return {
	{
		"nvim-neo-tree/neo-tree.nvim",

		branch = "v3.x",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},

		lazy = false, -- neo-tree will load immediately

		config = function()
			require("neo-tree").setup({
				filesystem = {
					filtered_items = {
						visible = true, -- show filtered/hidden files
						hide_dotfiles = false, -- don't hide dotfiles
					},

					follow_current_file = { enabled = true }, -- optional: don't automatically follow files
					hijack_netrw_behavior = "open_default", -- open in the current working directory
					use_libuv_file_watcher = true,
				},

				open_files_do_not_replace_types = { "oil" },
				auto_clean_after_session_restore = true,

				window = {
					position = "left",
					width = 30,
				},

				default_component_configs = {
					indent = { padding = 1 },
				},
			})
		end,
	},
}
