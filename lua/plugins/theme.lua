-- return {
-- 	"folke/tokyonight.nvim",
--
-- 	lazy = false,
--
-- 	priority = 1000,
--
-- 	opts = {},
--
-- 	config = function()
-- 		require("tokyonight")
--
-- 		vim.cmd([[colorscheme tokyonight]])
-- 	end,
-- }
--
-- return {
-- 	"catppuccin/nvim",
--
-- 	name = "catppuccin",
--
-- 	priority = 1000,
--
-- 	config = function()
-- 		require("catppuccin").setup()
--
-- 		vim.cmd.colorscheme("catppuccin")
-- 	end,
-- }
--
return {
	"ribru17/bamboo.nvim",

	lazy = false,

	priority = 1000,

	config = function()
		require("bamboo").setup({
			-- optional configuration here
		})

		require("bamboo").load()
	end,
}
