local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general = augroup("General", { clear = true })

autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({
      timeout = 200,
    })
  end,
  group = general,
  desc = "Highlight when yanking text",
})

autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = general,
  desc = "Disable New Line Comment",
})

autocmd("BufEnter", {
  pattern = "*.{png,jpg,jpeg,webp,gif}",
  callback = function(args)
    local file_path = vim.fn.fnamemodify(args.file, ":p")
    vim.fn.jobstart({ "imv", file_path }, { detach = true })
  end,
  group = general,
  desc = "Open image files with imv",
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local argv = vim.fn.argv()

    -- If no files were given, and Neovim opened a directory → open Neo-tree
    if #argv == 0 and vim.fn.isdirectory(vim.fn.expand(".")) == 1 then
      require("neo-tree.command").execute({
        toggle = true,
        dir = vim.loop.cwd(),
      })

      -- optional: close the empty buffer
      pcall(vim.cmd, "bd")
    end
  end,
})
