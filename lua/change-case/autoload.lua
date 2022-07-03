local M = {}
local fn = vim.fn

local function getText()
  local _, line_start, column_start, _ = table.unpack(fn.getpos("'<"))
  local _, line_end, column_end, _ = table.unpack(fn.getpos("'>"))

  local lines = fn.getline(line_start, line_end)
  if #lines == 0 then
    return ""
  end
  return vim.nvim_buf_get_text(0, line_start, column_start, line_end, column_end)
end

local cases = {
  ["lower"] = function(text)
    return text:lower()
  end,
  ["upper"] = function(text)
    return text:upper()
  end,
  ["camel"] = function(text)
    return text:gsub("%s+", ""):gsub("^%l", string.upper):gsub("%l%l", string.upper)
  end,
  ["snake"] = function(text)
    return text:gsub("%s+", "_"):gsub("%l", string.lower)
  end,
  ["kebab"] = function(text)
    return text:gsub("%s+", "-"):gsub("%l", string.lower)
  end,
  ["pascal"] = function(text)
    return text:gsub("%s+", ""):gsub("^%l", string.upper)
  end,
  ["constant"] = function(text)
    return text:gsub("%s+", "_"):gsub("%l", string.upper)
  end,
  ["camel_upper"] = function(text)
    return text:gsub("%s+", ""):gsub("^%l", string.upper):gsub("%l%l", string.upper):upper()
  end,
  ["snake_upper"] = function(text)
    return text:gsub("%s+", "_"):gsub("%l", string.lower):upper()
  end,
  ["kebab_upper"] = function(text)
    return text:gsub("%s+", "-"):gsub("%l", string.lower):upper()
  end,
  ["pascal_upper"] = function(text)
    return text:gsub("%s+", ""):gsub("^%l", string.upper):upper()
  end,
  ["constant_upper"] = function(text)
    return text:gsub("%s+", "_"):gsub("%l", string.upper):upper()
  end,
}

function M.change_case(case)
  local text = getText()
  if text == "" then
    return
  end

  local new_text = cases[case](text)
  if new_text == text then
    return
  end

  fn.setreg(text, new_text)
end

return M
