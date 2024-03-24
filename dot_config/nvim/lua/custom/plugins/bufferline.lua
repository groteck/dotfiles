return { -- Tabs decoration
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
  opts = {
    options = {
      mode = 'tabs',
      diagnostics = 'nvim_lsp',
      indicator = {
        style = 'underline',
      },
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          text_align = 'center',
          separator = true,
        },
      },
      color_icons = true,
      show_close_icon = false,
      show_buffer_close_icons = false,
      separator_style = 'thick',
    },
  },
  config = function(_, opts)
    opts.highlights = require('catppuccin.groups.integrations.bufferline').get()
    require('bufferline').setup(opts)
  end,
}
