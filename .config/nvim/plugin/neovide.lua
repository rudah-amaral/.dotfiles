if vim.g.neovide then
  vim.o.guifont = "MesloLGM Nerd Font:h16:w0:subpixelantialias"
  vim.g.neovide_opacity = 0.85
  vim.g.neovide_normal_opacity = 0.9
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_scale_factor = 1.0

  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end

  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)

  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
  end)
end
