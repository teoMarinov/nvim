if true then
	return {}
end
return {
	"tribela/transparent.nvim",
	config = function()
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#999999" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#CCDDEE", bold = true })
		vim.api.nvim_set_hl(0, "Comment", { fg = "#aaaabb" })

		require("transparent").setup({
			exclude = { "CursorLine", "CursorLineNr", "LineNr" },

			extra_groups = {
				"NormalFloat",
				"NvimTreeNormal",
				"NormalNC",
				"StatusLine",
				"StatusLineNC",
				"EndOfBuffer",
				"SignColumn",
				"GitSignsAdd",
				"GitSignsChange",
				"GitSignsDelete",
			},
		})
	end,
}
