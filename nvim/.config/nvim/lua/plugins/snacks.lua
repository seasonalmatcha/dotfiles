return {
  "folke/snacks.nvim",
  priority = 1000,
  config = function()
    local map = require("utils").map
    local snacks = require("snacks")

    snacks.setup({
      indent = {
        animate = {
          enabled = false,
        },
      },
      image = {},
      notifier = {},
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

    map("n", ";q", function()
      snacks.picker.qflist()
    end)

    map("n", ";m", function()
      snacks.picker.marks()
    end)

    map("n", ";r", function()
      snacks.picker.registers()
    end)

    map("n", ";v", function()
      snacks.picker.cliphist()
    end)

    vim.api.nvim_create_autocmd("LspProgress", {
      callback = function(ev)
        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
          id = "lsp_progress",
          title = "LSP Progress",
          opts = function(notif)
            notif.icon = ev.data.params.value.kind == "end" and " "
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
}
