local map = vim.keymap.set

map({ "n", "v" }, "<leader>dq", "<cmd>Telescope lsp_definitions<CR>", { desc = "Definition" })
map({ "n", "v" }, "<leader>ds", "<cmd>Telescope lsp_references<CR>", { desc = "References" })
map({ "n", "v" }, "<leader>dd", vim.diagnostic.open_float, { desc = "Diagnostic" })
map({ "n", "v" }, "<leader>da", vim.lsp.buf.code_action, { desc = "Code Action" })
map({ "n", "v" }, "<leader>dr", vim.lsp.buf.rename, { desc = "Rename" })
map({ "n", "v" }, "<leader>df", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics all" })
