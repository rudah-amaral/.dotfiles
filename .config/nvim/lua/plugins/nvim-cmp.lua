return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp"
    },
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<c-d>"] = cmp.mapping.scroll_docs(-4),
        ["<c-f>"] = cmp.mapping.scroll_docs(4),
        ["<c-e>"] = cmp.mapping.close(),
        -- ["<c-y>"] = cmp.mapping.confirm {
        --   behavior = cmp.ConfirmBehavior.Insert,
        --   select = true,
        -- },
        ["<c-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<c-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            return
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<c-Space>"] = cmp.mapping.complete({}),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }
    })
  end
}
