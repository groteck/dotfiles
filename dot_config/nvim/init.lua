require("packages")

-- General config
--
-- Disable nvim intro
vim.opt.shortmess:append "sI"

-- Disable builtins plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Disable mouse click to go to position
vim.opt.mouse = ""

-- Spaces instead of tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Ignore files
vim.opt.wildignore = {
    '*/bower_vendor_libs/**',
    '*/vendor/**',
    '*/node_modules/**',
    '*/elm-stuff/**'
}

-- Spell check
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-- Vim command line size
vim.noshowmode = true

-- Numbers
vim.opt.nu = true
vim.opt.relativenumber = true


-- Colors
vim.t_Co = 256
vim.opt.syntax = 'enable'
vim.opt.background = 'dark'
vim.opt.colorcolumn = '80'
vim.opt.hlsearch = true
vim.cmd.colorscheme "catppuccin-mocha"
vim.opt.termguicolors = true -- set termguicolors to enable highlight groups


require("catppuccin").setup({
    integrations = {
        -- For plugins integrations (https://github.com/catppuccin/nvim#integrations)
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        treesitter = true,
        treesitter_context = true,
        ts_rainbow = true,
        overseer = true,
        illuminate = true,
        neotest = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
        indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
        },

    },
})

-- Visual remaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Plugin config

-- LSP config


local lsp = require('lsp-zero')
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

lsp.preset('recommended')

lsp.configure('pylsp', {
    settings = {
        pylsp = {
            plugins = {
                -- enable black formatting
                black = {
                    enabled = true,
                    cache_config = true,
                },
                -- enable flake8 linting
                flake8 = {
                    enabled = true,
                },
                -- disable pycodestyle
                pycodestyle = {
                    enabled = true,
                },
                -- enable mypy type checking
                mypy = {
                    enabled = true,
                },
                -- enable isort
                isort = {
                    enabled = true,
                },
            }
        }
    }
})

vim.keymap.set('n', ',j', vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set('n', ',k', vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set('n', ',d', vim.lsp.buf.code_action, { noremap = true })
vim.keymap.set('n', ',,', vim.lsp.buf.signature_help, { noremap = true })

-- Add extra sources
local cmp_sources = lsp.defaults.cmp_sources()
table.insert(cmp_sources, { name = 'crates' })

lsp.setup_nvim_cmp({
    mapping = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require('luasnip').expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
            elseif vim.b._copilot_suggestion ~= nil then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes(vim.fn['copilot#Accept'](), true, true, true), '')
            else
                fallback()
            end
        end, {
            'i',
            's',
        }),
    }),
    sources = cmp_sources
})

lsp.setup_nvim_cmp({
})

lsp.set_preferences({
    set_lsp_keymaps = { omit = { '<C-k>' } }
})

lsp.nvim_workspace()

-- Left rust lsp to be init by rust-tools
lsp.skip_server_setup({ 'rust-analyzer' })

lsp.setup()

-- Rust Tools
--  LSP Rust Settings
local rust_lsp = lsp.build_options('rust-analyzer', {
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
            inlayHints = { locationLinks = false }
        }
    }
})

require('rust-tools').setup({ server = rust_lsp })

-- Copilot
vim.api.nvim_set_keymap("i", ",/", 'copilot#Accept()', { silent = true, expr = true })
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
-- vim.cmd [[let g:copilot_no_tab_map = v:true]]
-- vim.cmd [[let g:copilot_assume_mapped = v:true]]

-- Status line
require('lualine').setup {
    options = {
        theme = "catppuccin"
    }
}

-- empty setup using defaults
require("nvim-tree").setup()
vim.keymap.set('n', ',dd', '<cmd>NvimTreeToggle<CR>')

-- indent lines
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

-- Telescope (Fuzzy finder)
-- Telescope keymaps
vim.keymap.set('n', ',fl', '<cmd>Telescope current_buffer_fuzzy_find theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',ff', '<cmd>Telescope find_files theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fg', '<cmd>Telescope live_grep theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fb', '<cmd>Telescope buffers theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fh', '<cmd>Telescope help_tags theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fv', '<cmd>Telescope git_files theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fk', '<cmd>Telescope keymaps theme=get_ivy layout_config={height=0.5}<CR>')

-- Telescope config
require('telescope').load_extension('fzf')

-- Undo tree
vim.keymap.set('n', ',u', '<cmd>UndotreeToggle<CR>')

-- Surround
vim.cmd [[
let g:surround_{char2nr('m')} = "\1Surround: \1\r\1\1"
let g:surround_{char2nr('M')} = "\1S-Open: \1\r\2S-Close: \2"
]]

-- Tmux navigation
-- Keybindings
--
require('Navigator').setup()

vim.keymap.set('n', "<C-h>", '<CMD>NavigatorLeft<CR>')
vim.keymap.set('n', "<C-l>", '<CMD>NavigatorRight<CR>')
vim.keymap.set('n', "<C-k>", '<CMD>NavigatorUp<CR>')
vim.keymap.set('n', "<C-j>", '<CMD>NavigatorDown<CR>')
vim.keymap.set('n', "<C-p>", '<CMD>NavigatorPrevious<CR>')

-- Sart screen
vim.api.nvim_exec([[
fun! Start()
    " Don't run if: we have commandline arguments, we don't have an empty
    " buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
    if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
        return
    endif

    " Open explorer
    execute ':lua require("telescope.builtin").find_files()'
endfun
]], false)


local startFun = "g:Start"

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    pattern = { "*" },
    callback = startFun,
})

-- Neotest
local neotest = require("neotest")

vim.keymap.set('n', ',tt', function() neotest.run.run() end)
vim.keymap.set('n', ',tf', function() neotest.run.run(vim.fn.expand("%")) end)
vim.keymap.set('n', ',tp', function() neotest.output_panel.toggle() end)
vim.keymap.set('n', ',ts', function() neotest.summary.toggle() end)

require("neotest").setup({
    adapters = {
        require("neotest-python"),
        require("neotest-rust"),
    },
    diagnostic = {
        enabled = true,
        severity = 1
    },
    log_level = 3,
    output = {
        enabled = true,
        open_on_run = "short"
    },
    output_panel = {
        enabled = true,
    },
    run = {
        enabled = true
    },
    status = {
        enabled = true,
        virtual_text = true
    },
    consumers = {
        overseer = require("neotest.consumers.overseer"),
    },
})

-- Formatters
local formatterG = vim.api.nvim_create_augroup('FormatAutogroup', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = '*',
    group = formatterG,
    command = "silent! LspZeroFormat"
})

require("mason-null-ls").setup({
    automatic_installation = false,
    automatic_setup = true, -- Recommended, but optional
})
local null_ls = require "null-ls"

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
--
null_ls.setup {
    sources = {
        formatting.black,
        formatting.isort,
        diagnostics.flake8,
        diagnostics.mypy,
    }
}

require 'mason-null-ls'.setup_handlers() -- If `automatic_setup` is true.

-- TreeSitter
require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1500,
    },
    context_commentstring = {
        enable = true,
    },
    matchup = {
        enable = true,
    },
    auto_install = true,
}

-- Overseer Task runner
require('overseer').setup()

-- Vim Ilumuminate

-- default configuration
require('illuminate').configure({
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
})

-- Improve active pannel UI
require("tint").setup()

-- Transparent background
require("transparent").setup({
    enable = true, -- boolean: enable transparent
    extra_groups = {}, -- table/string: additional groups that should be cleared
    exclude = {}, -- table: groups you don't want to clear
})
