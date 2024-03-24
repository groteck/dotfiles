return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = function()
      local highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      }

      return {
        scope = {
          enabled = true,
          show_start = true,
          show_end = true,
        },
        indent = { highlight = highlight },
        exclude = {
          buftypes = { 'DressingInput' },
          filetypes = {
            'DressingInput',
            'DressingSelect',
            'OverseerList',
            'OverseerForm',
          },
        },
      }
    end,
  },
}
