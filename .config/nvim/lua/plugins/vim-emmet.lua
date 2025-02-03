return {
  "mattn/emmet-vim",
  init = function()
    -- Default value <c-y> messes with ins-completion accept selected entry mapping
    vim.g.user_emmet_leader_key = '<c-t>'
  end,
}
