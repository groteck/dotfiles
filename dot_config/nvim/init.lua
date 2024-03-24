--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your nvim config.

--]]

--[[

   INFO: This configuration started from 
   https://github.com/nvim-lua/kickstart.nvim

    If you want to do it from scratch (I realy recomend to do it). 
    Clone the kickstart.nvim into the project and use some inspiration from:
      1. https://www.lazyvim.org/plugins
        I'm not a fan of distributions but folke is realy good and all the plugins
        are documented so you can copy paste and update the config to your taste
      2. https://www.youtube.com/watch?v=m8C0Cq9Uv9o
        TJ DeVries needs no presentation, but he created kickstart and invest a
        lot of time helping the Vim/Neovim comunity. This video uses this config
        so you have a good gideline about how to create something like this config
      3. This configuration 
        I tried to do it as simple as possible and with a lot of comments to help
        understand what is happening and my reasons behind the choices I made.

--]]

--[[

  NOTE: Disable builtins plugins

   This plugins are disabled because they are not needed or they are replaced by
   a none native plugin.

--]]
--
local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}

-- Loop over the disabled_built_ins list
for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

-- Spaces instead of tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Ignore files
vim.opt.wildignore = {
  '*/bower_vendor_libs/**',
  '*/vendor/**',
  '*/node_modules/**',
  '*/elm-stuff/**',
}

-- Spell check
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-- Set , as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Disable mouse click to go to position
vim.opt.mouse = ''

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Visual remaps
vim.keymap.set('v', 'J', ":m '>+1< colorsR>gv=gv", { desc = '[M]ove visual section up' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = '[M]ove visual section down' })

-- OSX Option mapping
vim.keymap.set('n', '<M-]>', '<D-]>')

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', ',k', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ',j', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- NOTE: navigation with ctl + hjkl will be manage by Navigator plugin for
-- Tmux pane integration

-- Resize pannels with alt + hjkl
vim.keymap.set('n', '<M-h>', '<CMD>vertical resize +5<CR>')
vim.keymap.set('n', '<M-l>', '<CMD>vertical resize -5<CR>')
vim.keymap.set('n', '<M-k>', '<CMD>resize +5<CR>')
vim.keymap.set('n', '<M-j>', '<CMD>resize -5<CR>')

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- NOTE: Custom start screen
--
-- If I start nvin without any argument usually I want to edit a file and using
-- fuzzy finding as the default way of looking for a file seems natural to me.
-- Sart screen on empty buffer Telescope
vim.opt.shortmess:append 'sI' -- Disable default intro
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  pattern = { '*' },
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.line2byte(vim.fn.line '$') == -1 and not vim.opt.insertmode:get() then
      require('telescope.builtin').find_files()
    end
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, you can run
--    :Lazy update
require('lazy').setup({
  --[[
     NOTE: Next step on your Neovim journey:
     Add/Configure additional plugins for kickstart

     NOTE: The import below can automatically add your own plugins, 
     configuration, etc from `lua/custom/plugins/*.lua`
      This is the easiest way to modularize your config.
  --]]
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you have a Nerd Font, set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
