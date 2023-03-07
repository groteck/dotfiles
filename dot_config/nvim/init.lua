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

-- Visual remaps
vim.keymap.set("v", "J", ":m '>+1< colorsR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- OSX Option mapping
vim.keymap.set("n", "<M-]>", "<D-]>")

-- Plugin config

-- LSP config

local cfg = {
    toggle_key = '<M-x>',          -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}
require 'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key
local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')
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

require('neodev').setup()

-- Enable neodev
lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace"
            }
        }
    }
})

vim.keymap.set('n', ',j', vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set('n', ',k', vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set('n', ',d', vim.lsp.buf.code_action, { noremap = true })
vim.keymap.set('n', ',,', vim.lsp.buf.signature_help, { noremap = true })

-- Add extra sources
local lspkind = require('lspkind')
local cmp_sources = lsp.defaults.cmp_sources()
require('crates').setup()

table.insert(cmp_sources, { name = 'crates' })

lsp.setup_nvim_cmp({
    mapping = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',       -- show only symbol annotations
            maxwidth = 100,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(_, vim_item)
                return vim_item
            end
        })
    },
    sources = cmp_sources
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
-- Copilot Alt doesnt work on mac
vim.api.nvim_set_keymap("i", ",>", '<Plug>(copilot-next)', { silent = true, expr = true })

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

-- Status line
require('lualine').setup {
    options = {
        theme = "catppuccin"
    },
    sections = {
        lualine_x = { "overseer" },
    },
}

-- empty setup using defaults
require("nvim-tree").setup()
vim.keymap.set('n', ',dd', '<cmd>NvimTreeToggle<CR>')

-- indent lines
vim.opt.list = true
vim.opt.listchars:append "space:⋅"

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
    buftype_exclude = { "DressingInput" },
    filetype_exclude = { "DressingInput", "DressingSelect", "OverseerList", "OverseerForm" },
}

-- Telescope (Fuzzy finder)
local telescope = require('telescope')

-- Telescope keymaps
vim.keymap.set('n', ',fl', '<cmd>Telescope current_buffer_fuzzy_find theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',ff', '<cmd>Telescope find_files theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fg', '<cmd>Telescope live_grep theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fb', '<cmd>Telescope buffers theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fh', '<cmd>Telescope help_tags theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fv', '<cmd>Telescope git_files theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fk', '<cmd>Telescope keymaps theme=get_ivy layout_config={height=0.5}<CR>')

-- Telescope config
-- telescope.load_extension('fzf')

telescope.setup({
    defaults = {
        file_ignore_patterns = { "node_modules" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    },
})

-- Undo tree
vim.keymap.set('n', ',u', '<cmd>UndotreeToggle<CR>')

-- Surround
vim.cmd [[
let g:surround_{char2nr('m')} = "\1Surround: \1\r\1\1"
let g:surround_{char2nr('M')} = "\1S-Open: \1\r\2S-Close: \2"
]]

-- Tmux navigation
-- Keybindings
require('Navigator').setup({})

vim.keymap.set('n', "<C-h>", '<CMD>NavigatorLeft<CR>')
vim.keymap.set('n', "<C-l>", '<CMD>NavigatorRight<CR>')
vim.keymap.set('n', "<C-k>", '<CMD>NavigatorUp<CR>')
vim.keymap.set('n', "<C-j>", '<CMD>NavigatorDown<CR>')
vim.keymap.set('n', "<C-p>", '<CMD>NavigatorPrevious<CR>')

vim.keymap.set('n', "<M-h>", '<CMD>vertical resize +5<CR>')
vim.keymap.set('n', "<M-l>", '<CMD>vertical resize -5<CR>')
vim.keymap.set('n', "<M-k>", '<CMD>resize +5<CR>')
vim.keymap.set('n', "<M-j>", '<CMD>resize -5<CR>')

-- Tab navigation
vim.keymap.set('n', '<TAB>', '<CMD>tabn<CR>')
vim.keymap.set('n', '<S-TAB>', '<CMD>tabp<CR>')

-- Sart screen on empty buffer Telescope
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    pattern = { "*" },
    callback = function()
        if vim.fn.argc() == 0 and vim.fn.line2byte(vim.fn.line('$')) == -1
            and not vim.opt.insertmode:get() then
            require("telescope.builtin").find_files()
        end
    end
    ,
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

-- TreeSitter

require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
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

require 'treesitter-context'.setup {
    enable = true,
}

-- Overseer Task runner
require('overseer').setup()

-- Trouble
require("trouble").setup()

-- Vim Ilumuminate
-- default configuration
require('illuminate').configure({
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
})

-- Git Signs
require('gitsigns').setup {
    current_line_blame = true,
}

-- Colors
vim.t_Co = 256
vim.opt.syntax = 'enable'
vim.opt.colorcolumn = '80'
vim.opt.hlsearch = true
vim.opt.termguicolors = true -- set termguicolors to enable highlight groups


-- display hex colors
require('colorizer').setup()


-- Transparent background
vim.g.transparent_enabled = true

--- Catppuccin theme config

require("catppuccin").setup({
    transparent_background = vim.g.transparent_enabled,
    show_end_of_buffer = true, -- show the '~' characters after the end of buffers
    term_colors = true,
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
vim.cmd.colorscheme "catppuccin-mocha"

-- base = "#1E1E2E",
-- blue = "#89B4FA",
-- crust = "#11111B",
-- flamingo = "#F2CDCD",
-- green = "#A6E3A1",
-- lavender = "#B4BEFE",
-- mantle = "#181825",
-- maroon = "#EBA0AC",
-- mauve = "#CBA6F7",
-- overlay0 = "#6C7086",
-- overlay1 = "#7F849C",
-- overlay2 = "#9399B2",
-- peach = "#FAB387",
-- pink = "#F5C2E7",
-- red = "#F38BA8",
-- rosewater = "#F5E0DC",
-- sapphire = "#74C7EC",
-- sky = "#89DCEB",
-- subtext0 = "#A6ADC8",
-- subtext1 = "#BAC2DE",
-- surface0 = "#313244",
-- surface1 = "#45475A",
-- surface2 = "#585B70",
-- teal = "#94E2D5",
-- text = "#CDD6F4",
-- yellow = "#F9E2AF"
local mocha = require("catppuccin.palettes").get_palette "mocha"
local colors = { bg = mocha.crust, fg = mocha.text }
vim.api.nvim_set_hl(0, "NormalFloat", colors)
vim.api.nvim_set_hl(0, "FloatBorder", colors)
vim.api.nvim_set_hl(0, "OverseerComponent", colors)
vim.api.nvim_set_hl(0, "OverseerField", colors)
vim.api.nvim_set_hl(0, "OverseerTask", colors)
vim.api.nvim_set_hl(0, "OverseerTaskBorder", colors)


-- Dim inactive window
require('tint').setup({
    tint_background_colors = false,
    tint = -45,       -- Darken colors, use a positive value to brighten
    saturation = 0.5, -- Saturation to preserve
    highlight_ignore_patterns = { "WinSeparator", 'NormalNC', 'Normal', 'TabLine', 'TabLineFill', 'TabLineSel', },
});
