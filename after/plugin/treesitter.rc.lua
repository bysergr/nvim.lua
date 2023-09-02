local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

ts.setup({
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	ensure_installed = {
		"tsx",
		"lua",
		"cpp",
		"go",
		"rust",
		"python",
		"css",
		"html",
		"json5",
		"javascript",
		"typescript",
		"markdown",
		"markdown_inline",
	},
	autotag = {
		enable = true,
	},
})
