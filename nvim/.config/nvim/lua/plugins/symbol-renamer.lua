return {
  "seasonalmatcha/symbol-renamer.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local map = require("utils").map
    local sr = require("symbol-renamer")

    map({ "n" }, "<leader>ra", function()
      sr.open()
    end)
  end,
}
