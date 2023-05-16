-- Default options:
require("kanagawa").setup({
	commentStyle = { italic = false },
	keywordStyle = { italic = false },
	statementStyle = { bold =  false},
	variablebuiltinStyle = { italic = false },
  transparent = true,
})

require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	no_italic = true,
	transparent_background = false,
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")
-- vim.cmd([[colorscheme catppuccin]])
-- vim.cmd("colorscheme everblush")
