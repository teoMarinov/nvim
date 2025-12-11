local map = vim.keymap.set

-- Leader --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Previous --
map("n", "<C-o>", "<C-i>", { noremap = true, silent = true })
map("n", "<C-i>", "<C-o>", { noremap = true, silent = true })

-- Terminal --
map({ "n", "v" }, "<leader>t", "<cmd>terminal<CR>", { desc = "Terminal" })
map("t", "<C-Space>", "<C-\\><C-n>", { desc = "Terminal Unselect" })

-- Splits --
map({ "n", "v" }, "<C-A-h>", "<C-w><", { desc = "Decrease Width" })
map({ "n", "v" }, "<C-A-j>", "<C-w>-", { desc = "Decrease Height" })
map({ "n", "v" }, "<C-A-k>", "<C-w>+", { desc = "Increase Height" })
map({ "n", "v" }, "<C-A-l>", "<C-w>>", { desc = "Increase Width" })

-- Workspace --
map({ "n", "v" }, "<leader>x", "<cmd>set cursorline!<CR>", { desc = "Toggle Cursorline" })
map({ "n", "v" }, "<leader>z", "<cmd>set cursorcolumn!<CR>", { desc = "Toggle Cursorcolumn" })
map({ "n", "v" }, "<leader>c", "<cmd>set wrap!<CR>", { desc = "Toggle Wrap" })
map({ "n", "v" }, "<leader>v", "<cmd>set nu!<CR>", { desc = "Toggle Numbers" })
map({ "n", "v" }, "<leader>b", "<cmd>set relativenumber!<CR>", { desc = "Toggle Relative Numbers" })
vim.keymap.set("n", "<C-a>", function()
	if vim.o.mouse == "" then
		vim.o.mouse = "a" -- enable mouse
	else
		vim.o.mouse = "" -- disable mouse
	end
	print("Mouse is now: " .. (vim.o.mouse == "" and "OFF" or "ON"))
end, { desc = "Toggle mouse input" })

-- Telescope --
map({ "n", "v" }, "<leader>q", "<cmd>Telescope<CR>", { desc = "Telescope" })
map({ "n", "v" }, "<leader>w", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
map({ "n", "v" }, "<leader>e", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
map({ "n", "v" }, "<leader>r", "<cmd>Telescope oldfiles<CR>", { desc = "Oldfiles" })

-- Oil --
map({ "n", "v" }, "<leader>a", "<cmd>Oil<CR>", { desc = "Oil" })

-- LSP Target --
map({ "n", "v" }, "<leader>dq", "<cmd>Telescope lsp_definitions<CR>", { desc = "Definition" })
map({ "n", "v" }, "<leader>ds", "<cmd>Telescope lsp_references<CR>", { desc = "References" })
map({ "n", "v" }, "<leader>dd", vim.diagnostic.open_float, { desc = "Diagnostic" })
map({ "n", "v" }, "<leader>da", vim.lsp.buf.code_action, { desc = "Code Action" })
map({ "n", "v" }, "<leader>dr", vim.lsp.buf.rename, { desc = "Rename" })
map({ "n", "v" }, "<leader>df", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics" })
map({ "n", "v" }, "<leader>d=", function()
	vim.lsp.buf.format({
		async = true,
		filter = function(client)
			return client.name == "null-ls"
		end,
	})

	-- Apply ESLint fixes after formatting
	vim.lsp.buf.code_action({
		filter = function(action)
			return action.title:match("Fix all") -- picks “Fix all auto-fixable” actions
		end,
		apply = true,
	})
end, { desc = "Format + ESLint Fix" })

-- Neotree --
map({ "n", "v" }, "<leader>1", "<cmd>Neotree close<CR>", { desc = "Toggle Neotree" })
map({ "n", "v" }, "<leader>2", "<cmd>Neotree<CR>", { desc = "Toggle Neotree" })

-- Movement --
map({"n", "v"}, "<A-j>", "]m")
map({"n", "v"}, "<A-k>", "[m]")

-- Git --
map({ "n", "v" }, "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
map({ "n", "v" }, "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<>", { desc = "Toggle git blame in line" })
map({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map({ "n", "v" }, "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Go prev hunk" })
map({ "n", "v" }, "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", { desc = "Go next hunk" })
map({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })

-- -- Buffers -- Currently not using
-- map({ "n", "v" }, "<A-p>", "<cmd>BufferPick<CR>", { desc = "Pick buffer" })
-- map({ "n", "v" }, "<A-t>", "<cmd>BufferPin<CR>", { desc = "Toggle pin buffer" })
-- -- Close buffers --
-- map({ "n", "v" }, "<A-q>", "<cmd>BufferClose!<CR>", { desc = "Close buffer" })
-- map({ "n", "v" }, "<A-e>", "<cmd>BufferCloseAllButCurrent<CR>", { desc = "Close all but current buffer" })
-- map({ "n", "v" }, "<A-x>", "<cmd>BufferCloseAllButPinned<CR>", { desc = "Close all but pinned buffer" })
-- map(
-- 	{ "n", "v" },
-- 	"<A-w>",
-- 	"<cmd>BufferCloseAllButCurrentOrPinned<CR>",
-- 	{ desc = "Close all but current or pinned buffer" }
-- )
-- -- Restore last closed buffer --
-- map({ "n", "v" }, "<A-r>", "<cmd>BufferRestore<CR>", { desc = "Restore buffer" })
-- -- Navigate buffers --
-- map({ "n", "v" }, "<A-l>", "<cmd>BufferNext<CR>", { desc = "Next buffer" })
-- map({ "n", "v" }, "<A-h>", "<cmd>BufferPrevious<CR>", { desc = "Previous buffer" })
-- map({ "n", "v" }, "<A-j>", "<cmd>BufferFirst<CR>", { desc = "First buffer" })
-- map({ "n", "v" }, "<A-k>", "<cmd>BufferLast<CR>", { desc = "Last buffer" })
-- for i = 1, 9 do
-- 	map({ "n", "v" }, "<A-" .. i .. ">", "<cmd>BufferGoto " .. i .. "<CR>", { desc = "Go to buffer " .. i })
-- end
-- -- Move buffers --
-- map({ "n", "v" }, "<A-L>", "<cmd>BufferMoveNext<CR>", { desc = "Move buffer next" })
-- map({ "n", "v" }, "<A-H>", "<cmd>BufferMovePrevious<CR>", { desc = "Move buffer previous" })
-- map({ "n", "v" }, "<A-J>", "<cmd>BufferMoveStart<CR>", { desc = "Move buffer start" })

-- Debugger --
map({ "n", "v" }, "<F1>", function()
	require("dap").continue()
end, { desc = "Debug: Start/Continue" })

map({ "n", "v" }, "<F25>", function()
	require("dap").run_last()
end, { desc = "Debug: Run Last Configuration" })

map({ "n", "v" }, "<F3>", function()
	require("dap").step_over()
end, { desc = "Debug: Step Over" })

map({ "n", "v" }, "<F4>", function()
	require("dap").step_into()
end, { desc = "Debug: Step Into" })

map({ "n", "v" }, "<F28>", function()
	require("dap").step_out()
end, { desc = "Debug: Step Out" })

map({ "n", "v" }, "<F2>", function()
	require("dap").toggle_breakpoint()
end, { desc = "Debug: Toggle Breakpoint" })

map({ "n", "v" }, "<F26>", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set Conditional Breakpoint" })

map({ "n", "v" }, "<F9>", function()
	require("dapui").toggle()
end, { desc = "Debug: Toggle UI" })
