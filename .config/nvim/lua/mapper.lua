local M = {}

local map = function(mode, lhs, rhs, options)
  local defaultOptions = { noremap = true, silent = false }
  if options then
    for key, value in pairs(options) do
      if defaultOptions[key] ~= nil then
        defaultOptions[key] = value
      else
        print("vim.keymap.set doesn't accept option " .. key)
      end
    end
  end

  vim.keymap.set(mode, lhs, rhs, defaultOptions)
end

local createMapper = function(mode)
  return function(lhs, rhs, options)
    map(mode, lhs, rhs, options)
  end
end

-- help map-table
M.map = createMapper("")    -- Normal, Visual, Select, Operator-pending
M.nmap = createMapper("n")  -- Normal
M.icmap = createMapper("!") -- Insert and Command-line
M.imap = createMapper("i")  -- Insert
M.cmap = createMapper("c")  -- Command-line
M.vmap = createMapper("v")  -- Visual and Select
M.xmap = createMapper("x")  -- Visual
M.smap = createMapper("s")  -- Select
M.omap = createMapper("o")  -- Operator-pending
M.tmap = createMapper("t")  -- Terminal
M.lmap = createMapper("l")  -- Insert, Command-line, Lang-Arg

return M
