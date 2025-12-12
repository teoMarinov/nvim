local map = vim.keymap.set
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Previous --
map('n', '<C-o>', '<C-i>', { noremap = true, silent = true })
map('n', '<C-i>', '<C-o>', { noremap = true, silent = true })

-- Terminal --
map({ 'n', 'v' }, '<leader>t', '<cmd>terminal<CR>', { desc = 'Terminal' })
map('t', '<C-Space>', '<C-\\><C-n>', { desc = 'Terminal Unselect' })
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Oil --
map({ 'n', 'v' }, '<leader>a', '<cmd>Oil<CR>', { desc = 'Oil' })

-- Neotree --
map({ 'n', 'v' }, '<leader>1', '<cmd>Neotree close<CR>', { desc = 'Toggle Neotree' })
map({ 'n', 'v' }, '<leader>2', '<cmd>Neotree<CR>', { desc = 'Toggle Neotree' })

-- Movement --
map({ 'n', 'v' }, '<A-j>', ']m')
map({ 'n', 'v' }, '<A-k>', '[m')
