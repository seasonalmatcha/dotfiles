return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown",
  cmd = {
    "ObsidianOpen",
  },
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "personal",
          path = "$OBSIDIAN_VAULT",
        },
      },
    })
  end,
}
