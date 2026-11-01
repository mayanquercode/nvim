local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

-- Buffers
keymap("n", "<Tab>",   ":BufferLineCycleNext<CR>", opts) -- Siguiente buffer
keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts) -- Buffer anterior
keymap("i", "<Tab>", "<Esc>:BufferLineCycleNext<CR>", opts) -- Siguiente buffer en modo insertar
keymap("i", "<S-Tab>", "<Esc>:BufferLineCyclePrev<CR>", opts)   -- Buffer anterior en modo insertar
keymap("n", "<leader><Tab>", ":bd<CR>", opts)      -- Cerrar buffer
keymap("n", "<C-s>", ":w<CR>", opts)              -- Guardar buffer
keymap("i", "<C-s>", "<Esc>:w<CR>a", opts)        -- Guardar buffer (insertar)
-- En modo normal, presiona las teclas numéricas para saltar directamente al buffer de la posición correspondiente
keymap("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)

-- General
keymap("i", "jk", "<ESC>", opts)                     -- Volver a modo normal con jk
keymap("n", "<leader>z", "<cmd>set wrap!<CR>", opts) -- Alternar ajuste de línea
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)    -- Quitar resaltado de búsqueda
keymap({ "n", "v" }, "U", "<C-r>", opts)             -- Rehacer
keymap("v", "p", '"_dP', opts)                       -- Pegar sin sobrescribir el registro con lo reemplazado
keymap("n", "+", "<C-a>", opts)                      -- Incrementar número bajo el cursor
keymap("n", "-", "<C-x>", opts)                      -- Decrementar número bajo el cursor
keymap("x", "+", "<C-a>gv", opts)                    -- Incrementar número bajo el cursor (visual)
keymap("x", "-", "<C-x>gv", opts)                    -- Decrementar número bajo el cursor (visual)

-- Navegación
keymap("n", "J", "6j", opts)          -- Bajar 6 líneas
keymap("n", "K", "6k", opts)          -- Subir 6 líneas
keymap("n", "H", "^", opts)           -- Ir al primer carácter de la línea
keymap("n", "L", "$", opts)           -- Ir al final de la línea
keymap("n", "<C-u>", "<C-u>zz", opts) -- Centrar tras subir media página
keymap("n", "<C-d>", "<C-d>zz", opts) -- Centrar tras bajar media página

-- Ventanas
keymap("n", "<leader>v", ":vsplit<CR>", opts)           -- Split vertical
keymap("n", "<leader>s", ":split<CR>", opts)            -- Split horizontal
keymap("n", "<Up>", ":resize +2<CR>", opts)             -- Aumentar tamaño de ventana
keymap("n", "<Down>", ":resize -2<CR>", opts)           -- Reducir tamaño de ventana
keymap("n", "<Right>", ":vertical resize -2<CR>", opts) -- Reducir tamaño de ventana (vertical)
keymap("n", "<Left>", ":vertical resize +2<CR>", opts)  -- Aumentar tamaño de ventana (vertical)

-- Mantener modo visual tras indentar
keymap("v", "<", "<gv", opts) -- Mantener selección visual tras desindentar
keymap("v", ">", ">gv", opts) -- Mantener selección visual tras indentar

-- Mover texto hacia arriba y abajo en bloque visual
keymap("x", "<Up>", ":m '<-2<CR>gv=gv", opts)   -- Mover selección hacia arriba
keymap("x", "<Down>", ":m '>+1<CR>gv=gv", opts) -- Mover selección hacia abajo

-- LSP
keymap("n", "gh", vim.lsp.buf.hover, opts)           -- Mostrar información flotante (hover)
keymap("n", "gH", vim.diagnostic.open_float, opts)   -- Mostrar diagnóstico flotante
keymap("n", "<F2>", vim.lsp.buf.rename, opts)        -- Renombrar símbolo
keymap("n", "gd", vim.lsp.buf.definition, opts)      -- Ir a la definición
keymap("n", "gy", vim.lsp.buf.type_definition, opts) -- Ir a la definición de tipo
