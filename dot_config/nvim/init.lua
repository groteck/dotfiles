require("packages")

-- General config

-- 2 spaces for indenting
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0

-- 2 stops
vim.opt.tabstop = 2

-- Disable mouse click to go to position
vim.opt.mouse = 'a'

-- Spaces instead of tabs
vim.opt.expandtab = true

-- Ignore files
vim.opt.wildignore = {
  '*/bower_vendor_libs/**',
  '*/vendor/**',
  '*/node_modules/**',
  '*/elm-stuff/**'
}

-- Spell check
vim.spelllang = 'en_us'

-- Vim command line size
vim.noshowmode = true

-- Numbers
vim.relativenumber = true

-- Colors
vim.t_Co = 256
vim.opt.syntax = 'enable'
vim.opt.background = 'dark'
vim.opt.colorcolumn = '80'
vim.opt.hlsearch = true
vim.cmd [[colorscheme cosme]]


-- LSP config
local lsp = require('lsp-zero')
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

lsp.preset('recommended')

vim.keymap.set('n', ',j', vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set('n', ',k', vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set('n', ',d', vim.lsp.buf.code_action, { noremap = true })
vim.keymap.set('n', ',,', vim.lsp.buf.signature_help, { noremap = true })


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
  })
})

lsp.preset('recommended')

lsp.nvim_workspace()
lsp.setup()

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = "LspZeroFormat"
})

-- Copilot
vim.api.nvim_set_keymap("i", "<C-/>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

vim.cmd [[let g:copilot_no_tab_map = v:true]]
vim.cmd [[let g:copilot_assume_mapped = v:true]]

-- Status line
require('lualine').setup()

-- File explorer config
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

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
-- Telescope
vim.keymap.set('n', ',fl', '<cmd>Telescope current_buffer_fuzzy_find theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',ff', '<cmd>Telescope find_files theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fg', '<cmd>Telescope live_grep theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fb', '<cmd>Telescope buffers theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fh', '<cmd>Telescope help_tags theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fv', '<cmd>Telescope git_files theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fp', '<cmd>Telescope planets theme=get_ivy layout_config={height=0.5}<CR>')
vim.keymap.set('n', ',fk', '<cmd>Telescope keymaps theme=get_ivy layout_config={height=0.5}<CR>')

-- Undo tree
vim.keymap.set('n', ',u', '<cmd>UndotreeToggle<CR>')

-- Surround
vim.cmd [[
let g:surround_{char2nr('m')} = "\1Surround: \1\r\1\1"
let g:surround_{char2nr('M')} = "\1S-Open: \1\r\2S-Close: \2"
]]
