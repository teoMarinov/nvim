if true then return {} end
return {
  "RRethy/vim-illuminate",

  config = function()
    require("illuminate").configure({ delay = 200 })
  end,
}
