-- Global diagnostics settings
vim.diagnostic.config({
  virtual_text = false,
  float = {
    scope = "cursor",
    border = "rounded",
    focus = false,
    max_width = 80
  }
})

local open_diagnostics_floating_windows = function()
  -- Early return if there is already a floating windows opened.
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then
      return
    end
  end

  vim.diagnostic.open_float()
end

-- Time in which a still cursor triggers a CursorHold event.
vim.o.updatetime = 50

-- Autocmd to open hovered diagnostics in floating windows.
local hover_group = vim.api.nvim_create_augroup("Hover Group", {})
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = hover_group,
  pattern = "*",
  callback = function()
    open_diagnostics_floating_windows()
  end,
})
