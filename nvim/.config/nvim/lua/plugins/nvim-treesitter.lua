return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local map = require("utils").map
      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

      require("nvim-treesitter.configs").setup({
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
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["ap"] = "@parameter.outer",
              ["ip"] = "@parameter.inner",
              ["ia"] = "@assignment.inner",
              ["aa"] = "@assignment.outer",
              ["it"] = "@attribute.inner",
              ["at"] = "@attribute.outer",
              ["ib"] = "@block.inner",
              ["ab"] = "@block.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["gaf"] = "@function.outer",
              ["gif"] = "@function.inner",
              ["gac"] = "@class.outer",
              ["gic"] = "@class.inner",
              ["gap"] = "@parameter.outer",
              ["gip"] = "@parameter.inner",
              ["gia"] = "@assignment.inner",
              ["gaa"] = "@assignment.outer",
              ["git"] = "@attribute.inner",
              ["gat"] = "@attribute.outer",
              ["gab"] = "@block.inner",
              ["gib"] = "@block.inner",
            },
            goto_previous_start = {
              ["<leader>gaf"] = "@function.outer",
              ["<leader>gif"] = "@function.inner",
              ["<leader>gac"] = "@class.outer",
              ["<leader>gic"] = "@class.inner",
              ["<leader>gap"] = "@parameter.outer",
              ["<leader>gip"] = "@parameter.inner",
              ["<leader>gia"] = "@assignment.inner",
              ["<leader>gaa"] = "@assignment.outer",
              ["<leader>git"] = "@attribute.inner",
              ["<leader>gat"] = "@attribute.outer",
              ["<leader>gab"] = "@block.outer",
              ["<leader>gib"] = "@block.inner",
            },
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

      map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_next)
    end,
  },
}
