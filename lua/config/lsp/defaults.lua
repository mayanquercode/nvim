local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  M.capabilities = cmp_lsp.default_capabilities(M.capabilities)
end

M.on_attach = function(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "K", vim.lsp.buf.hover, "Hover")
  map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
  map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
  map("n", "gr", vim.lsp.buf.references, "References")
  map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics list")
  map("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, "Format buffer")

  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("lsp_highlight_" .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group, buffer = bufnr, callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = group, buffer = bufnr, callback = vim.lsp.buf.clear_references,
    })
  end
end

M.on_init = function(client)
  if client.supports_method and client:supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = client.bufnr })
  end
end

return M
