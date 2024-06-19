return {
  "laytan/cloak.nvim",
  config = function()
    require("cloak").setup({
      enabled = true,
      cloak_character = "󰇷",
      highlight_group = "Comment",
      cloak_length = 10,
      try_all_patterns = true,
      patterns = {
        {
          file_pattern = ".env*",
          cloak_pattern = "=.+",
          replace = nil,
        },
      },
    })
  end,
}
