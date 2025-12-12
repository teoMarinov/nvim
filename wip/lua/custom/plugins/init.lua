-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'stevearc/oil.nvim',

    dependencies = { { 'echasnovski/mini.icons', opts = {} } },

    opts = {},

    lazy = false,

    config = function()
      require('oil').setup {
        default_file_explorer = true,

        columns = {
          'icon',
        },

        win_options = {
          signcolumn = 'yes',
        },

        delete_to_trash = false,

        view_options = {
          show_hidden = true,
        },
      }
    end,
  },

  {
    'romgrk/barbar.nvim',

    config = function()
      require('lazy').setup {
        {
          dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
          },

          init = function()
            vim.g.barbar_auto_setup = false
          end,

          opts = {
            sidebar_filetypes = {
              -- for Neo‑tree
              ['neo-tree'] = {
                event = 'BufWipeout',
                text = 'Neo‑tree',
                align = 'left',
              },

              NvimTree = true,
            },
            -- other barbar options here
          },

          version = '^1.0.0',

          keys = function()
            local maps = {}

            local function add(mode, lhs, rhs, desc)
              table.insert(maps, { lhs, rhs, mode = mode, desc = desc })
            end

            add({ 'n', 'v' }, '<A-p>', '<cmd>BufferPick<CR>', 'Pick buffer')
            add({ 'n', 'v' }, '<A-t>', '<cmd>BufferPin<CR>', 'Toggle pin buffer')

            add({ 'n', 'v' }, '<A-q>', '<cmd>BufferClose!<CR>', 'Close buffer')
            add({ 'n', 'v' }, '<A-e>', '<cmd>BufferCloseAllButCurrent<CR>', 'Close all but current buffer')
            add({ 'n', 'v' }, '<A-x>', '<cmd>BufferCloseAllButPinned<CR>', 'Close all but pinned buffer')
            add({ 'n', 'v' }, '<A-w>', '<cmd>BufferCloseAllButCurrentOrPinned<CR>', 'Close all but current/pinned')
            add({ 'n', 'v' }, '<A-r>', '<cmd>BufferRestore<CR>', 'Restore buffer')

            add({ 'n', 'v' }, '<A-l>', '<cmd>BufferNext<CR>', 'Next buffer')
            add({ 'n', 'v' }, '<A-h>', '<cmd>BufferPrevious<CR>', 'Previous buffer')
            add({ 'n', 'v' }, '<A-j>', '<cmd>BufferFirst<CR>', 'First buffer')
            add({ 'n', 'v' }, '<A-k>', '<cmd>BufferLast<CR>', 'Last buffer')

            for i = 1, 9 do
              add({ 'n', 'v' }, '<A-' .. i .. '>', '<cmd>BufferGoto ' .. i .. '<CR>', 'Go to buffer ' .. i)
            end

            add({ 'n', 'v' }, '<A-L>', '<cmd>BufferMoveNext<CR>', 'Move buffer next')
            add({ 'n', 'v' }, '<A-H>', '<cmd>BufferMovePrevious<CR>', 'Move buffer previous')
            add({ 'n', 'v' }, '<A-J>', '<cmd>BufferMoveStart<CR>', 'Move buffer start')

            return maps
          end,
        },
      }
    end,
  },

  {
    'ribru17/bamboo.nvim',

    lazy = false,

    priority = 1000,

    config = function()
      require('bamboo').setup {
        -- optional configuration here
      }

      require('bamboo').load()
    end,
  },
}
