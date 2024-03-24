return { -- Dim none focussed pannels
  'levouh/tint.nvim',
  opts = {
    tint_background_colors = false,
    tint = -45, -- Darken colors, use a positive value to brighten
    saturation = 0.5, -- Saturation to preserve
    highlight_ignore_patterns = { 'WinSeparator', 'NormalNC', 'Normal', 'TabLine', 'TabLineFill', 'TabLineSel' },
  },
}
