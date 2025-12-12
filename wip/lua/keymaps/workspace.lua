local map = vim.keymap.set
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

map({ 'n', 'v' }, '<leader>x', '<cmd>set cursorline!<CR>', { desc = 'Toggle Cursorline' })
map({ 'n', 'v' }, '<leader>z', '<cmd>set cursorcolumn!<CR>', { desc = 'Toggle Cursorcolumn' })
map({ 'n', 'v' }, '<leader>c', '<cmd>set wrap!<CR>', { desc = 'Toggle Wrap' })
map({ 'n', 'v' }, '<leader>v', '<cmd>set nu!<CR>', { desc = 'Toggle Numbers' })
map({ 'n', 'v' }, '<leader>b', '<cmd>set relativenumber!<CR>', { desc = 'Toggle Relative Numbers' })
map('n', '<C-a>', function()
  if vim.o.mouse == '' then
    vim.o.mouse = 'a' -- enable mouse
  else
    vim.o.mouse = '' -- disable mouse
  end
  print('Mouse is now: ' .. (vim.o.mouse == '' and 'OFF' or 'ON'))
end, { desc = 'Toggle mouse input' })
