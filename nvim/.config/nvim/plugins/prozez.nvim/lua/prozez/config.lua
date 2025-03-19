local M = {}

---@type vim.api.keyset.win_config
M.default_win_opts = {
	style = "minimal",
	relative = "editor",
	border = "rounded",
	height = 90,
	width = 90,
}

---@type BufOpt[]
M.default_buf_opts = {
	{ "bufhidden", "wipe" },
	{ "modifiable", true },
}

return M
