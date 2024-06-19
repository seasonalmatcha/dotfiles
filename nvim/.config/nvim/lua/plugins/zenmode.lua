return {
  "folke/zen-mode.nvim",
  config = function()
    local map = require("utils").map

    map("n", "<a-z>", "<cmd> ZenMode <cr>")
    map("n", "Ω", "<cmd> ZenMode <cr>")
  end,
}
