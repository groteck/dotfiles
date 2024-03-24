return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {},
  keys = {
    { ',dd', '<cmd>NvimTreeToggle<CR>', { desc = '[D]isplay [D]irectory Tree' } },
  },
}
