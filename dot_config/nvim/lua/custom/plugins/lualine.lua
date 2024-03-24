return { -- Status line
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      theme = 'catppuccin',
    },
    sections = {
      lualine_x = { 'overseer' },
    },
  },
  dependencies = { 'kyazdani42/nvim-web-devicons' },
}
