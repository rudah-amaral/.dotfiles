return {
  -- Manages LSPs, DAPs and formatters
  "williamboman/mason.nvim",
  dependencies = {
    -- Automatically sets up lua-language-server and +
    "folke/neodev.nvim",
    -- LSPs
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    -- Formatters and linters
    "jose-elias-alvarez/null-ls.nvim",
    "jay-babu/mason-null-ls.nvim",
    -- Completion capabilities
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local has_null_ls_formatter = function(file_type)
      local sources = require("null-ls.sources")
      return #sources.get_available(file_type, "NULL_LS_FORMATTING") > 0
    end

    local format = function(bufnr)
      local buffer_filetype = vim.bo[bufnr].filetype

      vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
          if has_null_ls_formatter(buffer_filetype) then
            return client.name == "null-ls"
          end
          return true
        end,
      })
    end

    local formatting_group = vim.api.nvim_create_augroup("Formatting Group", {})
    local format_on_write = function(bufnr)
      vim.api.nvim_clear_autocmds({ group = formatting_group, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = formatting_group,
        buffer = bufnr,
        callback = function()
          format(bufnr)
        end
      })
    end

    -- nvim-cmp supports additional completion capabilities, so broadcast that to
    -- servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- LSP settings.
    -- This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(client, bufnr)
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

      if client.supports_method("textDocument/formatting") then
        format_on_write(bufnr)
      end
    end

    -- The following language servers will automatically be installed. Use their
    -- lspconfig names.

    -- Add any additional override configuration in the following tables. They will
    -- be passed to the `settings` field of the server config and serve as the
    -- default settings. Configure per project using their respective settings file.
    local servers = {
      cssls = {},
      jsonls = {},
      lua_ls = {
        -- Configuration file: .luarc.json
        Lua = {
          telemetry = { enable = false },
          workspace = { checkThirdParty = false },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
      texlab = {},
      tsserver = {},
      vimls = {
        -- Barely customizable, no config file
      },
    }

    require("neodev").setup()
    require("mason").setup()

    local mason_lspconfig = require("mason-lspconfig")
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

    require("mason-null-ls").setup({
      ensure_installed = {
        "prettierd",
        "eslint_d",
      },
      automatic_installation = false,
      handlers = {},
    })

    local null_ls = require("null-ls")
    null_ls.setup({
      on_attach = on_attach
    })
  end
}
