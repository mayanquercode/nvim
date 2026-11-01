local defaults = require("config.lsp.defaults")

return {
  on_attach = defaults.on_attach,
  on_init = defaults.on_init,
  capabilities = defaults.capabilities,
  init_options = {
    userLanguages = {
      javascript = "javascriptreact",
      typescript = "typescriptreact",
    },
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      includeLanguages = {
        html = "html", css = "css",
        javascript = "javascript", typescript = "typescript",
        javascriptreact = "javascriptreact", typescriptreact = "typescriptreact",
      },
    },
  },
}
