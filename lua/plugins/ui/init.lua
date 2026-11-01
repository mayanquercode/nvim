-- UI plugins
-- Themes, statusline, buffers, etc.

local ui = require("config.ui")

return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = ui.lualine,
  },

  -- Buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = ui.bufferline,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    main = "ibl",
    opts = ui.indent_blankline,
  },

  -- Notifications
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = ui.notify,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Which key - Shows key bindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = ui.which_key,
  },

  -- Scrollbar
  --{
  --  "petertriho/nvim-scrollbar",
  --  branch = "v1", -- Fijar a la rama v1
  --   event = "VeryLazy",
  --   opts = ui.scrollbar,
  -- },
}
