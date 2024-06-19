local M = {}

M.map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts or { silent = true })
end

M.aucmd = function(event, opts)
  vim.api.nvim_create_autocmd(event, opts)
end

return M
