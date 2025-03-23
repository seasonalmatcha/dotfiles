return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    config = function()
      local map = require("utils").map
      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
      local ts_config = require("nvim-treesitter.configs")
      local ts_context = require("treesitter-context")

      local textobject_maps = {
        { "af", "@function.outer" },
        { "if", "@function.inner" },
        { "ac", "@class.outer" },
        { "ic", "@class.inner" },
        { "ap", "@parameter.outer" },
        { "ip", "@parameter.inner" },
        { "ia", "@assignment.inner" },
        { "aa", "@assignment.outer" },
        { "it", "@attribute.inner" },
        { "at", "@attribute.outer" },
        { "ib", "@block.inner" },
        { "ab", "@block.outer" },
      }

      local keymaps = {}
      local goto_next_start = {}
      local goto_previous_start = {}

      for _, pair in ipairs(textobject_maps) do
        keymaps[pair[1]] = pair[2]
        goto_next_start["g" .. pair[1]] = pair[2]
        goto_previous_start["<leader>g" .. pair[1]] = pair[2]
      end

      ts_config.setup({
        ensure_installed = {
          "lua",
          "typescript",
          "html",
          "javascript",
          "tsx",
          "json",
          "prisma",
          "sql",
          "go",
          "gomod",
          "gosum",
          "css",
          "proto",
          "make",
          "markdown",
          "rust",
          "toml",
          "vimdoc",
          "xml",
          "yaml",
        },
        highlight = {
          enable = true,
          use_languagetree = true,
        },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = keymaps,
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = goto_next_start,
            goto_previous_start = goto_previous_start,
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
        },
      })

      ts_context.setup({
        enable = true,
        multiwindow = false,
        max_lines = 2,
        min_window_height = 1,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
        on_attach = nil,
      })

      map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_next)
      map({ "n" }, "[c", function()
        ts_context.go_to_context(vim.v.count1)
      end)
    end,
  },
}
