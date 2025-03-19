local config = require("prozez.config")
local util = require("prozez.util")

---@class Prozez
---@field win_opts vim.api.keyset.win_config
local M = {
  buf_opts = config.default_buf_opts,
  win_opts = config.default_win_opts,
  term_state = {
    win = -1,
    buf = -1,
  },
}

local function init_user_commands()
  vim.api.nvim_create_user_command("Prozez", function(args)
    M:exec(args.fargs, {
      prevent_close_on_done = true,
    })
  end, { nargs = "*" })

  vim.api.nvim_create_user_command("ProzezExecAndClose", function(args)
    M:exec(args.fargs, { close_on_exit = true })
  end, { nargs = "*" })
end

---@class ProzezConfig
---@field win_opts? vim.api.keyset.win_config

---@param cfg? ProzezConfig
function M:setup(cfg)
  cfg = cfg or {}

  if cfg.win_opts then
    self.win_opts = vim.tbl_extend("force", self.win_opts, cfg.win_opts)
  end
end

---@class ExecOpts
---@field prevent_close_on_done? boolean
---@field buf_opts? BufOpt[]
---@field win_opts? vim.api.keyset.win_config
---@field term_opts? table

---@param command string | string[]
---@param opts? ExecOpts
function M:exec(command, opts)
  opts = opts or {}

  ---@type vim.api.keyset.win_config
  local win_opts = vim.tbl_extend("force", self.win_opts, opts.win_opts or {})

  ---@type BufOpt[]
  local buf_opts = vim.tbl_extend("force", self.buf_opts, opts.buf_opts or {})

  local buf = util.create_buf(buf_opts)
  local win = util.create_win(buf, win_opts)

  vim.api.nvim_set_current_win(win)

  local term_opts = vim.tbl_extend("force", {
    on_exit = function()
      if (not opts.prevent_close_on_done) and vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
  }, opts.term_opts or {})

  vim.fn.termopen(command, term_opts)

  vim.cmd.startinsert()
end

function M:toggle_terminal()
  if not vim.api.nvim_win_is_valid(self.term_state.win) then
    if not vim.api.nvim_buf_is_valid(self.term_state.buf) then
      self.term_state.buf = util.create_buf(self.buf_opts)
    end
    self.term_state.win = util.create_win(self.term_state.buf, self.win_opts)

    vim.api.nvim_set_current_win(self.term_state.win)
    if vim.bo[self.term_state.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(self.term_state.win)
  end

  vim.cmd.startinsert()
end

init_user_commands()

return M
