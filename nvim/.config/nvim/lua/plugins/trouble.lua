return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  config = function()
    local trouble = require("trouble")
    trouble.setup()

    local map = require("utils").map

    map("n", "<leader>y", "<cmd> Trouble diagnostics toggle <cr>")
  end,
}
