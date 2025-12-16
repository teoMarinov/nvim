local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general = augroup("General", { clear = true })

autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({
			timeout = 200,
		})
	end,
	group = general,
	desc = "Highlight when yanking text",
})

autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
	group = general,
	desc = "Disable New Line Comment",
})

autocmd("BufEnter", {
	pattern = "*.{png,jpg,jpeg,webp,gif}",
	callback = function(args)
		local file_path = vim.fn.fnamemodify(args.file, ":p")
		vim.fn.jobstart({ "imv", file_path }, { detach = true })
	end,
	group = general,
	desc = "Open image files with imv",
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup("kickstart-lsp-attach", { clear = true }),

	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- type definition
		map("<leader>dt", "<cmd>Telescope lsp_type_definitions<CR>", "Type Definition")
		-- definition
		map("<leader>dq", "<cmd>Telescope lsp_definitions<CR>", "Definition")
		-- reference
		map("<leader>ds", "<cmd>Telescope lsp_references<CR>", "References")
		-- declaration
		map("<leader>dQ", function()
			vim.lsp.buf.declaration()
		end, "Declaration")
		-- implementation
		map("<leader>di", "<cmd>Telescope lsp_implementations<CR>", "Implementation")
		-- rename
		map("<leader>dr", function()
			vim.lsp.buf.rename()
		end, "Rename")
		-- diagnostics
		map("<leader>df", function()
			require("telescope.builtin").diagnostics({ bufnr = 0 })
		end, "Diagnostics All")
		-- diagnostic
		map("<leader>dd", function()
			vim.diagnostic.open_float()
		end, "Diagnostics")
		-- code action
		map("<leader>da", function()
			vim.lsp.buf.code_action()
		end, "Code Action")
		-- format
		map("<leader>f", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, "Format buffer")
		-- search symbol
		map("<leader>dS", "<cmd>Telescope lsp_document_symbols<CR>", "Open Document Symbols")
		-- hover
		map("K", function()
			endvim.lsp.buf.hover()
		end, "Hover Documentation")

		local function client_supports_method(client, method, bufnr)
			if vim.fn.has("nvim-0.11") == 1 then
				return client:supports_method(method, bufnr)
			else
				return client.supports_method(method, { bufnr = bufnr })
			end
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if
			client
			and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
		then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle Hints")
		end

		-- Rounded borders for hover windows
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	end,
})
