return {
  'tpope/vim-surround',
  config = function()
    vim.cmd [[
      let g:surround_{char2nr('m')} = "\1Surround: \1\r\1\1"
      let g:surround_{char2nr('M')} = "\1S-Open: \1\r\2S-Close: \2"
    ]]
  end,
}
