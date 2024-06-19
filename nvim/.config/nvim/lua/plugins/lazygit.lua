return {
  "kdheepak/lazygit.nvim",
  event = "VeryLazy",
  config = function()
    local map = require("utils").map
    map("n", "<leader>lg", "<cmd> LazyGit <cr>")
  end,
}
