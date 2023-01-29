-- Default options:
require("kanagawa").setup({
	commentStyle = { italic = false },
	keywordStyle = { italic = false },
	statementStyle = { bold = true },
	variablebuiltinStyle = { italic = false },
})

require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	no_italic = true,
	transparent_background = false,
})

vim.g.nightflyTransparent = true
vim.g.nightflyItalics = false

-- setup must be called before loading
-- vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme ayu")
-- vim.cmd([[colorscheme nightfly]])
vim.cmd([[colorscheme catppuccin]])
