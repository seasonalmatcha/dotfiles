return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  config = function()
    local map = require("utils").map

    map("n", "<leader>e", "<cmd> Yazi <cr>")
  end,
}
