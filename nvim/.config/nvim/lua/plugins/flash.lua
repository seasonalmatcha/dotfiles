return {
  "folke/flash.nvim",
  event = "VeryLazy",
  config = function()
    local map = require("utils").map
    local flash = require("flash")

    map({ "n", "v" }, "s", flash.jump)
    map("n", "S", flash.treesitter)
  end,
}
