return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  config = function()
    local map = require("utils").map

    map("n", "<leader>ha", function()
      require("harpoon.mark").add_file()
    end)
    map("n", "<leader>hh", function()
      require("harpoon.ui").toggle_quick_menu()
    end)
    map("n", "<leader>hn", function()
      require("harpoon.ui").nav_next()
    end)
    map("n", "<leader>hp", function()
      require("harpoon.ui").nav_prev()
    end)
  end,
}
