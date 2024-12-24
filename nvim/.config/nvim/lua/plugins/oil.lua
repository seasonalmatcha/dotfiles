return {
  "stevearc/oil.nvim",
  config = function()
    local map = require("utils").map
    local oil = require("oil")

    oil.setup({
      keymaps = {
        ["q"] = "actions.close",
        ["R"] = "actions.refresh",
        ["<leader>v"] = { "actions.select", opts = { vertical = true } },
        ["<leader>h"] = { "actions.select", opts = { horizontal = true } },
        ["<backspace>"] = { "actions.parent" },
        ["."] = { "actions.toggle_hidden" },
      },
      float = {
        padding = 2,
        max_width = 80,
        border = "rounded",
      },
    })

    map("n", "<leader>e", function()
      oil.open_float(vim.fn.getcwd())
    end)

    map("n", "<leader>o", function()
      oil.open_float()
    end)
  end,
}
