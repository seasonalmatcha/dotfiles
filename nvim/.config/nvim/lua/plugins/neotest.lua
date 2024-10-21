return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    "antoinemadec/FixCursorHold.nvim",
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-go",
  },
  config = function()
    local map = require("utils").map
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-go"),
        require("neotest-vitest"),
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
    })

    map("n", "<leader>tr", function()
      neotest.run.run()
    end)
    map("n", "<leader>tl", function()
      neotest.run.run_last()
    end)
    map("n", "<leader>tf", function()
      neotest.run.run(vim.fn.expand("%"))
    end)
    map("n", "<leader>to", function()
      neotest.output_panel.toggle()
    end)
    map("n", "<leader>ts", function()
      neotest.summary.toggle()
    end)
  end,
}
