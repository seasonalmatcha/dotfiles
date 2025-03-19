return {
  dir = vim.fn.stdpath("config") .. "/plugins/prozez.nvim",
  enabled = true,
  config = function()
    local map = require("utils").map
    local prozez = require("prozez")

    prozez:setup({
      win_opts = {
        height = 80,
        width = 80,
      },
    })

    local commands = {
      { { "n" }, "<leader>lg", "lazygit" },
      { { "n" }, "<leader>ld", "lazydocker" },
      { { "n" }, "<leader>ly", "yazi" },
    }

    for _, cmd in ipairs(commands) do
      map(cmd[1], cmd[2], function()
        prozez:exec(cmd[3], cmd[4])
      end)
    end

    map({ "n" }, "<leader>ll", function()
      prozez:toggle_terminal()
    end)

    map({ "n", "t" }, "<a-l>", function()
      prozez:toggle_terminal()
    end)
  end,
}
