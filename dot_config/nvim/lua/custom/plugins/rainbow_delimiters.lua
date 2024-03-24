return {
  'https://gitlab.com/HiPhish/rainbow-delimiters.nvim', -- Color pharentesis
  opts = function()
    local rainbow_delimiters = require 'rainbow-delimiters'

    return {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      priority = {
        [''] = 110,
        lua = 210,
      },
    }
  end,
  config = function(_, opts)
    require('rainbow-delimiters.setup').setup(opts)
  end,
}
