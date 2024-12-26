return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local map = require("utils").map
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local previewers = require("telescope.previewers")
    local sorters = require("telescope.sorters")

    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = sorters.get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = sorters.get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        buffer_previewer_maker = previewers.buffer_previewer_maker,
        mappings = {
          n = {
            ["q"] = actions.close,
            ["<leader>h"] = actions.select_horizontal,
            ["<leader>v"] = actions.select_vertical,
          },
        },
      },
    })

    map("n", ";f", builtin.find_files)
    map("n", ";a", function()
      builtin.find_files({ follow = true, no_ignore = true, hidden = true })
    end)
    map("n", ";s", builtin.current_buffer_fuzzy_find)
    map("n", ";b", builtin.buffers)
    map("n", "<tab>", builtin.buffers)
    map("n", ";l", builtin.live_grep)
    map("n", ";j", builtin.jumplist)
    map("n", ";g", builtin.git_status)
    map("n", ";h", builtin.help_tags)
    map("n", ";g", builtin.git_status)
    map("n", "gl", function()
      builtin.lsp_definitions({ jump_type = "vsplit" })
    end)
    map("n", ";t", "<cmd> TodoTelescope <cr>")
  end,
}
