local M = {}

---@alias BufOpt { [1]: string, [2]: any}

---@param opts? BufOpt[]
---@return integer
function M.create_buf(opts)
	local buf = vim.api.nvim_create_buf(false, true)

	if opts ~= nil and #opts ~= 0 then
		for _, o in ipairs(opts) do
			vim.api.nvim_set_option_value(o[1], o[2], { buf = buf })
		end
	end

	return buf
end

---@param buf integer
---@param win_opts vim.api.keyset.win_config
---@return integer win
function M.create_win(buf, win_opts)
	local height = math.floor(vim.o.lines * win_opts.height / 100)
	local width = math.floor(vim.o.columns * win_opts.width / 100)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win = vim.api.nvim_open_win(
		buf,
		true,
		vim.tbl_extend("force", win_opts, {
			height = height,
			width = width,
			row = row,
			col = col,
		})
	)

	return win
end

return M
