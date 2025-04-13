return {
  "folke/snacks.nvim",
  priority = 1000,
  config = function()
    local map = require("utils").map
    local snacks = require("snacks")

    snacks.setup({
      picker = {
        prompt = "   ",
        win = {
          input = {
            keys = {
              ["<leader>s"] = { "edit_split", mode = { "n" } },
              ["<leader>v"] = { "edit_vsplit", mode = { "n" } },
              ["."] = { "toggle_hidden", mode = { "n" } },
              ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            },
          },
        },
      },
    })

    map("n", ";f", function()
      snacks.picker.files()
    end)

    map("n", ";b", function()
      snacks.picker.buffers()
    end)

    map("n", ";s", function()
      snacks.picker.grep_buffers()
    end)

    map("n", ";l", function()
      snacks.picker.grep()
    end)

    map("n", ";e", function()
      snacks.picker.explorer()
    end)

    map("n", ";h", function()
      snacks.picker.help()
    end)

    map("n", ";j", function()
      snacks.picker.jumps()
    end)

    map("n", ";g", function()
      snacks.picker.git_status()
    end)

    map("n", ";t", function()
      snacks.picker.todo_comments()
    end)

    map("n", ";r", function()
      snacks.picker.registers()
    end)
  end,
}
