vim.g.mapleader = " " -- Tecla líder (barra espaciadora)

-- Números de línea
vim.opt.number = true -- Muestra el número de línea absoluto

-- Ventanas y paneles (splits)
vim.opt.splitbelow = true   -- Abre los nuevos paneles debajo del actual
vim.opt.splitright = true   -- Abre los nuevos paneles a la derecha del actual
vim.o.winborder = "rounded" -- Bordes redondeados para ventanas flotantes

-- Interfaz visual
vim.opt.cursorline = true    -- Resalta la línea donde está el cursor
vim.opt.wrap = false         -- No envuelve las líneas largas visualmente
vim.opt.spell = false        -- Desactiva el corrector ortográfico
vim.o.background = "dark"    -- Usa la paleta de colores para fondo oscuro
vim.opt.termguicolors = true -- Activa un rango de colores mayor al que tiene por defecto
vim.opt.signcolumn = "yes:2" -- Muestra siempre la columna de signos (diagnósticos, git, etc.) con ancho de 2

-- Indentación y tabulaciones
vim.opt.expandtab = false  -- Usa tabs en lugar de espacios
vim.opt.tabstop = 4        -- Cantidad de espacios que representa un tab
vim.opt.shiftwidth = 4     -- Espacios de indentación al usar >> o <<
vim.opt.smartindent = true -- Indenta automáticamente según el código
vim.opt.breakindent = true -- Las líneas envueltas respetan la indentación
vim.opt.autoindent = true  -- Copia la indentación de la línea anterior, sin importar el código

-- Portapapeles y archivos temporales
vim.opt.clipboard = "unnamedplus" -- Sincroniza el portapapeles con el del sistema
vim.opt.swapfile = false          -- Desactiva los archivos swap para recuperar cambios ante un cierre inesperado

-- Búsqueda
vim.opt.ignorecase = true -- Las búsquedas no distinguen mayúsculas de minúsculas
vim.opt.smartcase = true  -- Ignora 'ignorecase' si el patrón de búsqueda contiene mayúsculas

-- Diagnósticos (LSP)
vim.diagnostic.config({
	virtual_text = { current_line = true, prefix = " ", }, -- Muestra el texto del diagnóstico solo en la línea actual

	-- Símbolos personalizados para cada tipo de diagnóstico
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.INFO] = "󰙎",
			[vim.diagnostic.severity.HINT] = "󰌵",
			[vim.diagnostic.severity.WARN] = "",
		},
	},
})

-- Autocomandos
-- Resalta el texto brevemente al copiarlo (yank)
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Edición y movimiento del cursor
-- Nos permite transformar todos los caracteres y espacios del documento en una celda
-- Muy util para cuando utilizamos el modo de visual block (ctrl + v)
vim.opt.virtualedit = "block"

-- Muestra una ventana con el preview de los resultados de una sustitución
vim.opt.inccommand = "split"

-- Cantidad de líneas a mantener arriba y abajo del cursor.
-- Podemos dejar 999 para que el cursor siempre se encuentre en la mitad de la pantalla.
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 15 -- Cantidad de columnas a mantener a los lados del cursor

