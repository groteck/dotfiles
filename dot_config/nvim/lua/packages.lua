-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Add Treesitter magic lets see how it goes
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  -- Fuzzy them all AKA Telescope + :crap:
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',

    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-tree/nvim-web-devicons'

  -- Auto comment with a macro
  use 'tomtom/tcomment_vim'

  -- Undo history search
  use 'mbbill/undotree'

  -- Multiple cursors
  use { 'mg979/vim-visual-multi', branch = 'master' }

  -- Surrounding text macros
  use 'tpope/vim-surround'

  -- Visual indent lines
  use "lukas-reineke/indent-blankline.nvim"

  -- Colorscheme
  use 'beikome/cosme.vim'

  -- LSP Autocomplete
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  use 'github/copilot.vim'

  -- use {
  --   'zbirenbaum/copilot.lua',
  --   event = 'VimEnter',
  --   config = function()
  --     vim.defer_fn(function()
  --       require('copilot').setup()
  --     end, 100)
  --   end,
  -- }
  --
  -- use {
  --   'zbirenbaum/copilot-cmp',
  --   after = { 'copilot.lua' },
  --   config = function()
  --     require('copilot_cmp').setup()
  --   end
  -- }

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- File explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
end)
