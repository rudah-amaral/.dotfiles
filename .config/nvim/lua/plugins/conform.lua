return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typeScriptreact = { "prettierd" },
      css = { "prettierd" },
      html = { "prettierd" },
      json = { "prettierd" },
      markdown = { "prettierd" },
      graphql = { "prettierd" },
      yaml = { "prettierd" },
    },
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 500
    }
  }
}
