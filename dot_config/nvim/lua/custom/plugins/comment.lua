return {
  'numToStr/Comment.nvim',
  opts = {
    pre_hook = function()
      return vim.bo.commentstring
    end,
  },
  lazy = false,
  dependencies = {
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      lazy = true,
      opts = {
        enable = true,
        enable_autocmd = false,
      },
      config = function(_, opts)
        vim.g.skip_ts_context_commentstring_module = true

        require('ts_context_commentstring').setup(opts)
      end,
    },
  },
  config = function(_, opts)
    require('Comment').setup(opts)
  end,
}
