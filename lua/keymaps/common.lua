local map = vim.keymap.set

-- Terminal --
map({ "n", "v" }, "<leader>T", "<cmd>terminal<CR>", { desc = "Terminal" })
map("t", "<C-Space>", "<C-\\><C-n>", { desc = "Terminal Unselect" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Oil --
map({ "n", "v" }, "<leader>a", "<cmd>Oil<CR>", { desc = "Oil" })

-- Movement --
map({ "n", "v" }, "<A-j>", "]m")
map({ "n", "v" }, "<A-k>", "[m")
