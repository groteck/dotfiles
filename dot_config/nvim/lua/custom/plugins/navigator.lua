return { -- Tmux integration
  'numToStr/Navigator.nvim',
  opts = {},
  keys = {
    { '<C-h>', '<CMD>NavigatorLeft<CR>', desc = '[N]avigate to the left Tmux pane/vim split' },
    { '<C-l>', '<CMD>NavigatorRight<CR>', desc = '[N]avigate to the right Tmux pane/vim split' },
    { '<C-k>', '<CMD>NavigatorUp<CR>', desc = '[N]avigate to the above Tmux pane/vim split' },
    { '<C-j>', '<CMD>NavigatorDown<CR>', desc = '[N]avigate to the below Tmux pane/vim split' },
    { '<C-p>', '<CMD>NavigatorPrevious<CR>', desc = '[N]avigate to left Tmux pane/vim split' },
  },
}
