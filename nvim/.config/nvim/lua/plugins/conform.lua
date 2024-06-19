return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  config = function()
    local utils = require("utils")
    local map = utils.map
    local aucmd = utils.aucmd
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        javascript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" } },
        go = { "gofumpt", "goimports", "golines" },
        prisma = { "prismaFmt" },
        ["_"] = { "trim_whitespace" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
      formatters = {
        prismaFmt = {
          command = "prisma-fmt",
          args = { "format" },
        },
      },
    })

    aucmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })

    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })

    map({ "i", "n" }, "<a-s-f>", "<cmd> Format <cr>")
    map({ "i", "n" }, "Ï", "<cmd> Format <cr>")
  end,
}
