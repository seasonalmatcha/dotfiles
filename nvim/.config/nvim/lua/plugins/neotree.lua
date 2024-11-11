return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local map = require("utils").map
    local cmd = require("neo-tree.command").execute

    require("neo-tree").setup({
      close_if_last_window = false,
      popup_border_style = "rounded",
      window = {
        position = "float",
        -- width = 30,
      },
      filesystem = {
        window = {
          width = 30,
          max_width = 30,
          mappings = {
            ["<bs>"] = "close_node",
            ["o"] = "open",
            ["<tab>"] = { "toggle_preview", config = { use_float = false } },
            ["P"] = { "toggle_preview", config = { use_float = false } },
            ["oc"] = "none",
            ["od"] = "none",
            ["og"] = "none",
            ["om"] = "none",
            ["on"] = "none",
            ["os"] = "none",
            ["ot"] = "none",
            ["gk"] = "prev_git_modified",
            ["gj"] = "next_git_modified",
          },
        },
      },
      default_component_configs = {
        indent = {
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          indent_size = 2,
        },
        git_status = {
          symbols = {
            -- Change type
            added = "✚",
            deleted = "✖",
            modified = "",
            renamed = "󰁕",
            -- Status type
            untracked = "",
            ignored = "◌",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.cmd([[
              setlocal number
              setlocal relativenumber
            ]])
          end,
        },
      },
      source_selector = {
        tabs_max_width = 30,
      },
    })

    map("n", "<leader>e", function()
      cmd({ toggle = true })
    end)
  end,
}
