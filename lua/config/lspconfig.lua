local defaults = require("config.lsp.defaults")
local registry = require("config.lsp.registry")
local autocmd  = require("config.lsp.autocmd")
local commands = require("config.lsp.commands")

-- 1. Registrar configs custom (servers/*.lua) si existen
local custom_servers = { "ts_ls", "tailwindcss" }  -- añade aquí los que crees
for _, name in ipairs(custom_servers) do
  local ok, cfg = pcall(require, "config.lsp.servers." .. name)
  if ok then
    vim.lsp.config(name, cfg)
  end
end

-- 2. Registrar el resto desde registry (sin tocar los custom)
for _, cfg in pairs(registry) do
  if not vim.tbl_contains(custom_servers, cfg.server) then
    vim.lsp.config(cfg.server, {
      on_attach = defaults.on_attach,
      on_init = defaults.on_init,
      capabilities = defaults.capabilities,
    })
  end
end

-- 3. Autocmd lazy + comando
local lazy_installing = autocmd.setup(registry)
commands.setup(registry, lazy_installing)
