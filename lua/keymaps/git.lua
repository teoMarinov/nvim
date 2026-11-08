local map = vim.keymap.set

map({ "n", "v" }, "<leader>gg", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
map({ "n", "v" }, "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview File History" })
map({ "n", "v" }, "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
