return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  config = function()
    local map = require("utils").map
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
        always_show_bufferline = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
      },
    })

    map("n", "<leader>tt", "<cmd> :%bdel <cr>")
    map("n", "<tab>", "<cmd> BufferLineCycleNext <cr>")
    map("n", "<s-tab>", "<cmd> BufferLineCyclePrev <cr>")

    for i = 1, 9, 1 do
      map("n", string.format("<a-%s>", i), string.format("<cmd> BufferLineGoToBuffer %s <cr>", i))
    end

    local keys = { "¡", "™", "£", "¢", "∞", "§", "¶", "•", "ª" }
    for i, key in ipairs(keys) do
      map("n", string.format("%s", key), string.format("<cmd> BufferLineGoToBuffer %s <cr>", i))
    end
  end,
}
