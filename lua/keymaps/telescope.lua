local map = vim.keymap.set

map("n", "<leader>h", "<cmd>Telescope help_tags<CR>", { desc = "Telescope Help Tags" })
map("n", "<leader>m", "<cmd>Telescope keymaps<CR>", { desc = "Telescope Keymaps" })
map("n", "<leader>e", "<cmd>Telescope find_files<CR>", { desc = "Telescope Files" })
map("n", "<leader>q", "<cmd>Telescope builtin<CR>", { desc = "Telescope" })
map("n", "<leader>W", "<cmd>Telescope grep_string<CR>", { desc = "Telescope Current Word" })
map("n", "<leader>w", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Grep" })
map("n", "<leader>r", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope Oldfiles" })
map("n", "<leader><leader>", "<cmd>Telescope buffers<CR>", { desc = "Telescope buffers " })
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope Fuzzy" })
