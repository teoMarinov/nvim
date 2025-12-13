local map = vim.keymap.set

map("n", "<leader>dh", "<cmd>Telescope help_tags<CR>", { desc = "[S]earch [H]elp" })
map("n", "<leader>dk", "<cmd>Telescope keymaps<CR>", { desc = "[S]earch [K]eymaps" })
map("n", "<leader>e", "<cmd>Telescope find_files<CR>", { desc = "[S]earch [F]iles" })
map("n", "<leader>q", "<cmd>Telescope builtin<CR>", { desc = "[S]earch [S]elect Telescope" })
map("n", "<leader>W", "<cmd>Telescope grep_string<CR>", { desc = "[S]earch current [W]ord" })
map("n", "<leader>w", "<cmd>Telescope live_grep<CR>", { desc = "[S]earch by [G]rep" })
map("n", "<leader>r", "<cmd>Telescope oldfiles<CR>", { desc = '[S]earch Recent Files ("." for repeat)' })
map("n", "<leader><leader>", "<cmd>Telescope buffers<CR>", { desc = "[ ] Find existing buffers" })
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Current file fuzzy finder" })
