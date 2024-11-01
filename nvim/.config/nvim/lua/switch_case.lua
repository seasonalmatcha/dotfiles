local M = {}

local function camel_to_pascal(str)
  return str:gsub("^%l", string.upper)
end
local function camel_to_snake(str)
  return str:gsub("(%u)", "_%1"):lower()
end

local function pascal_to_camel(str)
  return str:gsub("^%u", string.lower)
end

local function pascal_to_snake(str)
  return str:gsub("(%u)", "_%1"):gsub("^_", ""):lower()
end

local function snake_to_camel(str)
  return str:gsub("_(%w)", function(c)
    return c:upper()
  end)
end

local function snake_to_pascal(str)
  return str
    :gsub("_(%w)", function(c)
      return c:upper()
    end)
    :gsub("^(%w)", function(c)
      return c:upper()
    end)
end

local function get_word_under_cursor()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  local word = vim.fn.expand("<cword>")
  local word_start = vim.fn.matchstrpos(vim.fn.getline("."), "\\k*\\%" .. (col + 1) .. "c\\k*")[2]
  return word, word_start, line
end

M.toggle_camel_pascal_case = function()
  local word, word_start, line = get_word_under_cursor()

  local to_sub = ""
  if word:find("_") then
    to_sub = snake_to_pascal(word)
  elseif word:find("^%l") then
    to_sub = camel_to_pascal(word)
  else
    to_sub = pascal_to_camel(word)
  end
  vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { to_sub })
end

M.toggle_camel_snake_case = function()
  local word, word_start, line = get_word_under_cursor()

  local to_sub = ""
  if word:find("_") then
    to_sub = snake_to_camel(word)
  elseif word:find("^%u") then
    to_sub = pascal_to_snake(word)
  else
    to_sub = camel_to_snake(word)
  end
  vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { to_sub })
end

M.toggle_pascal_snake_case = function()
  local word, word_start, line = get_word_under_cursor()

  local to_sub = ""
  if word:find("_") then
    to_sub = snake_to_pascal(word)
  else
    to_sub = pascal_to_snake(word)
  end
  vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { to_sub })
end

return M
