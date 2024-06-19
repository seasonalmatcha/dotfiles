return {
  "stevearc/oil.nvim",
  config = function()
    local map = require("utils").map
    local oil = require("oil")

    oil.setup({
      keymaps = {
        ["q"] = "actions.close",
        ["R"] = "actions.refresh",
      },
      float = {
        padding = 2,
        max_width = 60,
        -- max_height = 10,
        border = "rounded",
      },
      view_options = {
        show_hidden = true,
      },
    })

    map("n", "<leader>o", function()
      oil.open_float()
    end)
  end,
}
