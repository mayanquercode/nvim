local helpers = require("config.lsp.helpers")

local M = {}

M.setup = function(on_demand, lazy_installing)
  vim.api.nvim_create_user_command("ReinstallLang", function(args)
    local ft = args.args
    local cfg = on_demand[ft]
    if not cfg then
      local list = table.concat(vim.tbl_keys(on_demand), ", ")
      vim.notify("Soportado: " .. list, vim.log.levels.ERROR)
      return
    end

    lazy_installing[cfg.mason] = nil

    if cfg.mason then vim.cmd("MasonInstall " .. cfg.mason) end
    for _, fm in ipairs(cfg.mason_fmt or {}) do
      lazy_installing[fm] = nil
      vim.cmd("MasonInstall " .. fm)
    end
    if cfg.ts then vim.cmd("TSInstall " .. cfg.ts) end

    helpers.poll_binary(cfg.bin, 30, 1000, function()
      pcall(vim.lsp.enable, cfg.server)
      vim.notify(string.format("%s reinstalado para %s", cfg.server, ft), vim.log.levels.INFO)
    end)

    vim.notify(string.format("Reinstalando herramientas para %s...", ft), vim.log.levels.INFO)
  end, {
    nargs = 1,
    complete = function() return vim.tbl_keys(on_demand) end,
    desc = "Reinstalar LSP, formatters y treesitter para un lenguaje",
  })
end

return M
