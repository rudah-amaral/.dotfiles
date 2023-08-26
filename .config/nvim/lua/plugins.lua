local packerPath = vim.fn.stdpath("data") ..
        "/site/pack/packer/start/packer.nvim"
local isPackerFirstInstall
if vim.fn.empty(vim.fn.glob(packerPath)) == 1 then
  local packerRepo = "https://github.com/wbthomason/packer.nvim"
  isPackerFirstInstall = vim.fn.system({ "git", "clone", "--depth", "1",
    packerRepo, packerPath })
end

local getSetup = function(fileName)
  local ext = string.sub(fileName, -3, -1)
  if ext == "lua" then
    return string.format('require("setup/%s")', string.sub(fileName, 1, -5))
  elseif ext == "vim" then
    local setupFolder = vim.fn.stdpath("config") .. "/lua/setup"
    return string.format('vim.cmd("source ' .. setupFolder .. '/%s")', fileName)
  end
end

local packer = require("packer")
packer.startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")
  -- The Big Guns™
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = getSetup("tree-sitter.lua"),
  })
  use({
    -- Manages LSPs, DAPs and formatters
    "williamboman/mason.nvim",
    requires = {
      -- Automatically sets up lua-language-server and +
      "folke/neodev.nvim",
      -- LSPs
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      -- Formatters and linters
      "jose-elias-alvarez/null-ls.nvim",
      "jay-babu/mason-null-ls.nvim"
    },
    config = getSetup("mason.lua"),
  })
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = getSetup("cmp.lua"),
  })
  use({
    "mattn/emmet-vim",
    config = getSetup("emmet.vim"),
  })
  use({
    "lervag/vimtex",
    config = getSetup("vimtex.vim"),
  })
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
      },
    },
    config = getSetup("telescope.lua"),
  })
  -- Themes and alike
  use({
    "sainnhe/everforest",
    config = "vim.cmd[[colorscheme everforest]]",
  })
  use({
    "Mofiqul/dracula.nvim",
    setup = getSetup("dracula.lua"),
  })
  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      opt = true,
    },
    config = getSetup("lualine.lua"),
  })
  use({
    "xiyaowong/nvim-transparent",
    config = getSetup("nvim-transparent.lua"),
  })
  use({
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    config = getSetup("indent_blankline.lua"),
  })
  -- The ones that pack a punch
  use({
    "tpope/vim-fugitive",
    config = getSetup("fugitive.lua"),
  })
  use({
    "lewis6991/gitsigns.nvim",
    config = getSetup("gitsigns.lua"),
  })
  use("tpope/vim-unimpaired")
  use("tpope/vim-surround")
  use({
    "numToStr/Comment.nvim",
    config = getSetup("Comment.lua"),
  })
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  })
  use("ThePrimeagen/vim-be-good")
  use("mateusbraga/vim-spell-pt-br")
  use("matze/vim-move")
  use {
    "stevearc/oil.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      opt = true,
    },
    config = getSetup("oil.lua")
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if isPackerFirstInstall then
    packer.sync()
  end
end)

loadstring(getSetup("netrw.vim"))()
loadstring(getSetup("joke.vim"))()

local sourceAndCompileGroup = vim.api.nvim_create_augroup("packer_user_config", {
  clear = true,
})
vim.api.nvim_create_autocmd("BufWritePost", {
  group = sourceAndCompileGroup,
  pattern = vim.fn.expand("~/.config/nvim/lua/plugins.lua"),
  command = "source % | PackerCompile",
})
