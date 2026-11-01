return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  event = "BufReadPre",
  build = ":TSUpdate",
  config = function()
    -- Instala los parsers que necesites (se puede llamar sin argumentos para instalar todos los de la lista)
    require("nvim-treesitter").install({
      "html", "css", "javascript", "typescript", "tsx",
      "bash", "json", "markdown", "markdown_inline",
      "yaml", "toml", "lua", "vim", "vimdoc",
      "dockerfile", "gitignore", "regex", "query",
    })

    -- Activa resaltado e indentación manualmente al abrir un archivo
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        -- Intenta iniciar treesitter (fallará silenciosamente si el parser no está listo)
        local ok = pcall(vim.treesitter.start, ev.buf)
        if ok then
          -- Configura la indentación basada en treesitter
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
