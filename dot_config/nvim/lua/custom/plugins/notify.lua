return { -- Notifications popup
  'rcarriga/nvim-notify',
  opts = {
    stages = 'fade_in_slide_out',
    timeout = 5000,
    icons = {
      ERROR = '',
      WARN = '',
      INFO = '',
      DEBUG = '',
      TRACE = '✎',
    },
  },
}
