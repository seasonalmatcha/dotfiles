return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  config = function()
    local utils = require("utils")
    local map = utils.map
    local aucmd = utils.aucmd
    local conform = require("conform")
    local js_formatter = { "prettier", stop_after_first = true }

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        typescript = js_formatter,
        typescriptreact = js_formatter,
        javascript = js_formatter,
        javascriptreact = js_formatter,
        json = js_formatter,
        markdown = js_formatter,
        go = { "gofumpt", "goimports-reviser", "golines" },
        prisma = { "prismaFmt" },
        dart = { "dart_format" },
        rust = { "rustfmt" },
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
