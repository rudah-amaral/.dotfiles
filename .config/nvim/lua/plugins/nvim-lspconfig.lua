return {
  "neovim/nvim-lspconfig",
  config = function()
    -- vim.lsp.enable("markdown")
    vim.lsp.enable("cssls")
    vim.lsp.enable("eslint")
    vim.lsp.enable("html")
    vim.lsp.enable("javascript")
    vim.lsp.enable("jsonls")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("tombi")
    vim.lsp.enable("ts_ls")
  end
}
