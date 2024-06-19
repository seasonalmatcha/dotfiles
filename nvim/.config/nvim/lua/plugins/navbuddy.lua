return {
  "SmiteshP/nvim-navbuddy",
  event = "VeryLazy",
  cmd = { "Navbuddy" },
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local map = require("utils").map

    require("nvim-navbuddy").setup({
      lsp = { auto_attach = true },
    })

    map("n", "<leader>s", "<cmd> Navbuddy <cr>")
  end,
}
