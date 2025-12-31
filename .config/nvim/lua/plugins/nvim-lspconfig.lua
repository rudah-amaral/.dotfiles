local nmap = require("mapper").nmap

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    vim.lsp.config("*", {
      capabilities = capabilities,
    })
    -- vim.lsp.enable("markdown")
    vim.lsp.enable("arduino_language_server")
    vim.lsp.enable("cssls")
    vim.lsp.enable("eslint")
    vim.lsp.enable("html")
    vim.lsp.enable("javascript")
    vim.lsp.enable("jsonls")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("nixd")
    vim.lsp.enable("tombi")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("ty")

    nmap("gd", ":lua vim.lsp.buf.definition()<CR>")
    nmap("<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
  end
}
