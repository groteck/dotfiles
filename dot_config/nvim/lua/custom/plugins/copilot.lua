return { -- Copilot client
  'github/copilot.vim',
  init = function()
    vim.keymap.set('i', ',/', 'copilot#Accept()', {
      desc = 'Copilot accept suggestion',
      -- fix some estrange codes inserted after competition
      replace_keycodes = false,
      silent = true,
      expr = true,
    })
    -- Copilot Alt doesn't work on mac
    vim.keymap.set('i', ',>', '<Plug>(copilot-next)', {
      desc = 'Copilot next suggestion',
      -- fix some estrange codes inserted after competition
      replace_keycodes = false,
      silent = true,
      expr = true,
    })

    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
  end,
}
