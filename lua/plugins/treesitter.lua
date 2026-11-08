local parsers = {
	"html",
	"css",
	"javascript",
	"typescript",
	"tsx",
	"jsdoc",
	"json",
	"csv",
	"yaml",
	"markdown",
	"markdown_inline",
}

local filetypes = {
	"html",
	"css",
	"javascript",
	"typescript",
	"typescriptreact",
	"json",
	"csv",
	"yaml",
	"markdown",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	dependencies = { "windwp/nvim-ts-autotag" },
	config = function()
		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function(args)
				local ok = pcall(vim.treesitter.start, args.buf)
				if not ok then
					return
				end
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		require("nvim-ts-autotag").setup()
	end,
}
