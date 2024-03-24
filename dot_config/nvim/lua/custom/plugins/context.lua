return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'BufEnter',
  enabled = true,
  opts = {
    mode = 'cursor',
    max_lines = 10,
    line_numbers = true,
    enable = true,
  },
  keys = {
    {
      '[c',
      function()
        require('treesitter-context').go_to_context(vim.v.count1)
      end,
      {
        silent = true,
        desc = 'Go to [C]ontext',
      },
    },
  },
}
