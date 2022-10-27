require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"sumneko_lua",
		"rust_analyzer",
		"clangd",
		"astro",
		"gopls",
		"pyright",
		"sqllss",
		"tsserver",
		"cssls",
		"emmet_ls",
	},
	automatic_installation = true,
})

require("mason-null-ls").setup({
	ensure_installed = {
		"blue",
		"eslint_d",
		"prettierd",
		"rubocop",
		"sql_formatter",
		"stylua",
		"gofumpt",
		"clang_format",
	},
	automatic_installation = true,
})
