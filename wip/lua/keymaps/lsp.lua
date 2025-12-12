local map = vim.keymap.set
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local ok, builtin = pcall(require, 'telescope.builtin')
if not ok then
  return
end

map({ 'n', 'v' }, '<leader>dq', builtin.lsp_definitions, { desc = 'Definition' })
map({ 'n', 'v' }, '<leader>ds', builtin.lsp_references { desc = 'References' })
map({ 'n', 'v' }, '<leader>dd', vim.diagnostic.open_float, { desc = 'Diagnostic' })
map({ 'n', 'v' }, '<leader>da', vim.lsp.buf.code_action, { desc = 'Code Action' })
map({ 'n', 'v' }, '<leader>dr', vim.lsp.buf.rename, { desc = 'Rename' })
map({ 'n', 'v' }, '<leader>df', '<cmd>Telescope diagnostics<CR>', { desc = 'Diagnostics all' })

map({ 'n', 'v' }, '<leader>d=', function()
  vim.lsp.buf.format {
    async = true,
    filter = function(client)
      return client.name == 'null-ls'
    end,
  }

  -- Apply ESLint fixes after formatting
  vim.lsp.buf.code_action {
    filter = function(action)
      return action.title:match 'Fix all' -- picks “Fix all auto-fixable” actions
    end,
    apply = true,
  }
end, { desc = 'Format + ESLint Fix' })
