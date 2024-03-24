return {
  'catppuccin/nvim', -- My colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  opts = {
    transparent_background = true,
    show_end_of_buffer = true, -- show the '~' characters after the end of buffers
    term_colors = true,
    custom_highlights = function(colors)
      local colorPair = { bg = colors.crust, fg = colors.text }

      return {
        NormalFloat = colorPair,
        FloatBorder = colorPair,
        OverseerComponent = colorPair,
        OverseerField = colorPair,
        OverseerTask = colorPair,
        OverseerTaskBorder = colorPair,
      }
    end,
    integrations = {
      -- For plugins integrations (https://github.com/catppuccin/nvim#integrations)
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      telescope = {
        enabled = true,
      },
      notify = true,
      treesitter = true,
      treesitter_context = true,
      rainbow_delimiters = true,
      indent_blankline = {
        enabled = true,
        sope_color = true,
        colored_indent_levels = true,
      },
      illuminate = {
        enabled = true,
        lsp = false,
      },
      neotest = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
        },
        inlay_hints = {
          background = true,
        },
      },
      fidget = true,
      mason = true,
      semantic_tokens = true,
      which_key = true,
    },
  },
  init = function()
    vim.t_Co = 256
    vim.opt.syntax = 'enable'
    vim.opt.hlsearch = true
    vim.opt.termguicolors = true -- set termguicolors to enable highlight groups
    vim.g.transparent_enabled = true
    vim.cmd.colorscheme 'catppuccin-mocha'

    -- You can configure highlights by doing something like
    -- vim.cmd.hi 'Comment gui=none'

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
  end,
  config = function(_, opts)
    require('catppuccin').setup(opts)
  end,
}
