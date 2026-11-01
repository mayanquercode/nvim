local helpers = require("config.lsp.helpers")

local M = {}

M.setup = function(on_demand)
  local lazy_installing = {}

  local function try_enable_lsp(buf, cfg)
    helpers.poll_binary(cfg.bin, 15, 1000, function()
      pcall(vim.lsp.enable, cfg.server)
      if #vim.lsp.get_clients({ name = cfg.server, bufnr = buf }) > 0 then
        vim.notify(string.format("%s ready", cfg.server), vim.log.levels.INFO)
      end
    end)
  end

  local augroup = vim.api.nvim_create_augroup("lazy_lsp_setup", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    callback = function(args)
      local buf = args.buf
      local ft = vim.bo[buf].filetype
      local cfg = on_demand[ft]
      if not cfg then return end

      -- 1. LSP
      local clients = vim.lsp.get_clients({ name = cfg.server, bufnr = buf })
      if #clients == 0 then
        if vim.fn.executable(cfg.bin) == 1 then
          pcall(vim.lsp.enable, cfg.server)
        else
          vim.schedule(function()
            local reg = helpers.get_mason_registry()
            if not reg then return end
            local ok, pkg = pcall(reg.get_package, cfg.mason)
            if not ok then return end

            if pkg:is_installed() then
              try_enable_lsp(buf, cfg)
            elseif not lazy_installing[cfg.mason] then
              lazy_installing[cfg.mason] = true
              vim.notify(string.format("Installing %s via Mason...", cfg.mason), vim.log.levels.INFO)
              pkg:on("install:success", function()
                vim.schedule(function() try_enable_lsp(buf, cfg) end)
              end)
              pkg:install()
            end
          end)
        end
      end

      -- 2. Formatters + Treesitter
      vim.schedule(function()
        local reg = helpers.get_mason_registry()
        if not reg then return end

        for _, fm in ipairs(cfg.mason_fmt or {}) do
          if not lazy_installing[fm] then
            lazy_installing[fm] = true
            local ok, pkg_fmt = pcall(reg.get_package, fm)
            if ok and not pkg_fmt:is_installed() then
              vim.notify(string.format("Installing formatter %s...", fm), vim.log.levels.INFO)
              pkg_fmt:install()
            end
          end
        end

        if cfg.ts then
          local ts = helpers.get_treesitter()
          if not ts then return end
          if vim.tbl_contains(ts.get_installed(), cfg.ts) then
            pcall(vim.treesitter.start, buf)
            return
          end
          vim.notify(string.format("Installing treesitter parser for %s...", cfg.ts), vim.log.levels.INFO)
          vim.cmd("TSInstall " .. cfg.ts)
          helpers.poll_parser(cfg.ts, 15, 2000, function()
            pcall(vim.treesitter.start, buf)
            vim.notify(string.format("Parser %s ready", cfg.ts), vim.log.levels.INFO)
          end)
        end
      end)
    end,
  })

  return lazy_installing
end

return M
