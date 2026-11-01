local M = {}

-- Cargar mason-registry bajo demanda
function M.get_mason_registry()
  local ok, reg = pcall(require, "mason-registry")
  if ok then return reg end
  local lazy_ok, lazy = pcall(require, "lazy")
  if lazy_ok then lazy.load({ plugins = { "mason.nvim" } }) end
  local ok2, reg2 = pcall(require, "mason-registry")
  return ok2 and reg2 or nil
end

-- Cargar nvim-treesitter bajo demanda
function M.get_treesitter()
  local ok, ts = pcall(require, "nvim-treesitter")
  if ok then return ts end
  local lazy_ok, lazy = pcall(require, "lazy")
  if lazy_ok then lazy.load({ plugins = { "nvim-treesitter" } }) end
  local ok2, ts2 = pcall(require, "nvim-treesitter")
  return ok2 and ts2 or nil
end

-- Poll hasta que el binario esté en PATH
function M.poll_binary(bin, max_attempts, interval, cb)
  local timer, done, n = vim.uv.new_timer(), false, 0
  timer:start(interval or 1000, interval or 1000, vim.schedule_wrap(function()
    if done then return end
    n = n + 1
    if n > (max_attempts or 15) then done = true; timer:close(); return end
    if vim.fn.executable(bin) ~= 1 then return end
    done = true; timer:close()
    cb()
  end))
end

-- Poll hasta que el parser de treesitter esté instalado
function M.poll_parser(ts_parser, max_attempts, interval, cb)
  local ts = M.get_treesitter()
  if not ts then return end
  local done, n = false, 0
  local timer = vim.uv.new_timer()
  timer:start(interval or 2000, interval or 2000, vim.schedule_wrap(function()
    if done then return end
    n = n + 1
    if n > (max_attempts or 15) then done = true; timer:close(); return end
    if not vim.tbl_contains(ts.get_installed(), ts_parser) then return end
    done = true; timer:close()
    cb()
  end))
end

return M
