return {
  "dmmulroy/ts-error-translator.nvim",
  enabled = true,
  config = function()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
      require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
      vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
    end
  end,
}
