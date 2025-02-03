return {
  -- Manages LSPs, DAPs and formatters
  "williamboman/mason.nvim",
  dependencies = {
    -- Provides basic Nvim LSP client configurations for LSP servers.
    "neovim/nvim-lspconfig",
    -- Auto-installs and sets handlers for LSPs
    "williamboman/mason-lspconfig.nvim",
    -- Ensures formatters and linters are installed
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- Completion capabilities
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require("mason").setup()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- nvim-cmp supports additional completion capabilities, so broadcast that to
    -- servers
    local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol
      .make_client_capabilities())

    -- LSP settings.
    -- This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      -- nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

      nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
      nmap("gr", require("telescope.builtin").lsp_references,
        "[G]oto [R]eferences")
      nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
      nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
      -- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      -- nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

      -- See `:help K` for why this keymap
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

      -- -- Lesser used LSP functionality
      -- nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      -- nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      -- nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      -- nmap("<leader>wl", function()
      --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      -- end, "[W]orkspace [L]ist Folders")
    end

    -- The following language servers will automatically be installed. Use their
    -- lspconfig names.

    -- Add any additional override configuration in the following tables. They will
    -- be passed to the `settings` field of the server config and serve as the
    -- default settings. Configure per project using their respective settings file.
    local servers = {
      cssls = {},
      jsonls = {},
      texlab = {},
      ts_ls = {},
      vimls = {},
    }

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        -- Every installed server gets:
        require("lspconfig")[server_name].setup({
          -- completion
          capabilities = capabilities,
          -- mappings and user commands
          on_attach    = on_attach,
          -- Override server's default configuration
          settings     = servers[server_name],
        })
      end,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettierd",
        "eslint_d"
      }
    })
  end
}
