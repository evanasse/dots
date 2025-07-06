local function reverse(t)
  local n = #t
  local i = 1
  while i < n do
    t[i], t[n] = t[n], t[i]
    i = i + 1
    n = n - 1
  end
  return t
end

local M = {}

M.full_spinner = function()
  return { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
    "", "", "", "" }
end

M.full_spinner_rev = function()
  return reverse(M.full_spinner())
end

M.half_spinner = function()
  return { "", "", "", "", "", "", "", "", "", "", "", "", "" }
end

M.half_spinner_rev = function()
  return reverse(M.half_spinner())
end

M.quarter_spinner = function()
  return { "", "", "", "", "", "", "" }
end

M.quarter_spinner_rev = function()
  return reverse(M.quarter_spinner())
end

return M
