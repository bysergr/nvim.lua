-- Default options:
require("kanagawa").setup({
	commentStyle = { italic = false },
	keywordStyle = { italic = false },
	statementStyle = { bold = false },
	variablebuiltinStyle = { italic = false },
	transparent = true,
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
		},
	},
})

-- Lua
require("onedark").setup({
	style = "darker",
})
require("onedark").load()

require("tokyonight").setup({
	style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	transparent = false, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		comments = { italic = false },
		keywords = { italic = false },
	},
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
