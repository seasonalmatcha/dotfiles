local M = {}

M.map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts or { silent = true })
end

M.aucmd = function(event, opts)
  vim.api.nvim_create_autocmd(event, opts)
end

M.has_file = function(patterns)
  for _, pattern in ipairs(patterns) do
    local file = vim.fn.findfile(pattern, ".;")
    if file ~= "" then
      return true
    end
  end
  return false
end

return M
