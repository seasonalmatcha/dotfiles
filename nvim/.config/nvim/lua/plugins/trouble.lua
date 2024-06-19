return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  config = function()
    local map = require("utils").map

    map("n", "<leader>y", "<cmd> TroubleToggle <cr>")
  end,
}
