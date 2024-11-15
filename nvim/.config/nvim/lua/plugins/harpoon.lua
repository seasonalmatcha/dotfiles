return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  config = function()
    local map = require("utils").map
    local harpoon = require("harpoon")

    local toggle_opts = {
      border = "rounded",
      ui_width_ratio = 0.35,
    }

    harpoon:setup({})

    map("n", "<leader>ha", function()
      harpoon:list():add()
    end)
    map("n", "<leader>hh", function()
      harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
    end)
    map("n", "<leader>hn", function()
      harpoon:list():next()
    end)
    map("n", "<leader>hp", function()
      harpoon:list():prev()
    end)
  end,
}
