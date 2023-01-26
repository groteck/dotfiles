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

    use 'nvim-treesitter/playground' -- Treesitter playground

    use 'mrjones2014/nvim-ts-rainbow' -- Color pharentesis

    use { -- Context on the top
        'nvim-treesitter/nvim-treesitter-context',
        requires = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require 'treesitter-context'.setup {
                enable = true,
            }
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
    use { "catppuccin/nvim", as = "catppuccin" }

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

    -- Tmux integration
    use {
        'numToStr/Navigator.nvim',
    }

    -- Test framework
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
            "rouge8/neotest-rust"
        }
    }

    -- Rust stuff
    use {
        'simrat39/rust-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig'

        }
    }

    use {
        'saecki/crates.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require('crates').setup()
        end,
    }

    -- Linters formatters
    use { "jose-elias-alvarez/null-ls.nvim",
        "jay-babu/mason-null-ls.nvim",
    }

    -- Improve UI
    use { 'levouh/tint.nvim' } -- Active panel highlight
    use { 'stevearc/dressing.nvim' } -- Generl ui improvements
    use { 'rcarriga/nvim-notify' } -- Notifications
    use { 'RRethy/vim-illuminate' } -- Highlight word under cursor
    use { 'xiyaowong/nvim-transparent' } -- Transparent background

    -- Task runner
    use {
        'stevearc/overseer.nvim',
        config = function() require('overseer').setup() end
    }

end)
